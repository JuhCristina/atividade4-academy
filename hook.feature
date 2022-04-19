Feature: Hook

    Scenario: Remover um usuário
        * def nameAleatorio = "Chloe " + java.lang.System.currentTimeMillis()
        * def emailAleatorio = java.lang.System.currentTimeMillis() + "@gmail.com"
        * def cadUser = { name: "#(nameAleatorio)", email: "#(emailAleatorio)" }
        Given url baseUrl
        And path "users"
        And request cadUser
        When method post
        Then status 201
        * def idDelete = response.id
        * print idDelete