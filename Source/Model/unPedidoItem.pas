unit unPedidoItem;

interface

type
  TPedidoItem = class

  private
    FCodigoProduto: Integer;
    FDescricao: string;
    FQuantidade: Integer;
    FValorUnitario, FValorTotal: Currency;

  public
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Descricao: string read FDescricao write FDescricao;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
    property ValorTotal: Currency read FValorTotal write FValorTotal;

    function CalcularValorTotal: Currency;
  end;

implementation

{ TPedidoItem }

function TPedidoItem.CalcularValorTotal: Currency;
begin
  Result := Quantidade * ValorUnitario;
end;

end.

