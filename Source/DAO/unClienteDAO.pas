unit unClienteDAO;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Stan.Param, unCliente;

type
  TClienteDAO = class
  public
    function BuscarPorCodigo(Codigo: Integer): TCliente;
  end;

implementation

uses
  unDAOConexao;

function TClienteDAO.BuscarPorCodigo(Codigo: Integer): TCliente;
var
  Qry: TFDQuery;

begin
  Result := Nil;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := TDAOConexao.GetConnection;
    Qry.SQL.Text := 'SELECT codigo, nome, cidade, uf FROM clientes WHERE codigo = :codigo';
    Qry.ParamByName('codigo').AsInteger := Codigo;
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      Result := TCliente.Create;
      Result.Codigo := Qry.FieldByName('codigo').AsInteger;
      Result.Nome := Qry.FieldByName('nome').AsString;
      Result.Cidade := Qry.FieldByName('cidade').AsString;
      Result.UF := Qry.FieldByName('uf').AsString;
    end;

  finally
    Qry.Free;
  end;
end;

end.
