## Ruby Backend Test:

A Delivery Center está em constante expansão, e um dos pontos chave desse crescimento é a captação de pedidos em diversos canais. Recentemente, um destes canais efetuou a migração de seus serviços para uma nova API. Para manter a integridade da operação neste canal, precisamos refatorar um código legado que recebe e envia este pedido. Nesta nova integração iremos utilizar uma nova autenticação, onde iremos receber um token válido por uma hora para o envio do pedido.

**Dentre as necessidades desta refatoração, estão:**
* Buscar o token de autenticação via api
* Incluir autenticação na chamada de envio do pedido.
* Criar e organizar as entidades necessárias
* Persistir dados do pedido.
* Organizar o código existente
* Incluir testes para as mudanças
* A porcentagem de cobertura de testes não deve diminuir

No fluxo atual do projeto recebemos o **[payload](spec/fixtures/raw_order.json)** do pedido, parseamos a resposta, salvamos no banco de dados e enviamos o payload parseado para o endpoint:

* `verb` - `POST`
* `url` - `delivery-center-recruitment-ap.herokuapp.com`
* `endpoint` - `/api/v1/order`
* `body` - [processed_order_v1.json](spec/fixtures/processed_order_v1.json)


Durante a migração para api nova, tivemos reformulações no payload de entrada, este deverá informar o endereço do cliente em um objeto separado, como **[neste exemplo](spec/fixtures/processed_order_v2.json)**. Após a construção correta do payload, ele deve ser enviado para o endpoint:

* `verb` - `POST`
* `url` - `delivery-center-recruitment-ap.herokuapp.com`
* `endpoint` - `/api/v2/order`
* `headers` - `Authorization: *token*`
* `body` - [processed_order_v2.json](spec/fixtures/processed_order_v2.json)

Nesta nova api adicionamos uma camada de segurança no consumo dos endpoints, portanto para o fluxo da nova api, você deverá consumir um endpoint que retornará o token de autenticação:

* `verb` - `GET`
* `url` - `delivery-center-recruitment-ap.herokuapp.com`
* `endpoint` - `/auth/get_token`

#

### Após a finalização do teste, ele deve ser entregue seguindo estes passos:
1.
#
*Sinta-se à vontade para alterar, organizar e limpar o código como achar necessário, assim como criar novos casos de teste, documentar o projeto e utilizar ferramentas que melhoram a qualidade e confiabilidade do código. A avaliação ocorrerá em acordo com o esforço colocado no projeto.*
