---
date: "2021-03-15"
draft: false
excerpt: "No blog da Curso-R, colaborei com três posts que apresentam dicas para fazer tabelas, gráficos e relatórios em R.  Neste post, comentamos algumas dicas sobre elaboração de relatórios em R. "
subtitle: ""
title: "Dicas para elaborar relatórios em R"
weight: 3
---




No blog da Curso-R, colaborei com três posts que apresentam dicas para fazer tabelas, gráficos e relatórios em R. Leia os posts completos através dos links a seguir:

- [Dicas para criar **tabelas**](https://blog.curso-r.com/posts/2020-12-03-dicas-relatorios-r4ds1_tabelas/)

- [Dicas para **gráficos**](https://blog.curso-r.com/posts/2020-17-02-dicas-relatorios-r4ds1_graficos/)

- [Dicas para **relatórios**](https://blog.curso-r.com/posts/2021-03-15-dicas-relatorios-r4ds1_relatorios/)



Olá!

Este post é uma continuação dos posts onde apresentamos os trabalhos premiados no curso [R para Ciência de Dados I](https://curso-r.com/cursos/r4ds-1/) ([este](https://www.curso-r.com/blog/2020-12-03-dicas-relatorios-r4ds1_tabelas/) e [este](https://blog.curso-r.com/posts/2020-17-02-dicas-relatorios-r4ds1_graficos/)).

Neste post, apresentaremos algumas dicas para elaborar relatórios com o pacote [`rmarkdown`](https://rmarkdown.rstudio.com/)!



<div class="figure" style="text-align: center">
<img src="https://github.com/allisonhorst/stats-illustrations/raw/master/rstats-artwork/reproducibility_court.png" alt="Ilustração sobre o pacote rmarkdown, criada por &lt;a href='https://github.com/allisonhorst/stats-illustrations'&gt;Allison Horst&lt;/a&gt;." width="50%" />
<p class="caption">Figure 1: Ilustração sobre o pacote rmarkdown, criada por <a href='https://github.com/allisonhorst/stats-illustrations'>Allison Horst</a>.</p>
</div>

##  Dicas para elaborar relatórios 

### Contextualize!

A primeira dica é escrever uma introdução para ajudar a contextualizar a sua análise. Por exemplo:

- Qual é a pergunta que deseja responder a partir dos dados?

- Qual é a base de dados utilizadas? É legal também contextualizar a base.
  - Qual é a fonte destes dados? 
  - De qual(ou quais) ano(s) essa base se refere?
  - Quais são as variáveis presentes na base de dados?


Da mesma forma, é legal também escrever uma conclusão ao final da análise. A pergunta inicial foi respondida? Se sim, qual é a resposta? 

### Quem é o seu público-alvo?

É interessante pensar tambem quem são as pessoas do seu público alvo, e adaptar o relatório para este público. Para quem você está escrevendo?

Por exemplo, em um relatório de negócios, dificilmente você deixará os códigos visíveis no seu relatório. Por outro lado, em um relatório feito para as pessoas do seu time de cientistas de dados, pode ser interessante deixar os códigos para que saibam o que foi feito na análise. 

### Controle como o conteúdo é apresentado!

Os Chunks nos relatórios feitos com RMarkdown são campos de código onde podemos executar códigos em R. As *chunk options* (ou opções de chunk), definem como esse código e os resultados gerados aparecerão no relatório final. A seguir estão alguns úteis:

- Não é interessante aparecer mensagens de aviso (warnings) e mensagens geradas pelo código no relatório. Para ocultar essas mensagens e avisos, é possível utilizar as seguintes opções de chunk: `message = FALSE, warning = FALSE` (mas cuidado, pois essas mensagens podem não ser importantes para as pessoas leitoras do relatório, mas podem ser úteis para você!).

- Utilize as chunk options para personalizar como as imagens devem aparecer! Por exemplo:

  - `fig.align='center'` - para centralizar horizontalmente as imagens;

  - `echo=FALSE` - para não mostrar o código que gera as imagens;

  - `out.width="90%"` - para especificar a largura da página que deve ser ocupada pela imagem (neste exemplo, deixamos 90% para que a imagem ocupe 90% da largura disponível na página).


- Utilize as chunk options para personalizar como os códigos devem aparecer! Por exemplo:

  - Apresentar o código e o resultado: `echo=TRUE`

  - Apresentar apenas o código, e não executá-lo:  `echo=TRUE, eval=FALSE`

  - Apresentar apenas os resultados:  `echo=FALSE`


### Tabelas

Quando quiser representar dados em tabelas, não esqueça de formatá-las com alguma função com essa finalidade. Por exemplo, primeiro vamos criar uma tabela pequena com os 5 personagens com maior massa presentes na base [starwars](https://dplyr.tidyverse.org/reference/starwars.html). 


```r
# Carregar o pacote tidyverse
library(tidyverse)

# Criar uma tabela de exemplo
sw_top5_maiormassa <- dplyr::starwars %>% 
  arrange(desc(mass)) %>% 
  select(name, mass) %>% 
  head(5)
```

Podemos apresentar esses dados usando apenas o nome da base criada, porém não ficará com uma formatação legal:


```r
sw_top5_maiormassa
```

```
## # A tibble: 5 x 2
##   name                   mass
##   <chr>                 <dbl>
## 1 Jabba Desilijic Tiure  1358
## 2 Grievous                159
## 3 IG-88                   140
## 4 Darth Vader             136
## 5 Tarfful                 136
```

Podemos usar diversas funções para formatar esses dados como uma tabela organizada. Um exemplo de função é a `knitr::kable()`:


```r
sw_top5_maiormassa %>% 
  knitr::kable(col.names = c("Nome", "Massa"))
```



|Nome                  | Massa|
|:---------------------|-----:|
|Jabba Desilijic Tiure |  1358|
|Grievous              |   159|
|IG-88                 |   140|
|Darth Vader           |   136|
|Tarfful               |   136|
                 
Não esqueça de conferir [este post](https://www.curso-r.com/blog/2020-12-03-dicas-relatorios-r4ds1_tabelas/) que apresenta dicas para formatar as tabelas!

Confira também outras funções úteis para gerar tabelas, como por exemplo: [`gt::gt()`](https://gt.rstudio.com/), [`DT::datatable()`](https://rstudio.github.io/DT/), [`kableExtra::kbl()`](https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html) e muitas outras!


### Código em linha

Podemos adicionar resultados de códigos junto aos textos, utilizando a seguinte sintaxe:


```r
`r codigo_em_r`
```

Por exemplo, podemos primeiro criar alguns objetos para usarmos no texto:


```r
personagem_mais_baixo <- dplyr::starwars %>%
  arrange(height) %>%
  slice(1)

media_altura <- dplyr::starwars %>%
  summarise(media_altura = mean(height, na.rm = TRUE)) %>%
  pull()
```

Agora podemos usar estes objetos no texto: 


> A base starwars, disponível no pacote `{dplyr}`, apresenta 87 personagens presentes nos filmes. O personagem com menor altura da franquia é o Yoda, com a altura de 66 centímetros. A média da altura dos personagens presentes na base é de 1.74 metros.

O código a seguir gera o parágrafo que apresentamos acima:


```r
A base starwars, disponível no pacote `{dplyr}`,
apresenta `r nrow(dplyr::starwars)` personagens presentes nos filmes. 
O personagem com menor altura da franquia é o `r personagem_mais_baixo[[1]]`,
com a altura de `r personagem_mais_baixo[[2]]` centímetros.
A média da altura dos personagens presentes na base é
de `r round(media_altura/100, 2)` metros.
```

Sabemos então que os personagens da série The Mandalorian não estão na base, pois o personagem Baby Yoda teria uma estatura mais baixa que o Yoda! Mas um exemplo legal sobre a utilidade do código em linha é pensar que, se algum dia atualizarem a base, este relatório ao ser gerado novamente (através do botão `knit`) teria seus resultados atualizados também! 


<img src="https://media.giphy.com/media/Wn74RUT0vjnoU98Hnt/giphy.gif" width="50%" style="display: block; margin: auto;" />


## Um extra: escreva sobre assuntos que te interessa!

Uma última dica (que nem sempre é possível): escreva sobre temas que te interessa! As análises sempre ficam mais interessantes quando entendemos melhor os dados.   


<img src="https://media.giphy.com/media/3o8doOlGO3pjQa5h28/giphy.gif" width="50%" style="display: block; margin: auto;" />


## Conclusões

Essas dicas surgiram a partir da avaliação dos trabalhos do curso [R para Ciência de Dados I](https://curso-r.com/cursos/r4ds-1/). Porém existem muitas outras possibilidades para elaborar relatórios! Recomendamos a leitura do [capítulo sobre relatórios](https://livro.curso-r.com/9-relatorios.html) do livro [Ciência de Dados em R](https://livro.curso-r.com/index.html). Além disso, dia 18 de março começam as aulas do curso de [Relatórios e visualização de dados](https://curso-r.com/cursos/visualizacao/), então se você tem interesse nesse tema, confira a página do curso!


E caso você tenha interesse em saber mais sobre os outros cursos, confira a [página de cursos](https://www.curso-r.com/cursos/)!
