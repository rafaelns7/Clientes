program Clientes;

uses
  Vcl.Forms,
  Main in 'Main.pas' {fMain},
  CadCliente in 'CadCliente.pas' {fCadCliente},
  InscricaoFiscal in 'InscricaoFiscal.pas',
  Cliente.int in 'Cliente.int.pas',
  Cliente.Impl in 'Cliente.Impl.pas',
  Utils in 'Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
