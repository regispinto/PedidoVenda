unit unMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.DApt,
  unDAOConexao,
  unClienteController, unCliente,
  unProdutoController, unProduto,
  unPedidoController, unPedido, unPedidoItem;

type
  TfrmMain = class(TForm)
    pnlDados: TPanel;
    lblCodigoCliente: TLabel;
    lblCodigoProduto: TLabel;
    lblQuantidade: TLabel;
    lblValorUnitario: TLabel;
    edtCodigoProduto: TEdit;
    edtCodigoCliente: TEdit;
    edtQuantidade: TEdit;
    edtValorUnitario: TEdit;
    btnAcaoProduto: TButton;
    gridItens: TStringGrid;
    pnlTotal: TPanel;
    lblTotalPedido: TLabel;
    pnlResumo: TPanel;
    btnGravarPedido: TButton;
    btnCarregarPedido: TButton;
    btnCancelarPedido: TButton;
    lblNomeCliente: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure btnAcaoProdutoClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure gridItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtCodigoClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure edtCodigoProdutoChange(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure edtCodigoProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtQuantidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtValorUnitarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCarregarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);

  private
    { Private declarations }
    FController: TPedidoController;
    FPedido: TPedido;

    procedure AtualizarGrid;
    procedure AtualizarTotal;
    procedure BuscarCliente;
    procedure BuscarProduto;
    procedure EditarItem(Index: Integer);
    procedure SetarCampos(Modo: Integer=0);

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  lblNomeCliente.Caption := EmptyStr;

  FPedido := TPedido.Create;
  FController := TPedidoController.Create;

  gridItens.RowCount := 2;
  gridItens.ColCount := 5;
  gridItens.Cells[0, 0] := 'Código';
  gridItens.Cells[1, 0] := 'Descrição';
  gridItens.Cells[2, 0] := 'Qtd';
  gridItens.Cells[3, 0] := 'Unit.';
  gridItens.Cells[4, 0] := 'Total';

  gridItens.ColWidths[0] := 80;
  gridItens.ColWidths[1] := 300;
  gridItens.ColWidths[2] := 80;
  gridItens.ColWidths[3] := 100;
  gridItens.ColWidths[4] := 100;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  SetarCampos;
end;

procedure TfrmMain.btnAcaoProdutoClick(Sender: TObject);
var
  Item: TPedidoItem;

  procedure ValidarCampos;
  begin
    if Trim(edtCodigoCliente.Text) = EmptyStr then
    begin
      edtCodigoCliente.SetFocus;
      raise Exception.Create('Informe o código do cliente.');
    end;

    if Trim(edtCodigoProduto.Text) = EmptyStr then
    begin
      edtCodigoProduto.SetFocus;
      raise Exception.Create('Informe o código do produto.');
    end;

    if Trim(edtQuantidade.Text) = EmptyStr then
    begin
      edtQuantidade.SetFocus;
      raise Exception.Create('Quantidade inválida.');
    end;

    if Trim(edtValorUnitario.Text) = EmptyStr then
    begin
      edtValorUnitario.SetFocus;
      raise Exception.Create('Valor unitário inválido.');
    end;
  end;

begin
  ValidarCampos;

  Item := TPedidoItem.Create;
  Item.CodigoProduto := StrToIntDef(edtCodigoProduto.Text, 0);
  Item.Quantidade := StrToIntDef(edtQuantidade.Text, 1);
  Item.ValorUnitario := StrToFloatDef(edtValorUnitario.Text, 0);
  Item.ValorTotal := Item.Quantidade * Item.ValorUnitario;
  Item.Descricao := Item.Descricao;

  FPedido.Itens.Add(Item);
  AtualizarGrid;
  AtualizarTotal;
  SetarCampos(2);
end;

procedure TfrmMain.edtCodigoClienteChange(Sender: TObject);
begin
  if edtCodigoCliente.Text = EmptyStr then
  begin
    lblNomeCliente.Caption := EmptyStr;
  end;
end;

procedure TfrmMain.edtCodigoClienteExit(Sender: TObject);
begin
  if edtCodigoCliente.Text <> EmptyStr then
    BuscarCliente;
end;

procedure TfrmMain.edtCodigoClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    BuscarCliente;
    Key := 0;
  end;
end;

procedure TfrmMain.edtCodigoProdutoChange(Sender: TObject);
begin
  if edtCodigoProduto.Text = EmptyStr then
    edtValorUnitario.Clear;
end;

procedure TfrmMain.edtCodigoProdutoExit(Sender: TObject);
begin
  if edtCodigoProduto.Text <> EmptyStr then
    BuscarProduto;
end;

procedure TfrmMain.edtCodigoProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    BuscarProduto;
    Key := 0;
  end;
end;

procedure TfrmMain.edtQuantidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmMain.edtValorUnitarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmMain.AtualizarGrid;
var
  i: Integer;

begin
  gridItens.RowCount := FPedido.Itens.Count + 1;
  for i := 0 to FPedido.Itens.Count - 1 do
  begin
    gridItens.Cells[0, i + 1] := FPedido.Itens[i].CodigoProduto.ToString;
    gridItens.Cells[1, i + 1] := FPedido.Itens[i].Descricao;
    gridItens.Cells[2, i + 1] := FPedido.Itens[i].Quantidade.ToString;
    gridItens.Cells[3, i + 1] := FormatFloat('0.00', FPedido.Itens[i].ValorUnitario);
    gridItens.Cells[4, i + 1] := FormatFloat('0.00', FPedido.Itens[i].ValorTotal);
  end;
end;

procedure TfrmMain.AtualizarTotal;
var
  Total: Currency;
  Item: TPedidoItem;

begin
  Total := 0;
  for Item in FPedido.Itens do
    Total := Total + Item.ValorTotal;

  FPedido.ValorTotal := Total;
  lblTotalPedido.Caption := Format('Total do Pedido: R$ %.2f', [Total]);
end;

procedure TfrmMain.btnGravarPedidoClick(Sender: TObject);
begin
  try
    FPedido.CodigoCliente := StrToIntDef(edtCodigoCliente.Text, 0);
    FPedido.Data := Date;

    if FController.GravarPedido(FPedido) then
      ShowMessage('Pedido gravado com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao gravar pedido: ' + E.Message);
  end;
end;

procedure TfrmMain.btnCarregarPedidoClick(Sender: TObject);
begin
  //
end;

procedure TfrmMain.btnCancelarPedidoClick(Sender: TObject);
var
  i: Integer;

begin
  SetarCampos;
  if Assigned(FPedido) then
  FPedido.Itens.Clear;

  gridItens.RowCount := 2;
  for i := 1 to gridItens.RowCount - 1 do
    gridItens.Rows[i].Clear;

  AtualizarTotal;
end;

procedure TfrmMain.gridItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Index: Integer;

begin
  Index := gridItens.Row - 1;

  case Key of
    VK_DELETE: begin
                 if (Index >= 0) and (Index < FPedido.Itens.Count) then
                 begin
                   if Application.MessageBox('Deseja remover este item?', 'Aviso', MB_ICONQUESTION + MB_YESNO) = ID_YES then
                   begin
                     FPedido.Itens.Delete(Index);
                     AtualizarGrid;
                     AtualizarTotal;
                   end;
                 end;
               end;

    VK_RETURN: begin
                 if (Index >= 0) and (Index < FPedido.Itens.Count) then
                 begin
                   EditarItem(Index + 1);
                   AtualizarGrid;
                 end;
               end;
  end;
end;

procedure TfrmMain.BuscarCliente;
var
  Controller: TClienteController;
  Cliente: TCliente;
  Codigo: Integer;

begin
  Controller := TClienteController.Create;
  try
    lblNomeCliente.Caption := '';

    TryStrToInt(edtCodigoCliente.Text, Codigo);

    Cliente := Controller.ObterClientePorCodigo(Codigo);
    if Assigned(Cliente) then
    begin
      lblNomeCliente.Caption := Format('%s - %s/%s', [Cliente.Nome, Cliente.Cidade, Cliente.UF]);
      edtCodigoProduto.SetFocus;
      SetarCampos(1);
      Cliente.Free;
    end
    else
    begin
      Application.MessageBox('Cliente não localizado', 'Aviso', MB_ICONINFORMATION + MB_OK);
      edtCodigoCliente.SetFocus;
    end;
  finally
    Controller.Free;

  end;
end;

procedure TfrmMain.BuscarProduto;
var
  Controller: TProdutoController;
  Produto: TProduto;
  Codigo: Integer;

begin
  Controller := TProdutoController.Create;
  try
    TryStrToInt(edtCodigoProduto.Text, Codigo);

    Produto := Controller.ObterProdutoPorCodigo(Codigo);
    if Assigned(Produto) then
    begin
      edtValorUnitario.Text := FormatFloat('#,##0.00', Produto.PrecoVenda);
      edtQuantidade.SetFocus;
      Produto.Free;
    end
    else
    begin
      Application.MessageBox('Produto não localizado', 'Aviso', MB_ICONINFORMATION + MB_OK);
      edtCodigoProduto.SetFocus;
    end;
  finally
    Controller.Free;

  end;
end;

procedure TfrmMain.EditarItem(Index: Integer);
begin
  edtCodigoProduto.Text := gridItens.Cells[0, Index];
  edtQuantidade.Text := gridItens.Cells[2, Index];
  edtValorUnitario.Text := gridItens.Cells[3, Index];
  SetarCampos(3);
end;

procedure TfrmMain.SetarCampos(Modo: Integer=0);
begin
  frmMain.Caption := 'Pedidos Vendas';

  btnAcaoProduto.Caption := 'Inserir Produto';
  btnAcaoProduto.Tag := 0;

  case Modo of
    0: begin
         edtCodigoCliente.Enabled := True;
         edtCodigoProduto.Enabled := True;

         edtCodigoCliente.Clear;
         edtCodigoProduto.Clear;
         edtQuantidade.Clear;
         edtValorUnitario.Clear;

         edtCodigoCliente.SetFocus;
       end;

 1..2: begin
         frmMain.Caption := frmMain.Caption + ' - [Modo Inclusão]';
         btnAcaoProduto.Tag := 1;

         case Modo of
           1: begin
                edtCodigoCliente.Enabled := False;
              end;

          2: begin
               edtCodigoProduto.Clear;
               edtQuantidade.Clear;
               edtValorUnitario.Clear;
             end;
         end;

         edtCodigoProduto.SetFocus;
       end;

    3: begin
         frmMain.Caption := frmMain.Caption + ' - [Modo Alteração]';

         btnAcaoProduto.Caption := 'Atualizar Pedido';
         btnAcaoProduto.Tag := 2;

         edtCodigoCliente.Enabled := False;
         edtCodigoProduto.Enabled := False;

         edtQuantidade.SetFocus;
       end;
  end;
end;

end.
