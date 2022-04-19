Feature: Controle de usuários
    Como um cliente do PetShop
    Desejo gerenciar as informações cadastradas
    Para ter controle sobre as informações registradas na plataforma

    Background: 
        Given url baseUrl + "/users"
        * def nameAleatorio = "Maria " + java.lang.System.currentTimeMillis()
        * def emailAleatorio = java.lang.System.currentTimeMillis() + "@gmail.com"
        * def cadUserError = { }
        * def cadEmailError = { name: "Maria", email: "mariagmail.com" }
        * def cadMaisDeCem = { name: "Maria Madalena Vasco de Albuquerque da Gama Silva Souza Paz de Barros Filha Segunda Neta Soares Joaquim", email: "chloe@gmail.com" }
        * def cadEmailMaisDeSessenta = { name: "Chloe", email: "chloegmail.comchloe.lilica.miguxa.forever.princess.hta.maravigold@gmail.com" }


    Scenario: Registrar um novo usuário com sucesso
        * call read("hook.feature")
        And match response contains cadUser


    Scenario: Não deve ser possível registrar um novo usuário sem informações necessárias
        And request cadUserError
        When method post
        Then status 400
        * print { error: "Informe nome e email para realizar cadastro." }


    Scenario: Não deve ser possível registrar um novo usuário com um email inválido
        And request cadEmailError
        When method post
        Then status 400
        * print { error: "Email informado com valor inválido para cadastro." }


    Scenario: Não deve ser possível registrar um novo usuário com email já cadastrado
        * call read("hook.feature") 
        * def emailDup = response.email  
        * print emailDup
        And request { name: "#(nameAleatorio)", email: "#(emailDup)" }
        When method post
        Then status 422
        And match response == { error: "User already exists." }
        * print { error: "Email informado já está em uso, favor tente outro." }


    Scenario: Não deve ser possível registrar um novo usuário usando nome com mais de 100 caracteres
        And request cadMaisDeCem
        When method post
        Then status 400
        * print { error: "Nome com mais de 100 caracteres não é permitido." }


    Scenario: Não deve ser possível registrar um novo usuário usando email com mais de 60 caracteres
        And request cadEmailMaisDeSessenta
        When method post
        Then status 400
        * print { error: "Email com mais de 60 caracteres não é permitido." }