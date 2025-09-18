unit unPedido;

interface

uses
  System.Generics.Collections, unPedidoItem;

type
  TPedido = class
  private
    FNumero: Integer;
    FEmissao: TDateTime;
    FCodigoCliente: Integer;
    FValorTotal: Currency;
    FItens: TObjectList<TPedidoItem>;

  public
    constructor Create;
    destructor Destroy; override;

    property Numero: Integer read FNumero write FNumero;
    property Emissao: TDateTime read FEmissao write FEmissao;
    property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    property Itens: TObjectList<TPedidoItem> read FItens;
  end;

implementation

constructor TPedido.Create;
begin
  inherited;
  FItens := TObjectList<TPedidoItem>.Create(True);
end;

destructor TPedido.Destroy;
begin
  FItens.Free;
  inherited;
end;

end.

