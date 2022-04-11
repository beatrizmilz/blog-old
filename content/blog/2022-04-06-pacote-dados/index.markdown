---
title: "Pacote dados: bases em português para praticar e ensinar"
excerpt: "Quer saber como acessar várias bases de dados em Português com R? Post publicado no blog da Curso-R."
author: "Beatriz Milz"
date: "2022-04-06"
categories: ["ensino", "bases de dados", "importação", "pacotes"]
---




Leia o post no blog da Curso-R: [acesse aqui!](https://blog.curso-r.com/posts/2022-04-06-pacote-dados/)


## Introdução


O [pacote dados](https://cienciadedatos.github.io/dados/) disponibiliza a tradução de várias bases de dados que são originalmente disponíveis em outros pacotes de R. 
Recentemente o [pacote](https://cienciadedatos.github.io/dados/) foi disponibilizado no CRAN! 
Esse post foi escrito para que as pessoas conheçam mais sobre ele!

## Pacote dados

<img src="https://cienciadedatos.github.io/dados/reference/figures/dados-hex.png" width="30%" style="display: block; margin: auto;" />


O [pacote dados](https://cienciadedatos.github.io/dados/) disponibiliza a tradução de várias bases de dados que são originalmente disponíveis em outros pacotes de R. 

O pacote começou a ser desenvolvido em Junho de 2020, e é um irmão do pacote [datos](https://cienciadedatos.github.io/datos/). O datos foi desenvolvido para ser usado na tradução do livro [R para Ciência de Dados](https://es.r4ds.hadley.nz/) em espanhol, feita volutariamente pela comunidade Latino-Americana de R.


Um destaque importantíssimo é que as traduções do pacote dados foram feitas voluntariamente por pessoas da comunidade Latino-Americana de R, contando com a colaboração de pessoas que fazem parte da [Latin-R](https://latin-r.com/), [R-Ladies](https://rladies.org/) e [Curso-R](https://curso-r.com/material/), sendo elas: [Riva Quiroga](https://twitter.com/rivaquiroga), [Sara Mortara](https://twitter.com/MortaraSara), [Beatriz Milz](https://twitter.com/BeaMilz) (professora na Curso-R), [Andrea Sánchez-Tapia](https://twitter.com/SanchezTapiaA), [Alejandra Andrea Tapia Silva](https://twitter.com/aleants), Beatriz Maurer Costa, [Jean Prado](https://twitter.com/jeangprado), [Renata Hirota](https://twitter.com/renata_mh), [William Amorim](https://twitter.com/wamorim_) (professor na Curso-R), e [Emmanuelle Rodrigues Nunes](https://www.linkedin.com/in/emmanuellernunes/).

Alguns dos objetivos do pacote dados são:

- Disponibilizar bases de dados em português utilizadas para praticar e ensinar R (como em tutoriais, cursos, textos em blogs, livros). Por exemplo, estão disponíveis lá todas as bases usadas no livro [R for Data Science](https://r4ds.had.co.nz/), entre outras;

- Incentivar pessoas a ser tornarem desenvolvedoras em R (várias pessoas que participaram do desenvolvimento do pacote e realizaram traduções não tinham experiência anterior com colaboração via GitHub e desenvolvimento de pacotes em R, por exemplo);

- Colaborar com a diminuição da lacuna linguística em materiais usados no ensino e prática de R.

O pacote está **disponível no CRAN** e pode ser instalado utilizando o seguinte código:

```r
install.packages("dados")
```

Para que as bases fiquem disponíveis, utilize a função `library(dados)` ou use com `dados::nome_da_base`. 

Todas as bases possuem a documentação traduzida também. Você pode conferir na aba Help, usando `?dados::nome_da_base` ou conferindo [na documentação online do pacote](https://cienciadedatos.github.io/dados/reference/index.html).

Existem bases bem legais disponíveis, como:

### Star Wars <img src="https://dplyr.tidyverse.org/logo.png" align="right" width = "100px"/>

- A base de dados de personagens da franquia Star Wars, disponibilizada originalmente no pacote [dplyr](https://dplyr.tidyverse.org/reference/starwars.html). Por isso, é esperado que seja bastante útil em exemplos de manipulação de dados. Porém podemos criar visualizações bem legais também usando esses dados! Aliás, essa é a base utilizada no [desafio 3](https://blog.curso-r.com/posts/2022-04-05-desafio-3/), focado em visualização de dados, com o objetivo de replicar esse gráfico:

<img src="https://blog.curso-r.com/images/posts/conteudo/desafio-3/grafico.png" width="95%" style="display: block; margin: auto;" />

Espie a base por aqui:


```r
dplyr::glimpse(dados::dados_starwars)
## Rows: 87
## Columns: 14
## $ nome            <chr> "Luke Skywalker", "C-3PO", "R2-D2", "Darth Vader", "Le…
## $ altura          <int> 172, 167, 96, 202, 150, 178, 165, 97, 183, 182, 188, 1…
## $ massa           <dbl> 77.0, 75.0, 32.0, 136.0, 49.0, 120.0, 75.0, 32.0, 84.0…
## $ cor_do_cabelo   <chr> "Loiro", NA, NA, "Nenhum", "Castanho", "Castanho, Cinz…
## $ cor_da_pele     <chr> "Branca clara", "Ouro", "Branca, Azul", "Branca", "Cla…
## $ cor_dos_olhos   <chr> "Azul", "Amarelo", "Vermelho", "Amarelo", "Castanho", …
## $ ano_nascimento  <dbl> 19.0, 112.0, 33.0, 41.9, 19.0, 52.0, 47.0, NA, 24.0, 5…
## $ sexo_biologico  <chr> "Macho", "Nenhum", "Nenhum", "Macho", "Fêmea", "Macho"…
## $ genero          <chr> "Masculino", "Masculino", "Masculino", "Masculino", "F…
## $ planeta_natal   <chr> "Tatooine", "Tatooine", "Naboo", "Tatooine", "Alderaan…
## $ especie         <chr> "Humano", "Droide", "Droide", "Humano", "Humano", "Hum…
## $ filmes          <list> <"The Empire Strikes Back", "Revenge of the Sith", "R…
## $ veiculos        <list> <"Snowspeeder", "Imperial Speeder Bike">, <>, <>, <>,…
## $ naves_espaciais <list> <"X-wing", "Imperial shuttle">, <>, <>, "TIE Advanced…
```


### Pinguins <img src="https://allisonhorst.github.io/palmerpenguins/reference/figures/logo.png" align="right" width = "100px"/>

A  [base dos pinguins](https://allisonhorst.github.io/palmerpenguins/) foi disponibilizada com o objetivo de ser uma alternativa à base de dados `iris`. Podemos utilizar essa base para ensinar e praticar principalmente temas de visualização e manipulação de dados. 

Algo muito legal são as [vignettes do pacote original](https://allisonhorst.github.io/palmerpenguins/articles/examples.html), que apresentam tutoriais sobre como fazer visualizações interessantes com os dados. Que tal experimentar recriá-las utilizando os dados em português?

Espie a base por aqui:


```r
dplyr::glimpse(dados::pinguins)
## Rows: 344
## Columns: 8
## $ especie               <fct> Pinguim-de-adélia, Pinguim-de-adélia, Pinguim-de…
## $ ilha                  <fct> Torgersen, Torgersen, Torgersen, Torgersen, Torg…
## $ comprimento_bico      <dbl> 39.1, 39.5, 40.3, NA, 36.7, 39.3, 38.9, 39.2, 34…
## $ profundidade_bico     <dbl> 18.7, 17.4, 18.0, NA, 19.3, 20.6, 17.8, 19.6, 18…
## $ comprimento_nadadeira <int> 181, 186, 195, NA, 193, 190, 181, 195, 193, 190,…
## $ massa_corporal        <int> 3750, 3800, 3250, NA, 3450, 3650, 3625, 4675, 34…
## $ sexo                  <fct> macho, fêmea, fêmea, NA, fêmea, macho, fêmea, ma…
## $ ano                   <int> 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, …
```

### Filmes da Pixar <img src="https://erictleung.com/pixarfilms/reference/figures/logo.png" align="right" width = "100px"/>

O pacote [pixarfilms](https://erictleung.com/pixarfilms/) apresenta algumas bases de dados com informações sobre filmes da Pixar. Todas as bases foram traduzidas e disponibilizadas no pacote dados! Essas bases podem ser utilizadas para treinar manipulação e visualização de dados. Na minha opinião, essas bases são super interessantes para ensinar os concentos dos [joins do dplyr](https://dplyr.tidyverse.org/reference/mutate-joins.html)!


O post 'Pixar: Uma História de dados', foi escrito por Fernando Barbalho, e publicado no Blog da Escola de Dados, utilizando os dados deste pacote. [No meu blog há uma versão do post com os códigos para gerar todas as visualizações](https://beatrizmilz.com/blog/2021-07-01-pixar-uma-historia-de-dados/). 

Espie as bases por aqui:


```r
dplyr::glimpse(dados::pixar_filmes)
## Rows: 27
## Columns: 5
## $ ordem_lancamento         <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", …
## $ filme                    <chr> "Toy Story - Um Mundo de Aventuras", "Vida de…
## $ data_lancamento          <date> 1995-11-22, 1998-11-25, 1999-11-24, 2001-11-…
## $ duracao                  <dbl> 81, 95, 92, 92, 100, 115, 117, 111, 98, 96, 1…
## $ classificacao_indicativa <chr> "Livre", "Livre", "Livre", "Livre", "Livre", …
dplyr::glimpse(dados::pixar_avalicao_publico)
## Rows: 24
## Columns: 5
## $ filme                <chr> "Toy Story - Um Mundo de Aventuras", "Vida de Ins…
## $ nota_rotten_tomatoes <dbl> 100, 92, 100, 96, 99, 97, 74, 96, 95, 98, 98, 40,…
## $ nota_metacritic      <dbl> 95, 77, 88, 79, 90, 90, 73, 96, 95, 88, 92, 57, 6…
## $ nota_cinema_score    <chr> "A", "A", "A+", "A+", "A+", "A+", "A", "A", "A", …
## $ nota_critics_choice  <dbl> NA, NA, 100, 92, 97, 88, 89, 91, 90, 95, 97, 67, …
dplyr::glimpse(dados::pixar_bilheteria)
## Rows: 24
## Columns: 5
## $ filme                    <chr> "Toy Story - Um Mundo de Aventuras", "Vida de…
## $ orcamento                <dbl> 3.00e+07, 1.20e+08, 9.00e+07, 1.15e+08, 9.40e…
## $ bilheteria_eua_canada    <dbl> 191796233, 162798565, 245852179, 289916256, 3…
## $ bilheteria_outros_paises <dbl> 181757800, 200460294, 251522597, 342400393, 5…
## $ bilheteria_mundial       <dbl> 373554033, 363258859, 497374776, 632316649, 8…
dplyr::glimpse(dados::pixar_equipe)
## Rows: 220
## Columns: 3
## $ filme <chr> "Toy Story - Um Mundo de Aventuras", "Toy Story - Um Mundo de Av…
## $ cargo <chr> "Diretor(a)", "Roteirista", "Roteirista", "Roteirista", "Roteiri…
## $ nome  <chr> "John Lasseter", "Joel Cohen", "Alec Sokolow", "Andrew Stanton",…
dplyr::glimpse(dados::pixar_generos)
## Rows: 128
## Columns: 2
## $ filme  <chr> "Toy Story - Um Mundo de Aventuras", "Toy Story - Um Mundo de A…
## $ genero <chr> "Animação", "Aventura", "Comédia", "Família", "Fantasia", "Anim…
dplyr::glimpse(dados::pixar_oscars)
## Rows: 80
## Columns: 3
## $ filme                <chr> "Toy Story - Um Mundo de Aventuras", "Toy Story -…
## $ tipo_premio_indicado <chr> "Melhor Filme de Animação", "Melhor Roteiro Origi…
## $ resultado            <chr> "Prêmio ainda não introduzido", "Nomeado", "Inele…
```


## Todas as bases disponíveis

Veja o nome e a descrição de todas as bases disponíveis:


|Nome                   |Descrição                                                                           |
|:----------------------|:-----------------------------------------------------------------------------------|
|aeroportos             |Aeroportos                                                                          |
|arremesadores          |Tabela de estatísticas de arremesadores                                             |
|avioes                 |Dados de aviões                                                                     |
|bebes                  |Nomes de bebês                                                                      |
|casas                  |Dados de habitação em Ames                                                          |
|clima                  |Dados de clima                                                                      |
|companhias_aereas      |Nomes de companhias aéreas                                                          |
|comuns                 |Modelos comuns de carros                                                            |
|dados_atmosfera        |Dados atmosféricos                                                                  |
|dados_gapminder        |Dados de Gapminder                                                                  |
|dados_iris             |Dados de espécies de flor de Íris por Edgar Anderson                                |
|dados_oms              |Dados de tuberculose da Organização Mundial da Saúde                                |
|dados_starwars         |Personagens de Starwars                                                             |
|diamante               |Preço de 50 mil diamantes                                                           |
|gerentes               |Tabela de gerentes                                                                  |
|jardineiros            |Tabela de estatísticas do jardineiro                                                |
|milhas                 |Dados de economia de combustível de 1999 a 2008 para 38 modelos populares de carros |
|mtcarros               |Testes de estrada para automóveis                                                   |
|pessoas                |Tabela de pessoas                                                                   |
|pinguins               |Medidas de pinguins adultos perto da Estação Palmer, Antártida (Palmer Station)     |
|pixar_avalicao_publico |Filmes da Pixar e avaliações                                                        |
|pixar_bilheteria       |Bilheteria dos filmes da Pixar                                                      |
|pixar_equipe           |Equipe dos filmes                                                                   |
|pixar_filmes           |Filmes da Pixar                                                                     |
|pixar_generos          |Gêneros dos filmes da Pixar                                                         |
|pixar_oscars           |Filmes da Pixar com indicações ao Oscar                                             |
|premios_gerentes       |Tabela de prêmios dos gerentes                                                      |
|presidentes_eua        |Período que engloba 11 presidentes, desde Eisenhower até Obama                      |
|questionario           |Amostra de variáveis categóricas do questinário 'General Social Survey' (GSS)       |
|rebatedores            |Tabela de estatíticas de Beisebol                                                   |
|salarios               |Tabela de salários                                                                  |
|tabela1                |Registros de tuberculose da Organização Mundial da Saúde (primeira variante)        |
|tabela2                |Registros de tuberculose da Organização Mundial da Saúde (segunda variante)         |
|tabela3                |Registros de tuberculose da Organização Mundial da Saúde (terceira variante)        |
|tabela4a               |Registros de tuberculose da Organização Mundial da Saúde (variante 4a)              |
|tabela4b               |Registros de tuberculose da Organização Mundial da Saúde (variante 4a)              |
|tabela5                |Registros de tuberculose da Organização Mundial da Saúde (quinta variante)          |
|veiculos               |Dados de economia de combustível                                                    |
|velho_fiel             |Dados do gêiser Velho Fiel (Old Faithful)                                           |
|voos                   |Dados de voos                                                                       |



## Conclusão

Espero que o post tenha sido uma boa introdução ao [pacote dados](https://cienciadedatos.github.io/dados/), seja você uma pessoa que deseja ensinar ou praticar R.

Caso tenha sugestões de melhoria nas traduções, [escreva uma issue](https://github.com/cienciadedatos/dados/issues) no repositório do pacote!


Até a próxima!


