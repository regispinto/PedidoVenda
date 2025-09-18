object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Pedido de Vendas'
  ClientHeight = 520
  ClientWidth = 943
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object pnlDados: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 1
    Width = 943
    Height = 129
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 1
    Align = alTop
    BorderStyle = bsSingle
    Color = clSilver
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 941
    object lblCodigoCliente: TLabel
      Left = 25
      Top = 15
      Width = 109
      Height = 14
      Caption = 'C'#243'digo do Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCodigoProduto: TLabel
      Left = 16
      Top = 48
      Width = 118
      Height = 14
      Caption = 'C'#243'digo do Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuantidade: TLabel
      Left = 63
      Top = 81
      Width = 71
      Height = 14
      Caption = 'Quantidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorUnitario: TLabel
      Left = 260
      Top = 81
      Width = 83
      Height = 14
      Caption = 'Valor Unit'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNomeCliente: TLabel
      Left = 260
      Top = 15
      Width = 90
      Height = 14
      Caption = 'lblNomeCliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDescricaoProduto: TLabel
      Left = 260
      Top = 48
      Width = 122
      Height = 14
      Caption = 'lblDescricaoProduto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodigoProduto: TEdit
      Left = 142
      Top = 46
      Width = 100
      Height = 21
      Alignment = taRightJustify
      TabOrder = 1
      OnChange = edtCodigoProdutoChange
      OnExit = edtCodigoProdutoExit
      OnKeyDown = edtCodigoProdutoKeyDown
    end
    object edtCodigoCliente: TEdit
      Left = 142
      Top = 13
      Width = 100
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 0
      OnChange = edtCodigoClienteChange
      OnExit = edtCodigoClienteExit
      OnKeyDown = edtCodigoClienteKeyDown
    end
    object edtQuantidade: TEdit
      Left = 142
      Top = 78
      Width = 100
      Height = 21
      Alignment = taRightJustify
      TabOrder = 2
      OnKeyDown = edtQuantidadeKeyDown
    end
    object edtValorUnitario: TEdit
      Left = 353
      Top = 78
      Width = 80
      Height = 21
      Alignment = taRightJustify
      TabOrder = 3
      OnKeyDown = edtValorUnitarioKeyDown
    end
    object btnAcaoProduto: TButton
      Left = 454
      Top = 76
      Width = 134
      Height = 25
      Caption = 'Inserir Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnAcaoProdutoClick
    end
  end
  object gridItens: TStringGrid
    Left = 0
    Top = 131
    Width = 943
    Height = 309
    Align = alClient
    FixedCols = 0
    RowCount = 2
    Options = [goEditing, goTabs, goRowSelect, goThumbTracking]
    TabOrder = 1
    OnKeyDown = gridItensKeyDown
    ExplicitWidth = 941
    ExplicitHeight = 301
  end
  object pnlTotal: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 441
    Width = 943
    Height = 37
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 1
    Align = alBottom
    BorderStyle = bsSingle
    Color = clSilver
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 433
    ExplicitWidth = 941
    object lblTotalPedido: TLabel
      Left = 14
      Top = 7
      Width = 133
      Height = 15
      Caption = 'Total do Pedido: R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlResumo: TPanel
    Left = 0
    Top = 479
    Width = 943
    Height = 41
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 471
    ExplicitWidth = 941
    object btnGravarPedido: TButton
      Left = 16
      Top = 3
      Width = 120
      Height = 30
      Caption = 'Gravar Pedido'
      TabOrder = 0
      OnClick = btnGravarPedidoClick
    end
    object btnCarregarPedido: TButton
      Left = 160
      Top = 2
      Width = 120
      Height = 30
      Caption = 'Carregar Pedido'
      TabOrder = 1
      OnClick = btnCarregarPedidoClick
    end
    object btnCancelarPedido: TButton
      Left = 300
      Top = 2
      Width = 120
      Height = 30
      Caption = 'Cancelar Pedido'
      TabOrder = 2
      OnClick = btnCancelarPedidoClick
    end
  end
end
