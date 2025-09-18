CREATE database pedidovenda;

use pedidovenda;

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

INSERT INTO produtos (codigo, descricao, preco_venda) VALUES
(1, 'Mouse sem fio Logitech M170', 79.90),
(2, 'Teclado mecânico Redragon Kumara', 249.90),
(3, 'Monitor LED 24" Samsung', 899.00),
(4, 'Headset Gamer HyperX Cloud Stinger', 349.90),
(5, 'Webcam Logitech C270 HD', 199.00),
(6, 'Notebook Dell Inspiron i5 8GB 256GB SSD', 3899.00),
(7, 'Cadeira Gamer ThunderX3 TGC12', 1299.90),
(8, 'Mousepad Gamer RGB Redragon', 89.90),
(9, 'Placa de vídeo NVIDIA GTX 1660 Super', 1699.00),
(10, 'SSD Kingston 480GB SATA', 229.90),
(11, 'HD Seagate 1TB', 289.90),
(12, 'Roteador TP-Link Archer C6', 279.00),
(13, 'Fonte Corsair 650W 80 Plus Bronze', 489.90),
(14, 'Gabinete Gamer Redragon Quasar', 399.90),
(15, 'Memória RAM 8GB DDR4 3200MHz', 199.90),
(16, 'Smartphone Samsung Galaxy A34', 1999.00),
(17, 'Tablet Lenovo M10 Plus', 1299.00),
(18, 'Impressora Multifuncional Epson EcoTank L3250', 1249.90),
(19, 'Cabo HDMI 2.0 2 Metros', 39.90),
(20, 'Hub USB 3.0 4 portas', 59.90);

INSERT INTO clientes (codigo, nome, cidade, uf) VALUES
(1, 'João Silva', 'São Paulo', 'SP'),
(2, 'Maria Oliveira', 'Rio de Janeiro', 'RJ'),
(3, 'Pedro Santos', 'Belo Horizonte', 'MG'),
(4, 'Ana Costa', 'Curitiba', 'PR'),
(5, 'Lucas Pereira', 'Porto Alegre', 'RS'),
(6, 'Fernanda Almeida', 'Salvador', 'BA'),
(7, 'Rafael Rodrigues', 'Florianópolis', 'SC'),
(8, 'Camila Fernandes', 'Fortaleza', 'CE'),
(9, 'Thiago Martins', 'Recife', 'PE'),
(10, 'Juliana Castro', 'Brasília', 'DF'),
(11, 'Gustavo Lima', 'Vitória', 'ES'),
(12, 'Patrícia Souza', 'Belém', 'PA'),
(13, 'Eduardo Carvalho', 'Goiânia', 'GO'),
(14, 'Beatriz Ribeiro', 'Natal', 'RN'),
(15, 'André Monteiro', 'Campo Grande', 'MS'),
(16, 'Larissa Mendes', 'João Pessoa', 'PB'),
(17, 'Felipe Cardoso', 'Manaus', 'AM'),
(18, 'Isabela Teixeira', 'Teresina', 'PI'),
(19, 'Vinícius Barbosa', 'Maceió', 'AL'),
(20, 'Carolina Freitas', 'Aracaju', 'SE');
