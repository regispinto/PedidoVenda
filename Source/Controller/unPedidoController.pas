unit unPedidoController;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  unPedido, unPedidoItem;

type
  TPedidoController = class
  public
    function GravarPedido(APedido: TPedido): Boolean;
  end;

implementation

uses
  FireDAC.Comp.Client, unDAOConexao;

function TPedidoController.GravarPedido(APedido: TPedido): Boolean;
var
  Conn: TFDConnection;

begin
  Conn := TDAOConexao.GetConnection;
  Conn.StartTransaction;
  try
    // INSERT em pedidos e pedido_itens (implementar aqui)

    Conn.Commit;
    Result := True;
  except
    Conn.Rollback;
    raise;
  end;
end;

end.
