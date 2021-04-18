Feature: Login
Como um cliente
Quero acessar minha conta e me manter logado
Para que eu possa ver e resposnder enquetes de forma rápida

Cenário: Credenciais válidas
Dado que o cliente informou as credenciais válidas
Quando solicitar para fazer Login
Então o sistema deve enviar o usuário para a tela de pesquisa
E manter o usuário conectado

Cenário: Credenciais Inválidas
Dado que o clienteinformou as credenciais Inválidas
Quando solicitar para fazer Login
Então o sistema deve retornar uma mensagem de erro