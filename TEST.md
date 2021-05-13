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
* `url` - `recruitment-api.deliverycenter.com`
* `endpoint` - `/api/v1/order`
* `body` - [processed_order_v1.json](spec/fixtures/processed_order_v1.json)


Durante a migração para api nova, tivemos reformulações no payload de entrada, este deverá informar o endereço do cliente em um objeto separado, como **[neste exemplo](spec/fixtures/processed_order_v2.json)**. Após a construção correta do payload, ele deve ser enviado para o endpoint:

* `verb` - `POST`
* `url` - `recruitment-api.deliverycenter.com`
* `endpoint` - `/api/v2/order`
* `headers` - `Authorization: *token*`
* `body` - [processed_order_v2.json](spec/fixtures/processed_order_v2.json)

Nesta nova api adicionamos uma camada de segurança no consumo dos endpoints, portanto para o fluxo da nova api, você deverá consumir um endpoint que retornará o token de autenticação:

* `verb` - `GET`
* `url` - `recruitment-api.deliverycenter.com`
* `endpoint` - `/auth/get_token`

#

### Após a finalização do teste, ele deve ser entregue seguindo estes passos:
1. Create a new private repo
2. On the empty repo screen there is an "import" option/button enter image description here
![image](https://user-images.githubusercontent.com/22237876/118177366-fa7a7700-b408-11eb-8ac3-4fe92758db03.png)

3. Click it and put the existing github repo url. There is no github option mention but it works with github repos too. enter image description here
![image](https://user-images.githubusercontent.com/22237876/118177376-fd756780-b408-11eb-8cb1-530516902db9.png)

4. Change the repository visibility to private
![image](https://user-images.githubusercontent.com/22237876/118177453-167e1880-b409-11eb-9ebc-bfe6d0a76b78.png)
![image](https://user-images.githubusercontent.com/22237876/118177483-20a01700-b409-11eb-9c48-b759a9346f2e.png)
![image](https://user-images.githubusercontent.com/22237876/118177497-2564cb00-b409-11eb-9760-b671f9d8eced.png)

5. Finally, invite **deliverycenter-devs** as collaborator
![image](https://user-images.githubusercontent.com/22237876/118177547-39103180-b409-11eb-8884-50f4526f6ed7.png)

#
*Sinta-se à vontade para alterar, organizar e limpar o código como achar necessário, assim como criar novos casos de teste, documentar o projeto e utilizar ferramentas que melhoram a qualidade e confiabilidade do código. A avaliação ocorrerá em acordo com o esforço colocado no projeto.*
