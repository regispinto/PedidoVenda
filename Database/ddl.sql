CREATE TABLE clientes (
  codigo INT PRIMARY KEY,
  nome VARCHAR(100),
  cidade VARCHAR(60),
  uf CHAR(2)
);

CREATE TABLE produtos (
  codigo INT PRIMARY KEY,
  descricao VARCHAR(100),
  preco_venda DECIMAL(10,2)
);

CREATE TABLE pedidos (
  numero INT PRIMARY KEY AUTO_INCREMENT,
  data_emissao DATE,
  codigo_cliente INT,
  valor_total DECIMAL(10,2),
  FOREIGN KEY (codigo_cliente) REFERENCES clientes(codigo)
);

CREATE TABLE pedido_itens (
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero_pedido INT,
  codigo_produto INT,
  quantidade INT,
  valor_unitario DECIMAL(10,2),
  valor_total DECIMAL(10,2),
  FOREIGN KEY (numero_pedido) REFERENCES pedidos(numero),
  FOREIGN KEY (codigo_produto) REFERENCES produtos(codigo)
);
