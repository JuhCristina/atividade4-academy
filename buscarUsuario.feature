Feature: Controle de usuários
    Como um cliente do PetShop
    Desejo gerenciar as informações cadastradas
    Para ter controle sobre as informações registradas na plataforma

    Background:
        * call read("hook.feature")
        * def nameUser = response.name
        * def responseBody = { name: "#(nameUser)" }
        Given url baseUrl + "/users"


    Scenario: Listar usuários
        When method get
        Then status 200
        And match response contains deep responseBody


    Scenario: Encontrar usuário por ID
        And path idDelete
        When method get
        Then status 200
        And match response contains responseBody

    
    Scenario: Encontrar usuário por nome
        Given url baseUrl + "/search"
        And param value = "Ch"
        When method get
        Then status 200
        And match response contains deep responseBody


    Scenario: Não encontrar usuário por ID inexistente
        Given url baseUrl + "/users"
        And path "ffe71ebd-2b51-4c35-bd23-1739b6567ea2"
        When method get
        Then status 404


