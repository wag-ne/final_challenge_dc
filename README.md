# Delivery Center Api

Sistema de integração de pedidos

### Stack de desenvolvimento do projeto:

- Ruby 2.7.1 (linguagem de Programação)
- Rails 6.0.3.3 (Framework)
- Postgres (Banco de Dados)
- Docker + Docker-compose (Infraestrutura para desenvolvimento em containers)
- Rspec (Suite de testes)

## Requisitos para instalação

docker e docker-compose

## Instalação

### Obs. Caso tenha problemas para executar o docker utilizar o sudo ou dar permissão ao seu usuário no grupo do docker.

1 - Clonar repositório

2 - Acessar diretório do projeto

3 - Fazer um .env baseado no .env.example
```bash
cp .env.example .env
```

4 - Buildar aplicação

```bash
docker-compose build
```

5 - Criar o Banco e Rodar as Migrations

```bash
docker-compose run --rm app bundle exec rails db:drop db:create db:migrate
```

5 - Executar rspec

```bash
docker-compose run --rm app bundle exec rspec
```

6 - Executar rubocop

```bash
docker-compose run --rm app bundle exec rubocop
```

6 - Start na aplicação

```bash
docker-compose up
```

# Rest Api Utilização
## Sending an order
To create a new order you must send a post request containing the raw order data. e.g:
* `verb` - `POST`
* `endpoint` - `/api/v1/order`
* `body` - [spec/fixtures/raw_order.json](spec/fixtures/raw_order.json)
```bash
curl -H 'Content-Type: application/json' \
     -d @spec/fixtures/raw_order.json \
     http://localhost:3000/api/v1/orders
```
* Possible responses:
  - 201 - Successfully created
  - 404 - Cant create order, please check your params
	- 422 - Cant create order, because have errors on your params
  - 503 - Cant send order to remote server

## Explicações Gerais

### - Criação de serviço de token

- Foi gerada um novo serviço de token, para separar as responsabilidades dentro serviço de processamento do pedido de fato, para esse serviço em especifico foi gerada um cache salvo em memória, esse token é utilizado como um parâmetro para o authorization dentro da requisição para envio de pedidos.

### - Gravação do pedido e processamento

- Foi criada uma operation, afim de remover as responsabilidades/regras de negócio da controller, foram criadas alguns services que são chamados dentro dessa operation, para criar o payload, gravar o pedido, normalizar os parametros e realizar a requisição chamando a nova v2. Dentro dos services já foi realizada a alteração necessária relacionado ao address. Foi colocada uma validação para que não consiga realizar um novo pedido com o mesmo id de um já executado.

### - Gravação do pedido e processamento

- Foi criada uma operation, afim de remover as responsabilidades/regras de negócio da controller, foram criadas alguns services que são chamados dentro dessa operation, para criar o payload, gravar o pedido, normalizar os parametros e realizar a requisição chamando a nova v2. Dentro dos services já foi realizada a alteração necessária relacionado ao address. Foi colocada uma validação para que não consiga realizar um novo pedido com o mesmo id de um já executado.
