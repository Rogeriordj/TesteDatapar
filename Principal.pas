unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons, uCalculo,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Calcular1: TMenuItem;
    Sair1: TMenuItem;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Calcular1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.Calcular1Click(Sender: TObject);
var
  frmSimulacao: TForm;
begin
  frmSimulacao := TfrmCalculo.Create(Application);
  frmSimulacao.Show;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.SpeedButton2Click(Sender: TObject);
var
  frmSimulacao: TForm;
begin
  frmSimulacao := TfrmCalculo.Create(Application);
  frmSimulacao.Show;
end;

procedure TfrmPrincipal.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

end.
