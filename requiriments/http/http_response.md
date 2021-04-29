# HTTP

##  Sucesso
 1 - Request com verbo http válido (post) - ok
 2 - Passar nos headers o content type JSON - ok
 3 - Chamar request com body correto - ok
 4 - Ok - 200 e resposta com dados - ok
 5 - No content - 204 e resposta sem dados - ok

##  Erros
 1 - Bad request - 400 - ok
 2 - Unauthorized -  - ok
 3 - Forbidden - 403 - ok
 4 - Not found - 404 - ok
 5 - Internal server error - 500 - ok

##  Exceção - Status code diferente dos citados acima
 Internal server error - 500 - ok

##  Exceção - Http request deu alguma exceção
 Internal server error - 500  - ok

##  Exceção - Verbo http inválido
 Internal server error - 500 - ok