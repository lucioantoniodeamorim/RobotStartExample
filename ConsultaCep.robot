*** Settings ***
Library           SeleniumLibrary
*** Variables ***
#Url usada no teste
${URL}                   https://buscacepinter.correios.com.br/app/endereco/index.php

#Locator do campo que se insere o cep a ser pesquisado
${field_Pesquisa}        endereco

#Locator do campo de pesquisar
${btn_Pesquisa}          btn_pesquisar

#Locator do campo de resulatdo da pesquisa
${resultado_Pesquisa}    //*[@id='resultado-DNEC']/tbody/tr/td[1]

#Path do chromedriver
${driver_path}           D:/driver/chromedriver.exe 

#Cep a ser pesquisado
${CEP}                   89209674


*** Test Cases ***
Testar busca por cep
    Acessar página dos correios
    Preencher o campo de pesquisa com o cep desejado
    Clicar no botão de pesquisa
    Esperar o resultado aparecer
    Validar que o resultado retornado é o mesmo que o esperado

*** Keywords ***
Acessar página dos correios
    Create Webdriver    Chrome    executable_path=${driver_path}
    Maximize Browser Window
    Go To    ${URL} 

Preencher o campo de pesquisa com o cep desejado
    Input Text    ${field_Pesquisa}    ${CEP}  

 Clicar no botão de pesquisa
     Click Button    ${btn_Pesquisa}

Esperar o resultado aparecer
    #O correto aqui é usar um wait. Usamos o Sleep para forçar um tempo por medida pedagógica pois com o wait seria muito rápido para acompanhar visualmente
    Sleep	3s

Validar que o resultado retornado é o mesmo que o esperado
    ${resultado}  Get Text  ${resultado_Pesquisa}
    Should Be Equal As Strings    ${resultado}    Rua Boehmerwald - lado ímpar
    Log To Console    ${resultado}
