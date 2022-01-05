unit Financiamento;

interface

uses
  System.Generics.Collections,
  system.SysUtils,
  system.Math;

type
  TPrazo = class(TObject)
    private
      FPrazo:        Integer;
      FJuros:        Real;
      FAmortizacao:  Real;
      FPagamento:    Real;
      FSaldoDevedor: Real;
      FShowValue:    Boolean;
    public
      property Prazo:        Integer  read FPrazo write FPrazo;
      property Juros:        Real     read FJuros write FJuros;
      property Amortizacao:  Real     read FAmortizacao write FAmortizacao;
      property Pagamento:    Real     read FPagamento write FPagamento;
      property SaldoDevedor: Real     read FSaldoDevedor write FSaldoDevedor;
      property ShowValue:    Boolean  read FShowValue write FShowValue;
  end;

  TFinanciamento = class(TObject)
    private
      FCapitalInicial:      Real;
      FAliquotaJurosMensal: Real;
      FPrazoPagamento:      Integer;
      FListPrazo:           TObjectList<TPrazo>;
    protected

    public
      constructor Create();
      destructor Destroy();

      procedure Calculate(); virtual; Abstract;
      function  Totalize(): TPrazo; virtual; Abstract;

      property CapitalInicial:      Real read FCapitalInicial write FCapitalInicial;
      property AliquotaJurosMensal: Real read FAliquotaJurosMensal write FAliquotaJurosMensal;
      property PrazoPagamento:      Integer read FPrazoPagamento write FPrazoPagamento;
      property ListPrazo:           TObjectList<TPrazo> read FListPrazo write FListPrazo;
  end;

  TFinanciamentoPagamentoUnico = class(TFinanciamento)
    private
    protected

    public
      procedure Calculate(); override;
      function  Totalize(): TPrazo; override;
  end;

implementation

constructor TFinanciamento.Create();
begin
  Self.FListPrazo := TObjectList<TPrazo>.Create;
end;

destructor TFinanciamento.Destroy();
var
  I: Integer;
begin
  for I := Self.ListPrazo.Count - 1 downto 0 do
  begin
    FreeAndNil(Self.ListPrazo[I]);
    Self.ListPrazo.Delete(I);
  end;
end;

procedure TFinanciamentoPagamentoUnico.Calculate();
var
  x,
  prazoPagamento: Integer;

  saldoDevedor,
  capitalInicial,
  aliquotaJurosMensal,
  valorJurosParcela,
  jurosAcumulado: Real;
begin
  capitalInicial      := Self.CapitalInicial;
  aliquotaJurosMensal := Self.AliquotaJurosMensal;
  prazoPagamento      := Self.PrazoPagamento;
  jurosAcumulado      := 0;

  Self.ListPrazo.Clear;

  for x := 0 to Self.prazoPagamento do
  begin
    saldoDevedor := capitalInicial * power((1 + (aliquotaJurosMensal / 100)), x);
    valorJurosParcela := saldoDevedor - capitalInicial - jurosAcumulado;

    jurosAcumulado := jurosAcumulado + valorJurosParcela;

    Self.ListPrazo.Add(TPrazo.Create);
    Self.ListPrazo[x].Prazo     := x;
    Self.ListPrazo[x].Juros     := valorJurosParcela;

    Self.ListPrazo[x].ShowValue := (x = 0) or (x = Self.PrazoPagamento);

    if (x = Self.PrazoPagamento) then
    begin
      Self.ListPrazo[x].Amortizacao  := capitalInicial;
      Self.ListPrazo[x].Pagamento    := capitalInicial + jurosAcumulado;
      Self.ListPrazo[x].SaldoDevedor := 0;
    end else
    begin
      Self.ListPrazo[x].Amortizacao  := 0;
      Self.ListPrazo[x].Pagamento    := 0;
      Self.ListPrazo[x].SaldoDevedor := capitalInicial + jurosAcumulado;
    end;
  end;
end;

function TFinanciamentoPagamentoUnico.Totalize(): TPrazo;
var
  x:     Integer;
  total,
  prazo: TPrazo;

  jurosAcumulado,
  amortizacaoAcumulado,
  pagamentoAcumulado,
  saldoDevedor,
  saldoDevedorInicial: Real;
begin
  total                := TPrazo.Create();
  jurosAcumulado       := 0;
  amortizacaoAcumulado := 0;
  pagamentoAcumulado   := 0;

  saldoDevedorInicial := Self.ListPrazo[0].SaldoDevedor;
  saldoDevedor := saldoDevedorInicial;

  for x := 1 to Self.prazoPagamento do
  begin
    prazo                := Self.ListPrazo[x];
    jurosAcumulado       := jurosAcumulado + prazo.Juros;
    amortizacaoAcumulado := amortizacaoAcumulado + prazo.Amortizacao;
    pagamentoAcumulado   := pagamentoAcumulado + prazo.Pagamento;
    saldoDevedor         := saldoDevedorInicial + jurosAcumulado - pagamentoAcumulado;
  end;

  total.Juros        := jurosAcumulado;
  total.Amortizacao  := amortizacaoAcumulado;
  total.Pagamento    := pagamentoAcumulado;
  total.SaldoDevedor := saldoDevedor;
  total.ShowValue    := true;

  Result := total;
end;

end.
