unit unProdutoDAO;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Stan.Param, unProduto;

type
  TPRodutoDAO = class
  public
    function BuscarPorCodigo(Codigo: Integer): TProduto;
  end;

implementation

uses
  unDAOConexao;

function TProdutoDAO.BuscarPorCodigo(Codigo: Integer): TProduto;
var
  Qry: TFDQuery;

begin
  Result := Nil;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := TDAOConexao.GetConnection;
    Qry.SQL.Text := 'SELECT codigo, descricao, preco_venda FROM produtos WHERE codigo = :codigo';
    Qry.ParamByName('codigo').AsInteger := Codigo;
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      Result := TProduto.Create;
      Result.Codigo := Qry.FieldByName('codigo').AsInteger;
      Result.Descricao := Qry.FieldByName('descricao').AsString;
      Result.PrecoVenda := Qry.FieldByName('preco_venda').AsCurrency;
    end;

  finally
    Qry.Free;

  end;
end;

end.

