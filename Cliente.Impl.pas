unit Cliente.Impl;

interface
uses Cliente.int,
  System.SysUtils,
  Utils,
  XMLIntf,
  XMLDoc;

type
  TCliente = class(TInterfacedObject, ICliente)
  private
    FNome: string;
    FNascimento: TDate;
    FTelefone: string;
    FEmail: string;
    FTipoLogradouro: string;
    FNomeLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FCidade: string;
    FUF: string;
    FCEP: string;
    FPessoa: string;
    FInscricaoFiscal: string;

    function SetNome(Value: string): ICliente; overload;
    function SetNascimento(Value: TDate): ICliente; overload;
    function SetTelefone(Value: string): ICliente; overload;
    function SetEmail(Value: string): ICliente; overload;
    function SetTipoLogradouro(Value: string): ICliente; overload;
    function SetNomeLogradouro(Value: string): ICliente; overload;
    function SetNumero(Value: string): ICliente; overload;
    function SetComplemento(Value: string): ICliente; overload;
    function SetBairro(Value: string): ICliente; overload;
    function SetCidade(Value: string): ICliente; overload;
    function SetUF(Value: string): ICliente;  overload;
    function SetCEP(Value: string): ICliente;  overload;
    function SetPessoa(Value: string): ICliente; overload;
    function SetInscricaoFiscal(Value: string): ICliente; overload;

    function GetNome: string; overload;
    function GetNascimento: TDate; overload;
    function GetTelefone: string; overload;
    function GetEmail: string; overload;
    function GetTipoLogradouro: string; overload;
    function GetNomeLogradouro: string; overload;
    function GetNumero: string;  overload;
    function GetComplemento: string; overload;
    function GetBairro: string; overload;
    function GetCidade: string; overload;
    function GetUF: string;  overload;
    function GetCEP: string; overload;
    function GetPessoa: string; overload;
    function GetInscricaoFiscal: string; overload;
  public
     Constructor Create;
     destructor Destroy; override;
     class function New: ICliente;

     function GravaDados: IXMLDocument;
  end;

implementation

  { TCliente }

constructor TCliente.Create;
begin

end;

destructor TCliente.Destroy;
begin

  inherited;
end;

function TCliente.GetBairro: string;
begin
  Result := Self.FBairro;
end;

function TCliente.GetCEP: string;
begin
  Result := Self.FCep;
end;

function TCliente.GetCidade: string;
begin
  Result := Self.FCidade;
end;

function TCliente.GetComplemento: string;
begin
  Result := Self.FComplemento;
end;

function TCliente.GetEmail: string;
begin
  Result := Self.FEmail;
end;

function TCliente.GetInscricaoFiscal: string;
begin
  Result := Self.FInscricaoFiscal;
end;

function TCliente.GetNascimento: TDate;
begin
  Result := Self.FNascimento;
end;

function TCliente.GetNome: string;
begin
  Result := Self.FNome;
end;

function TCliente.GetNomeLogradouro: string;
begin
  Result := Self.FNomeLogradouro;
end;

function TCliente.GetNumero: string;
begin
  Result := Self.FNumero;
end;

function TCliente.GetPessoa: string;
begin
  Result := Self.FPessoa;
end;

function TCliente.GetTelefone: string;
begin
  Result := Self.FTelefone;
end;

function TCliente.GetTipoLogradouro: string;
begin
  Result := Self.FTipoLogradouro;
end;

function TCliente.GetUF: string;
begin
  Result := Self.FUF;
end;

function TCliente.GravaDados: IXMLDocument;
var
  lDocXML: IXMLDocument;
begin

  lDocXML := TXMLDocument.Create(nil);
  lDocXML.Active := True;
  lDocXML.XML.Add('<Cliente>');
  AddTagXML(lDocXML,'Nome',Self.FNome);
  AddTagXML(lDocXML,'Nascimento',FormatDateTime('DD/MM/YYYY',Self.FNascimento));
  AddTagXML(lDocXML,'Teleone',Self.FTelefone);
  AddTagXML(lDocXML,'Email',Self.FEmail);
  AddTagXML(lDocXML,'TipoLogradouro',Self.FTipoLogradouro);
  AddTagXML(lDocXML,'Logradouro',Self.FNomeLogradouro);
  AddTagXML(lDocXML,'Numero',Self.FNumero);
  AddTagXML(lDocXML,'Complemento',Self.FComplemento);
  AddTagXML(lDocXML,'Bairro',Self.FBairro);
  AddTagXML(lDocXML,'cidade',Self.FCidade);
  AddTagXML(lDocXML,'Uf',Self.FUF);
  AddTagXML(lDocXML,'Cep',Self.FCEP);
  AddTagXML(lDocXML,'Pessoa',Self.FPessoa);
  AddTagXML(lDocXML,'InscricaoFiscal',Self.FInscricaoFiscal);
  lDocXML.XML.Add('</Cliente>');
  lDocXML.Active := True;
  lDocXML.SaveToFile('C:\TEMP\Cliente.XML');
  Result := lDocXML;
end;

class function TCliente.New: ICliente;
begin
  Result := Self.Create;
end;

function TCliente.SetBairro(Value: string): ICliente;
begin
  Result  := Self;
  FBairro := Value;
end;

function TCliente.SetCEP(Value: string): ICliente;
begin
  Result := Self;
  FCEP   := Value;
end;

function TCliente.SetCidade(Value: string): ICliente;
begin
  Result := Self;
  FCidade:= Value;
end;

function TCliente.SetComplemento(Value: string): ICliente;
begin
  Result := Self;
  FComplemento := Value;
end;

function TCliente.SetEmail(Value: string): ICliente;
begin
  Result := Self;
  FEmail := Value;
end;

function TCliente.SetInscricaoFiscal(Value: string): ICliente;
begin
  Result := Self;
  FInscricaoFiscal := Value;
end;

function TCliente.SetNascimento(Value: TDate): ICliente;
begin
  Result := Self;
  FNascimento := Value;
end;

function TCliente.SetNome(Value: string): ICliente;
begin
  Result := Self;
  FNome  := Value;
end;

function TCliente.SetNomeLogradouro(Value: string): ICliente;
begin
  Result := Self;
  FNome  := Value;
end;

function TCliente.SetNumero(Value: string): ICliente;
begin
  Result := Self;
  FNumero:= Value;
end;

function TCliente.SetPessoa(Value: string): ICliente;
begin
  Result  := Self;
  FPessoa := Value;
end;

function TCliente.SetTelefone(Value: string): ICliente;
begin
  Result := Self;
  FTelefone := Value;
end;

function TCliente.SetTipoLogradouro(Value: string): ICliente;
begin
  Result := Self;
  FTipoLogradouro := Value;
end;

function TCliente.SetUF(Value: string): ICliente;
begin
  Result := Self;
  FUF    := Value;
end;

end.
