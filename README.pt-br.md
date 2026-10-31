# rizzoadm.github.io

[English](README.md) | **Português**

Código-fonte do site pessoal e portfólio profissional de **Mr. Rizzo**, publicado em [rizzoadm.github.io](https://rizzoadm.github.io).

## O que é este site

Um portfólio estático que complementa o meu currículo: experiência profissional, habilidades e projetos selecionados (IA, IA jurídica, uma planilha financeira, modelagem 3D), além de fotografia e hobbies. Disponível em inglês e português.

## O que este site não é

- Sem e-mail ou telefone pessoal.
- Sem informações de família, casa ou vida privada.
- Todas as fotos são publicadas sem metadados EXIF/GPS.

## Stack

- [Hugo](https://gohugo.io/) (extended), um static site generator
- Tema [Blowfish](https://blowfish.page/), incluído como git submodule em `themes/blowfish`
- GitHub Pages, com deploy pelo GitHub Actions

## Rodar localmente

```bash
git clone --recurse-submodules https://github.com/RizzoAdm/rizzoadm.github.io.git
cd rizzoadm.github.io
hugo server
```

Depois abra http://localhost:1313.

## Estrutura

| Pasta | Para que serve |
|---|---|
| `.github/workflows/` | Workflow de deploy do GitHub Actions (`hugo.yml`) |
| `config/_default/` | Configuração do site (idiomas, menus, parâmetros do tema) |
| `assets/` | Imagens, esquemas de cor próprios e `css/custom.css` (ajustes de CSS no site inteiro) |
| `content/` | Páginas e posts. Cada página é um bundle: `index.md` (EN) + `index.pt-br.md` (PT-BR) + imagens |
| `content/projects/` | Projetos, uma pasta por projeto |
| `content/hobbies/` | Hobbies: fotografia, 3D por diversão e cozinha como seções de galerias; ciclismo, homelab e natação como páginas |
| `layouts/shortcodes/` | Shortcodes próprios `rz-*` (veja abaixo) |
| `layouts/partials/` | Partials usados pelos shortcodes `rz-*` (CSS, lightbox, layout das galerias) |
| `archetypes/` | Modelos para novos projetos, galerias e páginas de hobby (`hugo new`) |
| `scripts/` | Scripts de apoio: criação de conteúdo (`new.sh`), checagem antes de publicar (`check.sh`), preparo de imagens (`prepare-images.sh`) |
| `static/` | Arquivos servidos como estão (ícones do site / favicon, `site.webmanifest`) |
| `themes/blowfish/` | Tema (submodule) |
| `docs/` | Notas do projeto, log de progresso e manuais (não aparecem no site) |

## Shortcodes próprios

O uso de cada um está documentado no topo do arquivo em `layouts/shortcodes/`.

| Shortcode | O que faz |
|---|---|
| `rz-photos` | Galeria de fotos em linhas justificadas: formato original, sem corte, nível de destaque por foto (1–4) num `photos.yaml` compartilhado pelos dois idiomas, subconjuntos opcionais (`files`, `from`/`count`) e legendas, clique para ampliar |
| `rz-gallery` | Grade de imagens com proporção fixa ou original, placeholders opcionais, lightbox e bloco de vídeo |
| `rz-video` | Embed responsivo do Vimeo ou YouTube (os vídeos não ficam no repositório) |
| `rz-feature` | Vídeo ao lado de uma grade 2×2 de imagens |
| `rz-contact-cards` / `rz-contact-card` | Cards clicáveis dos canais de contato (LinkedIn, GitHub, mensagem) |
| `rz-contact-form` | Formulário de contato enviado pelo [Web3Forms](https://web3forms.com/) (hCaptcha + honeypot), redireciona para a página `thanks/` do idioma atual |

## Imagens

Toda imagem passa pelo `scripts/prepare-images.sh` antes do commit:

```bash
bash scripts/prepare-images.sh <pasta de origem> <bundle>/gallery [número inicial]
```

O script renomeia os arquivos em sequência (`01.jpg`, `02.jpg`, ...), remove **todos** os metadados (EXIF, GPS, câmera, caminhos de arquivo), converte para JPEG sRGB (qualidade 88) e limita o lado maior a 2560 px. Os originais nunca são alterados e ficam fora do repositório.

## Adicionar conteúdo

```bash
bash scripts/new.sh project <slug> [pasta de imagens]              # projeto novo (EN + PT, imagens, capa)
bash scripts/new.sh gallery <seção> <slug> <pasta de imagens>      # galeria nova em photography / 3d-for-fun / cooking
bash scripts/new.sh hobby <slug> [pasta de imagens]                # página de hobby nova
bash scripts/new.sh images <pasta da página> <pasta de imagens>    # acrescentar imagens a uma página existente
bash scripts/check.sh                                              # checklist antes de publicar (rodar antes de todo push)
```

Páginas novas são criadas a partir de `archetypes/` com marcações `TODO`; o `check.sh` falha enquanto sobrar alguma. Ele também confere se toda página existe nos dois idiomas, tem resumo e capa, se nenhuma imagem tem metadados e se o build de produção sai sem avisos.

## Documentação

| Manual | Conteúdo |
|---|---|
| [`docs/manual-site.md`](docs/manual-site.md) | Manual central: mapa do site, formulário de contato, configuração (menus, idiomas, cores, favicon, SEO, esconder seções) e atualização do tema e do Hugo |
| [`docs/manual-conteudo.md`](docs/manual-conteudo.md) | Rotina para conteúdo novo: projetos, galerias, hobbies, atualizações e checklist antes de publicar |
| [`docs/manual-galerias.md`](docs/manual-galerias.md) | Galerias em detalhe: destaques no `photos.yaml`, boas práticas de imagem, checklist de privacidade |

## Publicação

Todo push na `main` roda o `.github/workflows/hugo.yml`, que compila o site com o Hugo extended e publica no GitHub Pages (Settings → Pages → Source: **GitHub Actions**).

- O Hugo está fixado na versão **0.167.0**, a mais nova suportada pelo tema Blowfish (0.164–0.167). Antes de atualizar, confira `[module.hugoVersion]` em `themes/blowfish/config.toml`.
- O workflow baixa o submodule do tema; as imagens processadas ficam em cache entre as execuções.
- Também dá para rodar à mão pela aba **Actions** (`workflow_dispatch`).

## Status

No ar em [rizzoadm.github.io](https://rizzoadm.github.io). Rotina de conteúdo e documentação completas.
