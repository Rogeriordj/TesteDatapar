object frmCalculo: TfrmCalculo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'C'#225'lculo'
  ClientHeight = 460
  ClientWidth = 576
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object spbFechar: TSpeedButton
    Left = 0
    Top = 431
    Width = 576
    Height = 29
    Align = alBottom
    Caption = '&Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = spbFecharClick
    ExplicitLeft = 493
    ExplicitTop = 285
    ExplicitWidth = 75
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 576
    Height = 431
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 27
      Top = 23
      Width = 61
      Height = 14
      Caption = 'Capital (R$)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = '\'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 154
      Top = 23
      Width = 96
      Height = 14
      Caption = 'Taxa de Juros (%)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 256
      Top = 23
      Width = 38
      Height = 14
      Caption = 'Meses'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 20
      Top = 82
      Width = 533
      Height = 32
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sistema de Pagamento '#217'nico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtCapital: TEdit
      Left = 27
      Top = 43
      Width = 121
      Height = 24
      TabOrder = 0
      Text = '0,0'
      OnExit = edtCapitalExit
      OnKeyDown = FormKeyDown
      OnKeyPress = edtCapitalKeyPress
    end
    object edtJuros: TEdit
      Left = 154
      Top = 43
      Width = 96
      Height = 24
      TabOrder = 1
      Text = '0,0'
      OnExit = edtJurosExit
      OnKeyDown = FormKeyDown
      OnKeyPress = edtJurosKeyPress
    end
    object gridCalculo: TStringGrid
      Left = 1
      Top = 112
      Width = 574
      Height = 318
      Align = alBottom
      ColCount = 1
      FixedColor = 13565951
      FixedCols = 0
      RowCount = 2
      GradientEndColor = 13565951
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
      TabOrder = 4
      OnDrawCell = gridCalculoDrawCell
      ExplicitLeft = 2
      ExplicitTop = 107
    end
    object edtPrazo: TSpinEdit
      Left = 256
      Top = 43
      Width = 62
      Height = 24
      MaxValue = 120
      MinValue = 1
      TabOrder = 2
      Value = 0
      OnKeyDown = FormKeyDown
    end
    object Button1: TButton
      Left = 326
      Top = 42
      Width = 75
      Height = 25
      Caption = 'Calcular'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = Button1Click
    end
  end
end
