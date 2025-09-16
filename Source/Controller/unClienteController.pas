unit unClienteController;

interface

uses
  FireDAC.DApt, unCliente;

type
  TClienteController = class
  public
    function ObterClientePorCodigo(Codigo: Integer): TCliente;
  end;

implementation

uses
  unClienteDAO;

function TClienteController.ObterClientePorCodigo(Codigo: Integer): TCliente;
var
  DAO: TClienteDAO;
begin
  DAO := TClienteDAO.Create;
  try
    Result := DAO.BuscarPorCodigo(Codigo);
  finally
    DAO.Free;
  end;
end;

end.

