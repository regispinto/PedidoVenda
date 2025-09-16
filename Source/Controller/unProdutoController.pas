unit unProdutoController;

interface

uses
  FireDAC.DApt, unProduto;

type
  TProdutoController = class
  public
    function ObterProdutoPorCodigo(Codigo: Integer): TProduto;
  end;

implementation

uses
  unProdutoDAO;

function TProdutoController.ObterProdutoPorCodigo(Codigo: Integer): TProduto;
var
  DAO: TProdutoDAO;

begin
  DAO := TProdutoDAO.Create;
  try
    Result := DAO.BuscarPorCodigo(Codigo);
  finally
    DAO.Free;

  end;
end;

end.

