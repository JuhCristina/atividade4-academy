Feature: Controle de usuários
    Como um cliente do PetShop
    Desejo gerenciar as informações cadastradas
    Para ter controle sobre as informações registradas na plataforma

    Background: 
        * call read("hook.feature")
        * def nameAtual = "Giovana"
        * def cadAtualizado = { name: "#(nameAtual)", email: "#(emailAleatorio)" }
        * def idUser = "7df5873a-93b3-43d9-8fac-7fdf7de573f4"
        * def cadUserError = { }
        * def cadEmailError = { name: "Maria", email: "mariagmail.com" }
        * def cadMaisDeCem = { name: "Maria Madalena Vasco de Albuquerque da Gama Silva Souza Paz de Barros Filha Segunda Neta Soares Joaquim", email: "chloe@gmail.com" }
        * def cadEmailMaisDeSessenta = { name: "Chloe", email: "chloegmail.comchloe.lilica.miguxa.forever.princess.hta.maravigold@gmail.com" }
        Given url baseUrl + "/users"


    Scenario: Atualizar usuário
        And path idDelete
        And request cadAtualizado
        When method put
        Then status 200
        * def nameUser = response.name
        * def responseBody = { name: "#(nameUser)" }
        And match response contains deep responseBody


    Scenario: Erro ao atualizar usuário não localizado
        And path idUser
        And request cadAtualizado
        When method put
        Then status 404
        * print  { error: "Usuário não localizado." }


    Scenario: Erro ao atualizar usuário sem informações necessárias
        And path idDelete
        And request cadUserError
        When method put
        Then status 400
        * print  { error: "Informe nome e email para atualizar cadastro." }


    Scenario: Erro ao atualizar usuário com email inválido
        And path idDelete
        And request cadEmailError
        When method put
        Then status 400
        * print  { error: "Informe um email válido para atualizar cadastro." }


    Scenario: Erro ao atualizar usuário com email já existente
        And path idDelete
        And request { name: "#(nameAtual)", email: "1650401341966@gmail.com" }
        When method put
        Then status 422
        And match response == { error: "E-mail already in use." }
        * print  { error: "Email já está em uso." }


    Scenario: Erro ao atualizar usuário devido nome conter mais de 100 caracteres
        And path idDelete
        And request cadMaisDeCem
        When method put
        Then status 400
        * print  { error: "Nome com mais de 100 caracteres não é permitido." }


    Scenario: Erro ao atualizar usuário devido email com mais de 60 caracteres
        And path idDelete
        And request cadEmailMaisDeSessenta
        When method put
        Then status 400
        * print  { error: "Email com mais de 60 caracteres não é permitido." }