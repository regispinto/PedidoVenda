program PedidoVenda;

uses
  Vcl.Forms,
  unMain in 'Source\View\unMain.pas' {frmMain},
  unCliente in 'Source\Model\unCliente.pas',
  unProduto in 'Source\Model\unProduto.pas',
  unPedidoItem in 'Source\Model\unPedidoItem.pas',
  unPedido in 'Source\Model\unPedido.pas',
  unDAOConexao in 'Source\DAO\unDAOConexao.pas',
  unPedidoController in 'Source\Controller\unPedidoController.pas',
  unClienteDAO in 'Source\DAO\unClienteDAO.pas',
  unClienteController in 'Source\Controller\unClienteController.pas',
  unProdutoDAO in 'Source\DAO\unProdutoDAO.pas',
  unProdutoController in 'Source\Controller\unProdutoController.pas',
  unPedidoDAO in 'Source\DAO\unPedidoDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
