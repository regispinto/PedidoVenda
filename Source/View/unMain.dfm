object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Pedido de Vendas'
  ClientHeight = 520
  ClientWidth = 943
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 943
    Height = 90
    Align = alTop
    BorderStyle = bsSingle
    Color = clSilver
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 941
    object lblCodigoCliente: TLabel
      Left = 16
      Top = 15
      Width = 99
      Height = 15
      Caption = 'C'#243'digo do Cliente:'
    end
    object lblCodigoProduto: TLabel
      Left = 16
      Top = 48
      Width = 105
      Height = 15
      Caption = 'C'#243'digo do Produto:'
    end
    object lblQuantidade: TLabel
      Left = 244
      Top = 48
      Width = 65
      Height = 15
      Caption = 'Quantidade:'
    end
    object lblValorUnitario: TLabel
      Left = 394
      Top = 48
      Width = 74
      Height = 15
      Caption = 'Valor Unit'#225'rio:'
    end
    object lblNomeCliente: TLabel
      Left = 244
      Top = 16
      Width = 83
      Height = 15
      Caption = 'lblNomeCliente'
    end
    object edtCodigoProduto: TEdit
      Left = 127
      Top = 45
      Width = 100
      Height = 23
      Alignment = taRightJustify
      TabOrder = 1
      OnChange = edtCodigoProdutoChange
      OnExit = edtCodigoProdutoExit
      OnKeyDown = edtCodigoProdutoKeyDown
    end
    object edtCodigoCliente: TEdit
      Left = 126
      Top = 12
      Width = 100
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 0
      OnChange = edtCodigoClienteChange
      OnExit = edtCodigoClienteExit
      OnKeyDown = edtCodigoClienteKeyDown
    end
    object edtQuantidade: TEdit
      Left = 314
      Top = 45
      Width = 60
      Height = 23
      Alignment = taRightJustify
      TabOrder = 2
      OnKeyDown = edtQuantidadeKeyDown
    end
    object edtValorUnitario: TEdit
      Left = 475
      Top = 45
      Width = 80
      Height = 23
      Alignment = taRightJustify
      TabOrder = 3
      OnKeyDown = edtValorUnitarioKeyDown
    end
    object btnAcaoProduto: TButton
      Left = 584
      Top = 44
      Width = 120
      Height = 25
      Caption = 'Inserir Produto'
      TabOrder = 4
      OnClick = btnAcaoProdutoClick
    end
  end
  object gridItens: TStringGrid
    Left = 0
    Top = 90
    Width = 943
    Height = 350
    Align = alClient
    FixedCols = 0
    RowCount = 2
    Options = [goEditing, goTabs, goRowSelect, goThumbTracking]
    TabOrder = 1
    OnKeyDown = gridItensKeyDown
    ExplicitTop = 87
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
      Left = 0
      Top = 2
      Width = 120
      Height = 30
      Caption = 'Gravar Pedido'
      TabOrder = 0
      OnClick = btnGravarPedidoClick
    end
    object btnCarregarPedido: TButton
      Left = 144
      Top = 2
      Width = 120
      Height = 30
      Caption = 'Carregar Pedido'
      TabOrder = 1
      OnClick = btnCarregarPedidoClick
    end
    object btnCancelarPedido: TButton
      Left = 284
      Top = 2
      Width = 120
      Height = 30
      Caption = 'Cancelar Pedido'
      TabOrder = 2
      OnClick = btnCancelarPedidoClick
    end
  end
end
