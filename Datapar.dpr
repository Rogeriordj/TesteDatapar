program Datapar;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {frmPrincipal},
  uCalculo in 'uCalculo.pas' {frmCalculo},
  Financiamento in 'Financiamento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
