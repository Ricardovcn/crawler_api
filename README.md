# crawler_api

Aplicação desenvolvida como solução do teste para a vaga de desenvolvedor Back-End da InovaMind.

A aplicação consistem em um Web Crawler capaz de efetuar buscas no site http://quotes.toscrape.com/.

O webcrawler foi desenvolvido utilizando Ruby on Rails. 

Gems utilizadas:
- **mongoid:** Utilizada para gerenciamento do armazenamento de dados no MongoDB.
- **jwt:** Forneceu as ferramentes necessárias para implementação de authenticação com token.
- **nokogiri:** Ferramente util e eficiente para webs-crapping.

A API possui os seguintes endpoints:
- **POST /auth:** Recebe um json no formato {name: seu_nome} (não é obrigatório), e gera um Json Web Token cuja duração ou validade pode ser configurada. Atualmente está configurada em 10 minutos para facilitar possíveis testes. O acesso à todas as outras rodas da API só é permitido de posse desse Token, é necessário inserir no cabeçalho das requisições o seguinte tampo: "Authorization: Bearer <token>"
- **GET /quotes:** Retorna uma lista das Tags ja armazenadas no banco de dados utilizado para simular o cashe, ou seja, force uma lista das tags validas ja pesquisadas e armazenadas.
- **GET /auth/<search_tag>:** Verifica se no banco de dados ja existe cadastrada a tag desejada, caso esteja, utiliza os dados ja armazenados, caso contrario, utiliza a gem nokogiri para extrair os dados das paginas relacionadas à tag desejada no site especificado (A função desenvolvida para fazer o web scrapping é capaz de extrair as frases de **todas as páginas**). Conforme o previsto no enunciado do teste, esse endpoint utiliza serialização para retornar a lista de quotes no formato exigido. Caso um tag não exista ou não tenha frases associadas a ela, será retornado um código de erro (404 Not Found).

## Executando a aplicação

Para executar a aplicação basta utilizar "rails s" dentro da pasta do projeto.