unit Utils;

interface
  uses  System.SysUtils,
  System.JSON,
  Classes,
  System.MaskUtils,
  FMX.Edit,
  XMLIntf,
  XMLDoc,
  idHTTP,
  IdSSLOpenSSL,
  IdSMTP, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase;

type
   TFormato = (CNPJ, CPF, InscricaoEstadual, CNPJorCPF, TelefoneFixo, Celular,
     Personalizado, CEP, Telefone);

   function Formatar(pValue: string; Formato : TFormato; Extra : string = ''): string;
   function SomenteNumero(str : string) : string;
   function ConsultaCep(pCEP: string): TJSONObject;
   function EnviaEmail(pArquivo: IXMLDocument):Boolean;
   procedure AddTagXML(pXML:IXMLDocument; pTag, pValue: string);


implementation


procedure AddTagXML(pXML: IXMLDocument; pTag, pValue: string);
begin
  pXML.XML.Add('<' + pTag + '>' + pValue + '</' + pTag  + '>');
end;

function ConsultaCep(pCEP: string): TJSONObject;
var
  lHTTP: TIdHTTP;
  lIDSSLHandler : TIdSSLIOHandlerSocketOpenSSL;
  lResponse: TStringStream;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  lCep: string;
begin
  Result := nil;
  lHTTP := TIdHTTP.Create;
  lIDSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
  IdSSL:= TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  lCep := SomenteNumero(pCEP);
  lResponse := TStringStream.Create('');
  try
    lHTTP.IOHandler := lIDSSLHandler;
    lHTTP.IOHandler := IdSSL;
    IdSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
    lHTTP.Get('https://viacep.com.br/ws/' + lCep + '/json', lResponse);
    if (lHTTP.ResponseCode = 200) and not(Utf8ToAnsi(lResponse.DataString) = '{'#$A'  "erro": true'#$A'}') then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes( Utf8ToAnsi(lResponse.DataString)), 0) as TJSONObject;
  finally
    FreeAndNil(lHTTP);
    FreeAndNil(lIDSSLHandler);
    lResponse.Destroy;
  end;
end;

function EnviaEmail(pArquivo: IXMLDocument):Boolean;
var
  lIdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  lIdSMTP: TIdSMTP;
  lIdMessage: TIdMessage;
  lIdText: TIdText;
  lAnexo: string;
begin

  lIdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  lIdSMTP := TIdSMTP.Create(nil);
  lIdMessage := TIdMessage.Create(nil);
  try
    lIdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
    lIdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;
    lIdSSLIOHandlerSocket.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

    lIdSMTP.IOHandler := lIdSSLIOHandlerSocket;
    lIdSMTP.UseTLS := utUseExplicitTLS;
    lIdSMTP.AuthType := satDefault;
    lIdSMTP.Port := 587;
    lIdSMTP.Host := 'smtp.gmail.com';
    lIdSMTP.Username := '********@gmail.com';
    lIdSMTP.Password := '**********';

    lIdMessage.From.Address := 'rafaelns7@gmail.com';
    lIdMessage.From.Name := 'Rafael Nunes';
    lIdMessage.ReplyTo.EMailAddresses := lIdMessage.From.Address;
    lIdMessage.Recipients.Add.Text := 'rafaelns7@email.com';
    lIdMessage.Subject := 'Cadastro de Clientes';
    lIdMessage.Encoding := meMIME;

    lIdText := TIdText.Create(lIdMessage.MessageParts);
    lIdText.Body.Add('Corpo do e-mail');
    lIdText.ContentType := 'text/plain; charset=iso-8859-1';

    lAnexo := 'C:\temp\teste2.xml';
    if FileExists(lAnexo) then
    begin
       TIdAttachmentFile.Create(lIdMessage.MessageParts, lAnexo);
    end;

    try
      lIdSMTP.Connect;
      lIdSMTP.Authenticate;
      Result := True;
      except
        on E:Exception do
      begin
        Result:=False;
      end;
    end;

    try
      lIdSMTP.Send(lIdMessage);
      except
      On E:Exception do
      begin
        Result:=False;
      end;
    end;
  finally
    lIdSMTP.Disconnect;
    UnLoadOpenSSLLibrary;
    FreeAndNil(lIdMessage);
    FreeAndNil(lIdSSLIOHandlerSocket);
    FreeAndNil(lIdSMTP);
  end;
end;

function SomenteNumero(str : string) : string;
var
  x : PChar;
begin
  x := PChar(str);
  Result := '';
  while (x^ <> #0) do begin
    {$IFDEF UNICODE}
    if CharInSet(x^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + x^;
    Inc(x);
  end;
end;

function Mask(Mascara, Str : string) : string;
var
  x, p : integer;
begin
  p := 0;
  Result := '';

  if Str.IsEmpty then
      exit;

  for x := 0 to Length(Mascara) - 1 do
  begin
    if Mascara.Chars[x] = '#' then
    begin
      Result := Result + Str.Chars[p];
      inc(p);
    end
    else
      Result := Result + Mascara.Chars[x];

    if p = Length(Str) then
      break;
  end;
end;

function Formatar(pValue: string; Formato : TFormato; Extra : string = ''): string;
var
  texto : string;
begin
  // Celular...
  if formato = Celular then
    texto := Mask('(##) #####-####', SomenteNumero(pValue));

  if formato = Telefone then
    texto := Mask('(##) ####-####', SomenteNumero(pValue));

  // CNPJ...
  if formato = CNPJ then
    texto := Mask('##.###.###/####-##', SomenteNumero(pValue));

  // CPF...
  if formato = CPF then
    texto := Mask('###.###.###-##', SomenteNumero(pValue));

  // CNPJ ou CPF...
  if formato = CNPJorCPF then
  begin
    if Length(SomenteNumero(texto)) <= 11 then
      texto := Mask('###.###.###-##', SomenteNumero(pValue))
    else
      texto := Mask('##.###.###/####-##', SomenteNumero(pValue));
  end;

  // Personalizado...
  if formato = Personalizado then
    texto := Mask(Extra, SomenteNumero(pValue));

  // CEP...
  if Formato = CEP then
    texto := Mask('#####-###', SomenteNumero(pValue));

  Result := texto;
end;
end.
