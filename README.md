# Sistema de fretes <br>

Aplicação criada em Windows 10, com uso do subsistema do Windows para Linux (WSL), com distribuição Linux Ubuntu 20.04.5

## Pré-requisitos
- Ruby 3.0.0
- Rails 7.0.4

## Gems
- Devise
- Rspec-rails
- Bootstrap

## Acessando aplicação

- Clonar repositório em pasta local
- Instalar dependências:  `$ bin/setup`
- Popular banco de dados: `$ rails db:seeds`
- Rodar aplicação em browser: `$ rails/server`

O arquivo db/seeds.rb contém dois usuários: 

```
[
  {
    name: "Mari",
    email: "mari@sistemadefrete.com.br",
    password: "password"
    role: admin
  },
  {
    name: "Pedro",
    email: "pedro@sistemadefrete.com.br",
    password: "password"
    role: standard
  }
]
``` 

As atividades foram gerenciadas através de um quadro no [Trello](https://trello.com/b/curhUqaO/sistema-de-fretes)

<br>

