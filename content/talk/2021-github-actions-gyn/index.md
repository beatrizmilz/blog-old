---
author: Beatriz Milz e Julio Trecenti
categories:
- Palestra
date: "2021-09-18"
date_end: "2021-09-18"
publishDate: "2021-09-09"
draft: false
event: Meetup R-Ladies Goiânia
event_url: https://www.sympla.com.br/introducao-a-github-actions__1342598
featured: true
layout: single
links:
#- icon: images
#  icon_pack: far
#  name: Slide em HTML
#  url: https://beatrizmilz.github.io/slidesR/git_rstudio/09-2021-gyn.html
location: Online
show_post_time: false
title: Introdução ao GitHub Actions
excerpt: O GitHub Actions (GHA) permite automatizar fluxos de trabalho de desenvolvimento em R. Nessa apresentação, falaremos sobre GitHub Actions no contexto de pacotes em R, onde será mostrado dois exemplos de uso de GitHub Actions, sendo um exemplo de checagem automática de pacotes em R, e outro que envolve a automatização de atualização de um relatório em RMarkdown.
---




Boas vindas!

Essa atividade será realizada em dupla, com o <a href='https://linktr.ee/j.trecenti'> Julio Trecenti</a>.



É muito importante proporcionar uma experiência livre de assédio para todas as pessoas participantes.  Por favor, leia o [Código de Conduta da R-Ladies](https://github.com/rladies/starter-kit/wiki/Code-of-Conduct#portuguese).



### Pré-requisitos

Essa apresentação será **expositiva**. Para praticar o que faremos na apresentação, esses são os pré-requisitos:

- Instalar o R e o RStudio (e **atualizar**):

  - [Guia de instalação do R](https://livro.curso-r.com/1-1-instalacao-do-r.html)
  
  - [Guia de instalação do RStudio](https://livro.curso-r.com/1-2-instalacao-do-rstudio.html)

- Instalar o [Git](https://git-scm.com/) (saiba mais [aqui](https://livro.curso-r.com/1-3-instalacao-adicionais.html#git))


- Criar uma conta no [GitHub](https://github.com/)


- Instalar as [Ferramentas de desenvolvimento](https://r-pkgs.org/setup.html#setup-tools):

  - Windows: [RTools instalado](https://livro.curso-r.com/1-3-instalacao-adicionais.html#rtools)
  
  - Linux: [r-base-dev](https://livro.curso-r.com/1-3-instalacao-adicionais.html#rtools)
  
  - MacOS: Xcode command line tools

Para verificar se as ferramentas de desenvolvimento estão instaladas, utilize a função:

```r
devtools::has_devel()
#> Your system is ready to build packages!
```


## Pacotes necessários

```{r eval=FALSE, include=TRUE}
pacotes <- c(
  "devtools",
  "usethis",
  "pkgdown",
  "testthat",
  "roxygen2", 
  "knitr"
) 
install.packages(pacotes)
```

### Comunidades e locais amigáveis para fazer perguntas :)

- [Eventos e redes sociais das R-Ladies no Brasil](https://github.com/R-Ladies-Sao-Paulo/RLadies-Brasil)

- [Fórum Curso-R](https://discourse.curso-r.com/)

- [Telegram R-Brasil](https://t.me/rbrasiloficial)


