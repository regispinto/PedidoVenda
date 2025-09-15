### Projeto exemplo Delphi usando MVC, POO, FireDAC e MySQL

### Estrutura de pastas do projeto:
<img width="262" height="353" alt="image" src="https://github.com/user-attachments/assets/56ea07aa-b4b3-4d0b-bba1-d1f19894fdd9" />

# Sistema de Pedido de Vendas em Delphi

Projeto exemplo desenvolvido com Embarcadero Delphi, utilizando:

- MVC (Model-View-Controller)
- POO (Programação Orientada a Objetos)
- FireDAC para acesso a banco de dados MySQL
- Conexão via arquivo `.ini`
- Controles visuais com `TStringGrid`, `TEdit`, `TButton`, etc.

## 🎯 Funcionalidades

- Inserção de produtos no pedido
- Edição e exclusão de itens no grid
- Cálculo automático do total do pedido
- Gravação em banco de dados com transação
- Regras de PK, FK, índices conforme solicitado

## 💾 Estrutura do Banco

Scripts SQL estão em `Database/`:

- `ddl.sql`: Criação das tabelas
- `dados.sql`: Inserção de dados de teste

## 🔧 Configuração

Edite o arquivo `Config/dbconfig.ini` com as configurações do seu MySQL:

```ini
[DB]
Database=pedidovenda
Username=root
Password=senha123
Server=localhost
Port=3306
