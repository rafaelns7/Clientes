unit Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.Actions,
  Vcl.ActnList,
  System.ImageList,
  Vcl.ImgList,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  Vcl.ComCtrls,
  Vcl.Imaging.pngimage,
  CadCliente;

type
  TfMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PanelWorkArea: TPanel;
    Button1: TButton;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActionCadCliente: TAction;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure ActionCadClienteExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FFormActive: TForm;
    procedure LoadForm(AClass: TFormClass);
  public
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.ActionCadClienteExecute(Sender: TObject);
begin
  Self.LoadForm(TfCadCliente);
end;

procedure TfMain.LoadForm(AClass: TFormClass);
begin
  if Assigned(Self.FFormActive) then
  begin
    Self.FFormActive.Close;
    Self.FFormActive.Free;
    Self.FFormActive := nil;
  end;

  Self.FFormActive             := AClass.Create(nil);
  Self.FFormActive.Parent      := Self.PanelWorkArea;
  Self.FFormActive.BorderStyle := TFormBorderStyle.bsNone;

  Self.FFormActive.Top   := 0;
  Self.FFormActive.Left  := 0;
  Self.FFormActive.Align := TAlign.alClient;

  Self.FFormActive.Show;
end;

procedure TfMain.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := DateTimeToStr(now);
end;

end.
