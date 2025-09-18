unit unPedidoController;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections, Data.DB,
  FireDAC.DApt, FireDAC.Stan.Param,
  unDAOConexao, unPedidoDAO, unPedido, unPedidoItem;

type
  TPedidoController = class

  private

  public
    procedure ValidarPedido(Cliente: string; APedido: TPedido);

    function GravarPedido(APedido: TPedido): Boolean;
    function BuscarPedidoPorNumero(Numero: Integer): TPedido;
  end;

implementation

uses
  FireDAC.Comp.Client;

procedure TPedidoController.ValidarPedido(Cliente: string; APedido: TPedido);
begin
  // Validar código do cliente
  if Trim(Cliente) = '' then
    raise Exception.Create('Informe o código do cliente.');

  // Validar itens do pedido
  if not Assigned(APedido) or (APedido.Itens.Count = 0) then
    raise Exception.Create('Adicione pelo menos um item ao pedido.');
end;

function TPedidoController.GravarPedido(APedido: TPedido): Boolean;
var
  Conn: TFDConnection;
  PedidoDAO: TPedidoDAO;

begin
  Conn := TDAOConexao.GetConnection;
  Conn.StartTransaction;

  try
    PedidoDAO := TPedidoDAO.Create();
    try
      PedidoDAO.SalvarPedido(APedido);
    finally
      PedidoDAO.Free;
    end;

    Conn.Commit;

    Result := True;
  except
    Conn.Rollback;
    raise;
  end;
end;

function TPedidoController.BuscarPedidoPorNumero(Numero: Integer): TPedido;
var
  DAO: TPedidoDAO;

begin
  DAO := TPedidoDAO.Create();
  try
    Result := DAO.CarregarPedido(Numero);
  finally
    DAO.Free;

  end;
end;

end.
