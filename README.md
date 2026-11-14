# Boleirones — campeonato de futebol em JSP e JDBC

Aplicação web para acompanhar um campeonato de futebol: times, jogadores, estádios, jogos e gols, com um painel que mostra classificação e artilharia.

Projeto final (B2) da disciplina **Linguagem para Aplicações Internet II** (ADS, UniSALESIANO Araçatuba), entregue em novembro de 2025. O enunciado pedia tema livre com 5 tabelas, um relacionamento 1-para-n, um n-para-n e CRUD de todas.

## Funcionalidades

- CRUD de times, jogadores, estádios, jogos e gols
- Painel com classificação, jogos, jogadores, artilheiros e estádios
- Formulário único de cadastro e edição, reaproveitado entre as entidades

## Stack

- Java com JSP e JSTL 1.2
- JDBC puro, com uma classe DAO por tabela
- MySQL (Connector/J 9.5)
- Apache Tomcat, projeto Dynamic Web do Eclipse
- CSS próprio

## Banco de dados

`queryBoleirones.sql` cria o banco `Boleirones` com 5 tabelas:

| Tabela | Relações |
| --- | --- |
| Times | — |
| Jogadores | pertence a um time |
| Estadios | — |
| Jogos | time da casa, time visitante e estádio |
| Gols | liga jogador e jogo (n-para-n) |

O diagrama está em `Modelagem do banco de dados.png`.

## Como rodar

1. Execute `queryBoleirones.sql` no MySQL.
2. Ajuste usuário e senha em `src/main/java/dao/Conexao.java` (padrão `root` / `root`).
3. Importe a pasta no Eclipse como projeto existente, adicione um servidor Tomcat e execute com "Run on Server".
4. Abra `Index.jsp`.

## Estrutura

```
src/main/java/model/    classes Time, Jogador, Estadio, Jogo, Gol
src/main/java/dao/      conexão e DAOs
src/main/webapp/        páginas JSP, CSS e bibliotecas (WEB-INF/lib)
queryBoleirones.sql     criação do banco
```

## Observações

- Projeto acadêmico; a senha do banco está no código.
- O nome da pasta do projeto no Eclipse é `piratefy`.

## Autor

Fabio Luiz Florêncio da Silva · [github.com/Fabioluiiz22010](https://github.com/Fabioluiiz22010) · [LinkedIn](https://www.linkedin.com/in/fabio-l-florencio/)
