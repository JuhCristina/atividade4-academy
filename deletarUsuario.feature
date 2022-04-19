Feature: Controle de usuários
    Como um cliente do PetShop
    Desejo gerenciar as informações cadastradas
    Para ter controle sobre as informações registradas na plataforma


    Scenario: Remover um usuário
        * call read("hook.feature")
        Given url baseUrl + "/users"
        And path idDelete
        When method delete
        Then status 204


    Scenario: Remover um usuário não localizado
        Given url baseUrl + "/users"
        And path "2954b046-1025-41f5-a5fc-c3b141159bb2"
        When method delete
        Then status 204