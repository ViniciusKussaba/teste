# Sobre o projeto
Esse é um projeto para a trilha do Dojo de MVC e TDD do Curso de Imersão 10.1 realizado pelo Ateliê de Software no dia 05/11/2022.

O intuito do projeto é proporcionar para os estudantes uma vivência de desenvolvimento com TDD para construir uma página simples em MVC de forma que a aplicação esteja testada e todos os testes estejam passando.

# Instruções gerais para executar o projeto

## Instalação do Docker
O projeto foi desenvolvido utilizando uma imagem do Docker, para que possa ser executado em qualquer dispositivo, desde que tenha o Docker instalado.

Para instalar o Docker, siga as instruções:
- Windows: https://docs.docker.com/desktop/install/windows-install/
- MacOS: https://docs.docker.com/desktop/install/mac-install/
- Linux: https://docs.docker.com/desktop/install/linux-install/

## Primeira execução do projeto

Com o Docker instalado e o projeto clonado, primeiro executaremos o seguinte comando:
```
docker-compose build
```

Com o build feito, temos que executar:
```
docker-compose run --rm app bash
```

Assim que o terminal for carregado, precisamos criar o Banco de Dados e rodar as migrações do Banco:
```
rails db:reset
```

## Executar o projeto

Para visualizar a página do projeto, podemos utilizar o seguinte comando no terminal:
```
docker-compose up app
```

Após isso acesse a página pelo navegador no seguinte link: http://localhost:3000

## Rodando os testes do projeto

Para rodar os testes o comando que deve ser executado no terminal é:
```
docker-compose run --rm app bash
```

Após isso, quando o terminal estiver carregado, podemos executar todos os testes com o seguinte comando:
```
rspec
```

Caso queira rodar um teste em específico, passe o caminho do arquivo de teste:
```
rspec spec/models/patient_spec.rb
```

E caso queira rodar uma linha específica de um arquivo, passe o caminho do arquivo, seguido de ":" e o número da linha:
```
rspec spec/models/patient_spec.rb:10
```
