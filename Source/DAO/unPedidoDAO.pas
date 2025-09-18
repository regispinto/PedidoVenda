unit unPedidoDAO;

interface

uses
  System.SysUtils, Data.DB, Vcl.Dialogs, FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Stan.Param, FireDAC.Phys.MySQL,
  unPedido, unPedidoItem;

type
  TPedidoDAO = class
  private

  public
    procedure SalvarPedido(APedido: TPedido);

    function CarregarPedido(NumeroPedido: Integer): TPedido;
  end;

implementation

uses
  unDAOConexao;

procedure TPedidoDAO.SalvarPedido(APedido: TPedido);
var
  PedidoExiste: Boolean;
  Item: TPedidoItem;
  Qry: TFDQuery;

begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := TDAOConexao.GetConnection;

    // Verifica se o pedido já existe
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COUNT(*) FROM pedidos WHERE numero = :numero');
    Qry.ParamByName('numero').AsInteger := APedido.Numero;
    Qry.Open;
    PedidoExiste := Qry.Fields[0].AsInteger > 0;
    Qry.Close;

    case PedidoExiste of
      True: begin
              // Atualiza dados gerais
              Qry.SQL.Clear;
              Qry.SQL.Add('UPDATE pedidos');
              Qry.SQL.Add('SET data_emissao = :pDataEmissao, codigo_cliente = :pCodigoCliente, valor_total = :pValorTotal');
              Qry.SQL.Add('WHERE numero = :pNumero');

               Qry.ParamByName('pNumero').AsInteger := APedido.Numero;
            end;

     False: begin
              // Insere novo pedido
              Qry.SQL.Clear;
              Qry.SQL.Add('INSERT INTO pedidos (data_emissao, codigo_cliente, valor_total)');
              Qry.SQL.Add('VALUES (:pDataEmissao, :pCodigoCliente, :pValorTotal)');
            end;
    end;

    Qry.ParamByName('pDataEmissao').AsDate := Trunc(Now);
    Qry.ParamByName('pCodigoCliente').AsInteger := APedido.CodigoCliente;
    Qry.ParamByName('pValorTotal').AsCurrency := APedido.ValorTotal;
    Qry.ExecSQL;

    case PedidoExiste of
      True: begin
              // Exclui itens antigos, se houver
              Qry.SQL.Clear;
              Qry.SQL.Add('DELETE FROM pedido_itens WHERE numero_pedido = :numero');
              Qry.ParamByName('numero').AsInteger := APedido.Numero;
              Qry.ExecSQL;
            end;

     False: begin
              // Obtém o número do pedido gerado (auto_increment)
              Qry.SQL.Text := 'SELECT LAST_INSERT_ID() AS numero';
              Qry.Open;

              APedido.Numero := Qry.FieldByName('numero').AsInteger;
            end;
    end;

    // Insere itens novos
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO pedido_itens (numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total)');
    Qry.SQL.Add('VALUES (:numero_pedido, :codigo_produto, :quantidade, :valor_unitario, :valor_total)');

    for Item in APedido.Itens do
    begin
      Qry.ParamByName('numero_pedido').AsInteger := APedido.Numero;
      Qry.ParamByName('codigo_produto').AsInteger := Item.CodigoProduto;
      Qry.ParamByName('quantidade').AsInteger := Item.Quantidade;
      Qry.ParamByName('valor_unitario').AsCurrency := Item.ValorUnitario;
      Qry.ParamByName('valor_total').AsCurrency := Item.ValorTotal;
      Qry.ExecSQL;
    end;
  finally
    Qry.Free;

  end;
end;

function TPedidoDAO.CarregarPedido(NumeroPedido: Integer): TPedido;
var
  Item: TPedidoItem;
  Pedido: TPedido;
  Qry: TFDQuery;

begin
  Pedido := TPedido.Create;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := TDAOConexao.GetConnection;

    // Buscar dados do pedido
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT numero, data_emissao, codigo_cliente, valor_total');
    Qry.SQL.Add('FROM pedidos WHERE numero = :numero');
    Qry.ParamByName('numero').AsInteger := NumeroPedido;
    Qry.Open;

    if Qry.IsEmpty then
      raise Exception.CreateFmt('Pedido nº %d não encontrado.', [NumeroPedido]);

    Pedido.Numero := Qry.FieldByName('numero').AsInteger;
    Pedido.Emissao := Qry.FieldByName('data_emissao').AsDateTime;
    Pedido.CodigoCliente := Qry.FieldByName('codigo_cliente').AsInteger;
    Pedido.ValorTotal := Qry.FieldByName('valor_total').AsCurrency;

    Qry.Close;

    // Buscar itens do pedido
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT pi.codigo_produto, p.descricao, pi.quantidade, pi.valor_unitario, pi.valor_total FROM pedido_itens pi');
    Qry.SQL.Add('LEFT JOIN produtos p ON p.codigo = pi.codigo_produto');
    Qry.SQL.Add('WHERE pi.numero_pedido = :numero');
    Qry.ParamByName('numero').AsInteger := NumeroPedido;
    Qry.Open;

    while not Qry.Eof do
    begin
      Item := TPedidoItem.Create;
      Item.CodigoProduto := Qry.FieldByName('codigo_produto').AsInteger;
      Item.Quantidade := Qry.FieldByName('quantidade').AsInteger;
      Item.ValorUnitario := Qry.FieldByName('valor_unitario').AsCurrency;
      Item.ValorTotal := Qry.FieldByName('valor_total').AsCurrency;
      Item.Descricao :=  Qry.FieldByName('descricao').AsString;

      Pedido.Itens.Add(Item);

      Qry.Next;
    end;

    Result := Pedido;
  finally
    Qry.Free;

  end;
end;

end.
