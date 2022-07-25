unit Cliente.int;

interface
  uses XMLIntf;

type

  ICliente = Interface
    ['{8E4C7F64-3477-48F3-97DC-D10AF3ECB555}']
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
    function SetUF(Value: string): ICliente; overload;
    function SetCEP(Value: string): ICliente; overload;
    function SetPessoa(Value: string): ICliente; overload;
    function SetInscricaoFiscal(Value: string): ICliente; overload;

    function GetNome: string; overload;
    function GetNascimento: TDate; overload;
    function GetTelefone: string; overload;
    function GetEmail: string; overload;
    function GetTipoLogradouro: string; overload;
    function GetNomeLogradouro: string; overload;
    function GetNumero: string; overload;
    function GetComplemento: string; overload;
    function GetBairro: string; overload;
    function GetCidade: string; overload;
    function GetUF: string; overload;
    function GetCEP: string; overload;
    function GetPessoa: string; overload;
    function GetInscricaoFiscal: string; overload;

    function GravaDados: IXMLDocument;
  End;
implementation

end.
