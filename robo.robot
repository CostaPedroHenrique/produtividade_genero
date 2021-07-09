*** Variables ***

${HOSTNAME}             buscatextual.cnpq.br/buscatextual/busca.do
${SERVER}               http://buscatextual.cnpq.br/buscatextual/busca.do
${BROWSER}              firefox
${USERNAME}             Verônica Maria Lima Silva
${USERNAME2}            Samara Martins Nascimento
${DELAY}                3 seconds


*** Settings ***

Documentation   Teste produtividade gênero
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         OperatingSystem
Suite Setup     Start Browser
Suite Teardown  Stop Browser


*** Keywords ***

Start Browser
  Open Browser  ${SERVER}  ${BROWSER}

Stop browser
  Close Browser

Browser Shutdown
    Close Browser



*** Test Cases ***

Criar arquivo com o resultado
  Create File  ./result.txt

Buscar o currículo de Verônica  
  Go To  ${SERVER}

  set selenium speed  0.4 seconds

  Wait until page contains element  id=textoBusca

  Page Should Contain  Buscar Currículo Lattes (Busca Simples)

  Page Should Contain  Buscar por:

  Input Text    textoBusca    ${USERNAME}

  
  Click Element  botaoBuscaFiltros

  Wait until page contains element  class=resultado
  
  Click Element    css:ol li b a

  Wait until page contains element  id=idbtnabrircurriculo

  Click Element  idbtnabrircurriculo

  @{windows} =  Get Window Handles
  ${numWindows} =  Get Length  ${windows}

  # Log To Console  @{windows}

  Switch Window  Currículo do Sistema de Currículos Lattes (${USERNAME})

  Wait until page contains element  class=informacoes-autor


  ${elem} =   Get WebElements      xpath://*[@class='informacoes-autor']

  Append To File  ./result.txt  ${USERNAME}

  FOR  ${item}  IN  @{elem}
    Append To File  ./result.txt  \n${item.text}
  END

  Browser Shutdown



Buscar o currículo de Samara Martins Nascimento
  Start Browser

  Go To  ${SERVER}

  set selenium speed  0.4 seconds

  Wait until page contains element  id=textoBusca

  Page Should Contain  Buscar Currículo Lattes (Busca Simples)

  Page Should Contain  Buscar por:

  Input Text    textoBusca    ${USERNAME2} 

  
  Click Element  botaoBuscaFiltros

  Wait until page contains element  class=resultado
  
  Click Element    css:ol li b a

  Wait until page contains element  id=idbtnabrircurriculo

  Click Element  idbtnabrircurriculo

  @{windows} =  Get Window Handles
  ${numWindows} =  Get Length  ${windows}

  # Log To Console  @{windows}

  Switch Window  Currículo do Sistema de Currículos Lattes (${USERNAME2})

  Wait until page contains element  class=informacoes-autor

  Append To File  ./result.txt  \n
  Append To File  ./result.txt  \n${USERNAME2}

  ${elem} =   Get WebElements      xpath://*[@class='informacoes-autor']

  Append To File  ./result.txt  ${USERNAME2}


  FOR  ${item}  IN  @{elem}
    Append To File  ./result.txt  \n${item.text}
  END

  Browser Shutdown
