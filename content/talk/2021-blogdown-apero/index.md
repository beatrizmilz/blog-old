---
author: Beatriz Milz
categories:
- Lives no Youtube
date: "2021-07-30"
date_end: "2021-07-30"
draft: false
event: Canal GeoCast Brasil
event_url: https://www.youtube.com/c/geocastbrasil/featured
featured: true
layout: single
links:
- icon: youtube
  icon_pack: fab
  name: Video
  url: https://youtu.be/4Ixl2RjZEYI
location: Online
show_post_time: false
subtitle: Fazendo blogs com blogdown e R
title: Conhecendo o Hugo Apéro
excerpt: 
---

## Links úteis:

-   [Pacote blogdown](https://pkgs.rstudio.com/blogdown/)

-   [Pacote distill](https://rstudio.github.io/distill/)

-   [Livro sobre o pacote blogdown](https://bookdown.org/yihui/blogdown/)

-   [Documentação do Hugo Apéro](https://hugo-apero.netlify.app/)

-   [Alison Hill - criadora do Apéro](https://alison.rbind.io/)

-   [Tutorial da Alison Hill sobre blogdown](https://alison.rbind.io/blog/2020-12-new-year-new-blogdown/)

-   [Netlify - Site para fazer o deploy](https://www.netlify.com/)

-   [Saiba mais sobre Markdown](https://livro.curso-r.com/9-1-markdown.html)

-   [Outros temas para hugo](https://themes.gohugo.io/)

-   [Mais temas de hugo - themefisher](https://github.com/themefisher)

-   [Video Curso-R: Making of de um blog do zero com blogdown](https://www.youtube.com/watch?v=PjUcR2cZTW8&t=2s)

## Exemplos de sites e blogs com blogdown:

### Com Apéro:

-   Esse blog :)

-   [Blog da Alison Hill](https://alison.rbind.io/)

-   [Núcleo de Direito, Tecnologia e Jurimetria](https://ndtj.com.br/)

-   [Todos esses sites...](https://hugo-apero-docs.netlify.app/project/)


### Com outros temas:

-   [III SICAM](https://sicam.com.br/)

-   [Site da Curso-R](https://curso-r.com/)

-   [Blog da Curso-R](https://blog.curso-r.com/)



## Código usado

-   Baseado [neste post da Alison Hill](https://alison.rbind.io/blog/2020-12-new-year-new-blogdown/) e na [documentação do Hugo Apéro](https://hugo-apero-docs.netlify.app/start/)

```r
# 1) instalar o blogdown
remotes::install_github('rstudio/blogdown')

# 1.1) Verifique a versão instalada do Hugo. 
 blogdown::hugo_version()
# > [1] ‘0.83.1’

# 1.2) Caso não tenha o Hugo instalado, instale com a função:
blogdown::install_hugo()

# 2) Criar um projeto no RStudio. Como primeiro argumento, 
# informar o caminho até o projeto, e o nome do projeto
usethis::create_project("~/Desktop/live-blogdown")

# 3) Criar o blog com blogdown, e tema Apero
blogdown::new_site(theme = "hugo-apero/hugo-apero")

# 4) Serve site: 
blogdown::serve_site()

# 5) Criar um post:
blogdown::new_post(title = "Olá mundo!", 
                     ext = '.Rmarkdown', 
                     subdir = "post")
                     
# 6) Iniciar o controle de versão neste projeto                     
usethis::use_git()   

# 7) Criar um repositório no GitHub conectado à este projeto
usethis::use_github()
```

Depois disso, é necessário conectar o repositório com o [netlify](https://app.netlify.com/) para fazer o deploy do site:

1.  Faça login (ou o cadastro, de preferência com a conta do GitHub.

2.  Escolha "**New site from Git**".

3.  Em "**Connect to Git provider**", escolha "**GitHub**". Autorize o GitHub, caso seja necessário.

4.  Em "**Pick a repository**", escolha o repositório que você criou com o projeto do blog.

5.  Em "**Site settings, and deploy!**", não é necessário editar nada :) Clique em "**Deploy Site**".

6.  Depois de uns minutos, o deploy estará feito, porém com uma URL "esquisita" e difícil de lembrar. Para mudar, clique em "**Site settings**" e então "**Change site name**". Escolha uma URL mais amigável e clique em "Save".

## Onde mudo o conteúdo?

 - `nome_do_projeto/content/talk` - Conteúdo das palestras. Cada palestra deve ter uma pasta, com pelo menos  2 arquivos: `index.md` (com o conteúdo), e uma imagem que deve ter o nome `featured` (pode usar diferentes extensões, como `.jpg`/`.png`.

- `nome_do_projeto/content/project` - Conteúdo dos projetos. Cada projeto deve ter uma pasta, com pelo menos 2 arquivos: `index.md` (com o conteúdo), e uma imagem que deve ter o nome `featured` (pode usar diferentes extensões, como `.jpg`/`.png`. Caso a imagem  seja um hex sticker (adesivo), nomeie com `hex` também (ex. `featured-hex.jpg`)


- `nome_do_projeto/content/blog` - Posts do blog. Cada post deve ter uma pasta, com pelo menos 2 arquivos: `index` (com o conteúdo) - pode ser com extensão `.md`, `.Rmd` ou `.Rmarkdown`, porém **recomend** usar `.Rmarkdown`; e uma imagem que deve ter o nome `featured` (pode usar diferentes extensões, como `.jpg`/`.png`.

- `nome_do_projeto/content/about` - conteúdo sobre a pessoa que está escrevendo, dividido entre header, main e sidebar.