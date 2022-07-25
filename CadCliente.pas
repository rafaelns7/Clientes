unit CadCliente;

interface

uses
  System.RegularExpressions,
  System.JSON,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.ComCtrls,
  REST.Types,
  REST.Response.Adapter,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Utils,
  XMLIntf,
  XMLDoc,
  Cliente.Impl,
  InscricaoFiscal;

type
  TfCadCliente = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtIdCliente: TEdit;
    edtNome: TEdit;
    dtDataNascimento: TDateTimePicker;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    edtInscricaoFiscal: TEdit;
    edtTipoLogradouro: TEdit;
    edtlogradouro: TEdit;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtCep: TEdit;
    Label15: TLabel;
    rdTipoPessoa: TRadioGroup;
    lblLoadCep: TLabel;
    procedure edtCepExit(Sender: TObject);
    procedure edtInscricaoFiscalExit(Sender: TObject);
    procedure edtInscricaoFiscalEnter(Sender: TObject);
    procedure edtTelefoneExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FDocDados: IXMLDocument;
    procedure LimpaCampos;
    function ValidaCampos(pErros: TStringList): Boolean;
  public
    { Public declarations }
  end;

var
  fCadCliente: TfCadCliente;

implementation

{$R *.dfm}

procedure TfCadCliente.Button1Click(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TfCadCliente.Button3Click(Sender: TObject);
var
  lErros: TStringList;
  lMsg: string;
  I: Integer;
  lTipo: string;
begin
  lErros := TStringList.Create;
  try
    if not (ValidaCampos(lErros)) then
    begin
      if (rdTipoPessoa.ItemIndex = 0) then
        lTipo := 'F'
      else
        lTipo := 'J';
      FDocDados:= nil;
      FDocDados:= TCliente.New
                       .SetNome(edtNome.Text)
                       .SetNascimento(dtDataNascimento.Date)
                       .SetTelefone(edtTelefone.Text)
                       .SetEmail(edtEmail.Text)
                       .SetPessoa(lTipo)
                       .SetInscricaoFiscal(edtInscricaoFiscal.Text)
                       .SetCEP(edtCep.Text)
                       .SetTipoLogradouro(edtTipoLogradouro.Text)
                       .SetNomeLogradouro(edtlogradouro.Text)
                       .SetNumero(edtNumero.Text)
                       .SetComplemento(edtComplemento.Text)
                       .SetBairro(edtBairro.Text)
                       .SetCidade(edtCidade.Text)
                       .SetUF(edtUF.Text)
                       .GravaDados();


      if Assigned(FDocDados) then  begin
         if EnviaEmail(FDocDados)then
           ShowMessage('E-Mail enviado com sucesso!')
         else
           ShowMessage('Erro ao enviar E-Mail!');
      end;

    end else begin
      for I := 0 to Pred(lErros.Count) do
        lMsg:= lMsg + lErros[I] + #13;

      ShowMessage(lMsg);
      exit;
    end;

  finally
    FreeAndNil(lErros);
  end;
end;

procedure TfCadCliente.edtCepExit(Sender: TObject);
var
  lJson: TJSONObject;
begin
  lblLoadCep.Visible := True;
  edtCep.Text := Formatar(edtCep.Text,TFormato.CEP);
  lJson := ConsultaCep(edtCep.Text);

  if(lJson = nil) then
  begin
    ShowMessage('CEP não encontrado, por favor verifique.');
    exit;
  end;

  lblLoadCep.Visible  := False;
  edtlogradouro.Text  := lJson.Get('logradouro').JsonValue.Value;
  edtComplemento.Text := lJson.Get('complemento').JsonValue.Value;
  edtBairro.Text      := lJson.Get('bairro').JsonValue.Value;
  edtCidade.Text      := UpperCase(lJson.Get('localidade').JsonValue.Value);
  edtUF.Text          := lJson.Get('uf').JsonValue.Value;
end;

procedure TfCadCliente.edtInscricaoFiscalEnter(Sender: TObject);
begin
  if (rdTipoPessoa.ItemIndex = -1) then
  begin
    ShowMessage('O tipo de pessoa não foi definido');
    rdTipoPessoa.SetFocus;
  end;
end;

procedure TfCadCliente.edtInscricaoFiscalExit(Sender: TObject);
var
  lDoc: string;
  lValidador: TInscricaoFiscal;
  lDocValido: Boolean;
begin
  if (edtInscricaoFiscal.Text = '') then
    exit;

  lDocValido := False;
  lDoc := SomenteNumero(edtInscricaoFiscal.Text);

  lValidador := TInscricaoFiscal.Create;
  try
    if rdTipoPessoa.ItemIndex = 0 then
      lDocValido := lValidador.CPFDocumentoValido(lDoc)
    else if rdTipoPessoa.ItemIndex = 1 then
      lDocValido := lValidador.CNPJDocumentoValido(lDoc);

    if (lDocValido) then
      edtInscricaoFiscal.Text := Formatar(edtInscricaoFiscal.Text,TFormato.CNPJorCPF)
    else
    begin
     ShowMessage('Documento inválido');
     edtInscricaoFiscal.Clear;
    end;
  finally
   FreeAndNil(lValidador);
  end;
end;

procedure TfCadCliente.edtTelefoneExit(Sender: TObject);
begin
  edtTelefone.Text := Formatar(edtTelefone.Text,TFormato.Telefone);
end;

procedure TfCadCliente.FormCreate(Sender: TObject);
begin
  FDocDados:= TXMLDocument.Create(nil);
end;

procedure TfCadCliente.LimpaCampos;
begin
  edtIdCliente.Clear;
  edtNome.Clear;
  dtDataNascimento.Date:= Now;
  edtTelefone.Clear;
  edtEmail.Clear;
  rdTipoPessoa.ItemIndex:= -1;
  edtInscricaoFiscal.Clear;
  edtCep.Clear;
  edtTipoLogradouro.Clear;
  edtlogradouro.Clear;
  edtComplemento.Clear;
  edtBairro.Clear;
  edtNumero.Clear;
  edtCidade.Clear;
  edtUF.Clear;
end;

function TfCadCliente.ValidaCampos(pErros: TStringList): Boolean;
begin
  Result:= False;

  if (edtNome.Text = '') then begin
    pErros.Add('Nome não foi informado.');
    Result:= True;
  end;

  if (dtDataNascimento.Date = Now) then begin
    pErros.Add('Data de nascimento não foi informado.');
    Result:= True;
  end;

  if (edtTelefone.Text = '') then begin
    pErros.Add('Telefone não foi informado.');
    Result:= True;
  end;

  if (edtEmail.Text = '') then begin
    pErros.Add('E-Mail não foi informado.');
    Result:= True;
  end;

  if (rdTipoPessoa.ItemIndex = -1) then begin
    pErros.Add('Tipo pessoa não foi informado.');
    Result:= True;
  end;

  if (edtCep.Text = '') then begin
    pErros.Add('Cep não foi informado.');
    Result:= True;
  end;

  if (edtlogradouro.Text = '') then begin
    pErros.Add('Logradouro não foi informado.');
    Result:= True;
  end;

  if (edtNumero.Text = '') then begin
    pErros.Add('Número não foi informado.');
    Result:= True;
  end;

  if (edtBairro.Text = '') then begin
    pErros.Add('Bairro não foi informado.');
    Result:= True;
  end;

  if (edtCidade.Text = '') then begin
    pErros.Add('Cidade não foi informado.');
    Result:= True;
  end;

  if (edtUF.Text = '') then begin
    pErros.Add('UF não foi informado.');
    Result:= True;
  end;
end;

end.
