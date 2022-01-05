unit uCalculo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Financiamento, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.NumberBox, Vcl.Grids, Vcl.Mask, Vcl.Samples.Spin, System.Generics.Collections;

type
  TfrmCalculo = class(TForm)
    Panel1: TPanel;
    spbFechar: TSpeedButton;
    edtCapital: TEdit;
    edtJuros: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    gridCalculo: TStringGrid;
    Label4: TLabel;
    edtPrazo: TSpinEdit;
    Button1: TButton;
    procedure edtCapitalExit(Sender: TObject);
    procedure edtJurosExit(Sender: TObject);
    procedure edtCapitalKeyPress(Sender: TObject; var Key: Char);
    procedure edtJurosKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure gridCalculoDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure spbFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure InputNumbersOnly(Sender: TObject; var Key: Char);
    procedure FormatCurrency(Sender: TObject);
    procedure InitializeGrid();
    procedure ValidaCampo;
    procedure printTotal(totalJuros, totalAmortizacao, totalPagamento: Real);
    procedure printLine(line: Integer; prazo: TPrazo);
    procedure populateGrid(ListPrazo: TObjectList<TPrazo>; total: TPrazo);
    procedure clearGrid();
  public
    { Public declarations }
  end;

var
  frmCalculo: TfrmCalculo;

implementation

{$R *.dfm}

procedure TfrmCalculo.edtJurosExit(Sender: TObject);
begin
  Self.FormatCurrency(Sender);
end;

procedure TfrmCalculo.edtCapitalExit(Sender: TObject);
begin
  Self.FormatCurrency(Sender);
end;

procedure TfrmCalculo.edtJurosKeyPress(Sender: TObject; var Key: Char);
begin
  Self.InputNumbersOnly(Sender, Key);
end;

procedure TfrmCalculo.edtCapitalKeyPress(Sender: TObject; var Key: Char);
begin
  Self.InputNumbersOnly(Sender, Key);
end;

procedure TfrmCalculo.FormatCurrency(Sender: TObject);
begin
  if (TEdit(Sender).Text <> '') and (StrtoFloat(TEdit(Sender).Text) > 0)then
    TEdit(Sender).Text :=  FormatFloat('###,###,##0.00',StrtoFloat(TEdit(Sender).Text))
  Else
    TEdit(Sender).Text :=  '0,00';
end;

procedure TfrmCalculo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCalculo.FormCreate(Sender: TObject);
begin
  Self.InitializeGrid();
end;

procedure TfrmCalculo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfrmCalculo.gridCalculoDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  S: string;
  RectForText: TRect;
begin
  if (ARow = gridCalculo.RowCount-1) then
  begin
    S := gridCalculo.Cells[ACol, ARow];

    gridCalculo.Canvas.Brush.Color := $00CEFFFF;
    gridCalculo.Canvas.FillRect(Rect);
    gridCalculo.Canvas.Font.Color := clBlack;

    RectForText := Rect;
    InflateRect(RectForText, -6, -6);
    gridCalculo.Canvas.TextRect(RectForText, S);
  end
end;

procedure TfrmCalculo.InputNumbersOnly(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', ',']) then
    Key := #0
  else
  if ((Key = ',') and (Pos(Key, TEdit(Sender).Text) > 0)) then
    Key := #0;
end;

procedure TfrmCalculo.spbFecharClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmCalculo.ValidaCampo;
begin
   if not( StrtoFloat(edtCapital.Text) > 0 ) then
   begin
     showMessage('Informe um Período válido, maior que zero!');
     edtCapital.SetFocus;
   end;

   if not( StrtoFloat(edtJuros.Text) > 0 ) then
   begin
     showMessage('Informe uma Taxa válida, maior que zero!');
     edtJuros.SetFocus;
   end;

   if not( StrtoInt(edtPrazo.Text) > 0 ) then
   begin
     showMessage('Informe um Prazo válido, maior que zero!');
     edtPrazo.SetFocus;
   end;
end;

procedure TfrmCalculo.InitializeGrid();
begin
  gridCalculo.ColCount     := 5;
  gridCalculo.RowCount     := 2;
  gridCalculo.FixedRows    := 1;

  gridCalculo.Cells[0, 0]  := 'Prazo';
  gridCalculo.ColWidths[0] := 68;

  gridCalculo.Cells[1, 0]  := 'Juros';
  gridCalculo.ColWidths[1] := 120;

  gridCalculo.Cells[2, 0]  := 'Amortização';
  gridCalculo.ColWidths[2] := 120;

  gridCalculo.Cells[3, 0]  := 'Pagamento';
  gridCalculo.ColWidths[3] := 120;

  gridCalculo.Cells[4, 0]  := 'Saldo Devedor';
  gridCalculo.ColWidths[4] := 120;
end;

procedure TfrmCalculo.populateGrid(ListPrazo: TObjectList<TPrazo>; total: TPrazo);
var
  x, line: Integer;
  prazo:   TPrazo;
begin
  for x := 0 to ListPrazo.Count-1 do
  begin
    prazo := TPrazo(ListPrazo[x]);
    line  := x + 1;

    printLine(line, prazo);
  end;
  printTotal(total.Juros, total.Amortizacao, total.Pagamento);
end;

procedure TfrmCalculo.printLine(line: Integer; prazo: TPrazo);
begin
  gridCalculo.RowCount := line + 1;
  gridCalculo.Cells[0, line] := FormatFloat('###0', prazo.Prazo);
  gridCalculo.Cells[1, line] := FormatFloat('###,###,##0.00', prazo.Juros);

  if (prazo.ShowValue) then
  begin
    gridCalculo.Cells[2, line] := FormatFloat('###,###,##0.00', prazo.Amortizacao);
    gridCalculo.Cells[3, line] := FormatFloat('###,###,##0.00', prazo.Pagamento);
  end;

  gridCalculo.Cells[4, line] := FormatFloat('###,###,##0.00', prazo.SaldoDevedor);
end;

procedure TfrmCalculo.printTotal(totalJuros, totalAmortizacao, totalPagamento: Real);
var
  x: Integer;
begin
  gridCalculo.RowCount := gridCalculo.RowCount + 1;
  x := gridCalculo.RowCount - 1;

  gridCalculo.Cells[0, x] := 'TOTAIS =>';
  gridCalculo.Cells[1, x] := FormatFloat('###,###,##0.00', totalJuros);
  gridCalculo.Cells[2, x] := FormatFloat('###,###,##0.00', totalAmortizacao);
  gridCalculo.Cells[3, x] := FormatFloat('###,###,##0.00', totalPagamento);
  gridCalculo.Cells[4, x] := '';
end;

procedure TfrmCalculo.Button1Click(Sender: TObject);
var
  i:             Integer;
  financiamento: TFinanciamentoPagamentoUnico;
  total:         TPrazo;
  strCapital, strJuros:String;
begin
  clearGrid();

  strCapital := StringReplace(edtCapital.Text, '.', '', [rfReplaceAll]);
  strJuros := StringReplace(edtJuros.Text, '.', '', [rfReplaceAll]);

  financiamento                     := TFinanciamentoPagamentoUnico.Create();
  try
    financiamento.CapitalInicial      := StrToFloat(strCapital);
    financiamento.AliquotaJurosMensal := StrToFloat(strJuros);
    financiamento.PrazoPagamento      := edtPrazo.Value;

    financiamento.Calculate();
    total := financiamento.Totalize();

    populateGrid(financiamento.ListPrazo, total);
  finally
    financiamento.Destroy();
  end;
end;

procedure TfrmCalculo.clearGrid();
var
  c, r: Integer;
begin
  for c := 0 to Pred(gridCalculo.ColCount) do
    for r := 1 to Pred(gridCalculo.RowCount) do
      gridCalculo.Cells[c, r] := '';
  gridCalculo.RowCount := 1;
end;



end.
