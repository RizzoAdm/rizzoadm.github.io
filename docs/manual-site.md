# Manual do site

Manual central do site **rizzoadm.github.io**. Explica onde fica cada coisa, como mudar a configuração e como atualizar o tema e o Hugo sem quebrar a publicação.

- Todos os comandos rodam no **Terminal**, na pasta do site: `cd ~/Projects/mr.rizzo`.
- Arquivos de texto são editados no **VS Code** (`code .` abre a pasta inteira).
- Começo de toda sessão: `git pull`. Fim: `bash scripts/check.sh`, commit e push.

| Manual | Quando usar |
|---|---|
| **Este** (`manual-site.md`) | Mapa do site, formulário de contato, configuração, atualizações do tema e do Hugo |
| [`manual-conteudo.md`](manual-conteudo.md) | Criar ou atualizar projeto, galeria, hobby; checklist antes de publicar |
| [`manual-galerias.md`](manual-galerias.md) | Detalhes de galeria: destaques no `photos.yaml`, boas práticas de imagem, privacidade |

---

## 1. Como o site funciona (em 30 segundos)

1. Você escreve as páginas em **Markdown** (`content/`), nos dois idiomas.
2. O **Hugo** transforma tudo em HTML usando o tema **Blowfish**.
3. No `git push`, o **GitHub Actions** faz esse build no servidor do GitHub e publica no **GitHub Pages**. Leva 2 a 3 minutos.
4. Se o build der erro, o site antigo continua no ar. Nada quebra para quem visita.

Regra de ouro: **o que não passou pelo `check.sh` e pela prévia local (`hugo server`) não vai para o push.**

---

## 2. Mapa: "quero mudar X, edito Y"

| Quero mudar... | Arquivo |
|---|---|
| Texto da página inicial | `content/_index.md` (EN) e `content/_index.pt-br.md` (PT) |
| Foto da página inicial / fundo | `assets/img/avatar.jpg` / `assets/img/hero-background.webp` (mesmo nome, troque o arquivo) |
| Frase abaixo do nome ("Systems · AI · 3D") | `headline` em `config/_default/languages.en.toml` e `languages.pt-br.toml` |
| Sobre, Experiência, Habilidades | `content/about/`, `content/experience/`, `content/skills/` (`index.md` + `index.pt-br.md`) |
| Projetos, hobbies, galerias | Veja [`manual-conteudo.md`](manual-conteudo.md) |
| Texto da página de contato | `content/contact/index.md` e `index.pt-br.md` |
| Página "Obrigado" (depois de enviar mensagem) | `content/thanks/index.md` e `index.pt-br.md` |
| Itens do menu e do rodapé | `config/_default/menus.en.toml` e `menus.pt-br.toml` |
| LinkedIn / GitHub do bloco de autor | `links` em `languages.en.toml` e `languages.pt-br.toml` |
| Cores | `assets/css/schemes/rizzo.css` (ativo) e `colorScheme` em `params.toml` |
| Largura do texto, estilo da página de contato | `assets/css/custom.css` |
| Ícone da aba (favicon) | `static/` (veja a seção 6) |
| Descrição do site no Google / LinkedIn | `description` em `languages.*.toml` (seção 7) |
| Opções gerais do tema (busca, rodapé, layout da home) | `config/_default/params.toml` |
| Versão do Hugo na publicação | `HUGO_VERSION` em `.github/workflows/hugo.yml` (seção 10) |

Arquivos que **não** se mexe: tudo dentro de `themes/blowfish/` (é o tema; mudanças ali somem na próxima atualização) e `public/` (é gerado pelo build, fica fora do git).

---

## 3. Formulário de contato (Web3Forms)

### Como funciona

1. O visitante preenche nome, e-mail e mensagem e resolve o **hCaptcha**.
2. O formulário envia direto para o **Web3Forms** (serviço externo grátis). O site não guarda nada.
3. O Web3Forms manda um e-mail para o endereço cadastrado na conta, com o assunto fixo `New message from rizzoadm.github.io`.
4. O visitante vai para a página **Obrigado** do idioma dele (`/thanks/` ou `/pt-br/thanks/`).
5. No Gmail, um filtro manda essas mensagens para a label `Site/Contact` (e nunca para o spam).

### Onde fica cada peça

| Peça | Onde |
|---|---|
| Chave de acesso (`web3formsAccessKey`) | Topo de `config/_default/params.toml`, **fora** de qualquer `[seção]` |
| HTML do formulário, assunto, textos padrão em inglês | `layouts/shortcodes/rz-contact-form.html` |
| Textos em português | Parâmetros do shortcode em `content/contact/index.pt-br.md` |
| Visual do formulário | Fim de `assets/css/custom.css` |
| Painel (e-mail de destino, hCaptcha, limite de envios) | https://web3forms.com, no navegador, logado na conta |

A chave é **pública por design**: ela não revela o e-mail de destino. Pode ficar no repositório público. Quem tiver a chave só consegue mandar mensagem para você, como qualquer visitante.

### Tarefas comuns

**Trocar o e-mail que recebe as mensagens:** no painel do Web3Forms (navegador). Não muda nada no site. Se mudar de endereço, refaça o filtro no novo e-mail.

**Gerar uma chave nova** (ex.: o formulário começou a receber spam demais):
1. No painel do Web3Forms, crie a chave nova e ative o **hCaptcha** nela.
2. No VS Code, troque o valor de `web3formsAccessKey` no `params.toml`.
3. `bash scripts/check.sh`, commit (`Update Web3Forms access key`) e push.
4. No site publicado, mande uma mensagem de teste em EN e outra em PT.

**Mudar um texto do formulário** (rótulo, botão, nota):
- inglês: o valor padrão dentro de `rz-contact-form.html` (`default "Send"` etc.);
- português: o parâmetro no `index.pt-br.md`, por exemplo `{{< rz-contact-form send="Enviar" >}}`.
Os nomes aceitos (`name`, `email`, `message`, `send`, `note`, `captchaError`) estão no topo do arquivo do shortcode.

**Não mude o assunto** (`subject`) sem refazer o filtro do Gmail: o filtro depende dele.

### Teste depois de qualquer mudança

- Localmente (`hugo server`) o formulário aparece e o captcha carrega, mas o **redirecionamento para "Obrigado" só funciona no site publicado** (limite do plano grátis: o redirect precisa ser no mesmo domínio).
- No site publicado: envie uma mensagem em EN e outra em PT. Confira se chegam na label `Site/Contact` e se cada uma cai na página "Obrigado" do idioma certo.

| Sintoma | Causa provável |
|---|---|
| Build avisa `web3formsAccessKey is not set` | A linha saiu do topo do `params.toml` ou foi parar dentro de uma `[seção]` |
| Botão não envia, aviso do captcha | Captcha não resolvido, ou bloqueador de anúncios impedindo o hCaptcha |
| Mensagem não chega | Veja o spam e a label; no painel do Web3Forms, veja se o envio aparece e se o limite mensal do plano grátis estourou |
| Cai numa página do Web3Forms em vez de "Obrigado" | Teste feito no localhost (normal) ou a página `content/thanks/` foi apagada/renomeada |

---

## 4. Menus

Os menus ficam em `config/_default/menus.en.toml` e `menus.pt-br.toml`. **Mude sempre os dois.**

- `[[main]]`: menu do topo. `[[footer]]`: links do rodapé.
- `weight`: ordem (menor vem primeiro). Use dezenas (10, 20, 30...) para sobrar espaço entre itens.
- `pageRef`: página do próprio site (ex.: `"projects"`). `url`: link externo.

**Link para fora do site (ex.: o Blog, entre Hobbies e Contact):**

```toml
[[main]]
  identifier = "blog"
  name = "Blog"
  url = "/blog/"          # em menus.pt-br.toml: "/blog/pt-br/"
  weight = 55
```

Com `weight = 55`, ele fica entre Hobbies (50) e Contact (60). O blog é um site separado (repositório `RizzoAdm/blog`, Hugo + PaperMod), publicado em https://rizzoadm.github.io/blog/.

**Mesma aba ou nova aba:** o Blowfish abre em **nova aba** todo `url` que começa com `http:` ou `https:`, e na **mesma aba** os que começam com `/`. O Blog usa `/blog/` de propósito, para abrir na mesma aba. No `hugo server` esse link dá 404 (o blog não está nesta pasta); no site publicado funciona.

Não crie `content/blog/` neste site: o endereço `/blog/` já pertence ao outro repositório.

**Tirar um item do menu sem apagar a página:** comente as linhas do bloco com `#` nos dois arquivos. A página continua existindo pelo endereço direto; para escondê-la de vez, veja a seção 8.

---

## 5. Idiomas

| O quê | Onde |
|---|---|
| Idioma padrão (inglês) | `defaultContentLanguage = "en"` em `config/_default/hugo.toml` |
| Nome, título, descrição e frase de cada idioma | `config/_default/languages.en.toml` e `languages.pt-br.toml` |
| Textos das páginas | `index.md` (EN) e `index.pt-br.md` (PT) dentro de cada pasta |

- Endereços: inglês fica na raiz (`/projects/`), português em `/pt-br/` (`/pt-br/projects/`).
- Toda página precisa existir nos **dois** idiomas. O `check.sh` acusa quando falta um.
- `weight`, `date` e nomes de imagem devem ser **iguais** nos dois arquivos de uma página. Títulos, `summary` e texto mudam.
- O seletor de idioma do menu leva para a mesma página no outro idioma. Exceção conhecida: páginas de tag (os nomes das tags são diferentes em cada idioma).

---

## 6. Cores, visual e favicon

### Cores

- Esquema ativo: `colorScheme = "rizzo"` em `config/_default/params.toml`.
- Os esquemas ficam em `assets/css/schemes/`: `rizzo.css` (índigo quase preto + ciano, o atual) e `rizzo-alt.css` (azul-marinho + azul brilhante, a alternativa).
- Para testar o alternativo: troque para `colorScheme = "rizzo-alt"`, rode `hugo server` e compare. Para voltar, `"rizzo"`.
- Cada cor está em RGB separado por vírgula (`22, 168, 184`). `primary` = ciano dos destaques e links; `neutral` = fundos e textos; `secondary` = roxo discreto. Os números 50 a 900 vão do mais claro ao mais escuro.
- O site é **sempre escuro** (`defaultAppearance = "dark"`, `autoSwitchAppearance = false`, sem botão de troca no rodapé). Se um dia quiser o botão: `showAppearanceSwitcher = true` em `[footer]`; nesse caso, confira se o modo claro ficou legível.

### Ajustes de CSS

`assets/css/custom.css` vale para o site inteiro. Hoje faz o texto usar a largura total e estiliza a página de contato. Mudanças de visual vão aqui, **nunca** em `themes/blowfish/`.

### Favicon (ícone da aba)

Arquivos em `static/`: `favicon.svg` (o original, editável), `favicon.ico`, `favicon-16x16.png`, `favicon-32x32.png`, `apple-touch-icon.png` (180 px), `android-chrome-192x192.png`, `android-chrome-512x512.png` e `site.webmanifest` (nome e cor do tema quando salvo na tela inicial do celular).

Para trocar:
1. Gere os arquivos a partir de um SVG ou PNG quadrado de 512 px ou mais. O jeito mais simples: https://realfavicongenerator.net (navegador), que entrega todos os tamanhos com os mesmos nomes.
2. Copie por cima dos arquivos de `static/`, mantendo os nomes.
3. Se mudar a cor de fundo, ajuste `theme_color` e `background_color` no `site.webmanifest`.
4. Prévia, commit (`Update favicon`), push. O navegador guarda o ícone antigo em cache: confira numa aba anônima.

---

## 7. SEO e compartilhamento (Google, LinkedIn, WhatsApp)

| O quê | Onde | Observação |
|---|---|---|
| Descrição geral do site | `description` em `[params]` de `languages.en.toml` e `languages.pt-br.toml` | 1 ou 2 frases, até ~160 caracteres |
| Título da home no compartilhamento | `title` no front matter de `content/_index.md` e `_index.pt-br.md` | "Mr. Rizzo · Systems, AI & 3D" |
| Descrição de uma página | `summary` no front matter; se não tiver, `description` | O `check.sh` acusa quando falta os dois |
| Imagem do compartilhamento | `feature.jpg` da página | Sem `feature.jpg`, usa `defaultSocialImage` (avatar) do `params.toml` |
| Tirar uma página do Google | `robots: "noindex"` e `sitemap: {disable: true}` no front matter | Como em `content/thanks/` |
| Sitemap e robots.txt | Gerados sozinhos (`enableRobotsTXT = true` no `hugo.toml`) | https://rizzoadm.github.io/sitemap.xml |

**Testar como o link aparece no LinkedIn:** https://www.linkedin.com/post-inspector/ (navegador). Cole o endereço da página. Se mudou a imagem ou a descrição e o LinkedIn ainda mostra a antiga, o Post Inspector força a releitura.

**Boas práticas:** `feature.jpg` em 1200x800 (3:2), sem metadados; `summary` curto e específico ("Local LLMs on a home GPU", não "My project"); um assunto por página.

---

## 8. Esconder e mostrar seções

### Esconder uma seção inteira (ex.: Cozinha)

No front matter do `_index.md` **e** do `_index.pt-br.md` da seção:

```yaml
build:
  render: never
  list: never
  publishResources: false
cascade:
  build:
    render: never
    list: never
    publishResources: false
```

- O bloco de cima esconde a página da seção; o `cascade` esconde todas as galerias dentro dela.
- **Não use `draft: true` numa seção:** as páginas de dentro continuariam publicadas.
- **Para mostrar de novo:** apague os dois blocos nos dois arquivos, rode `hugo server` e confira o card em Hobbies.

### Esconder uma página só

`draft: true` no front matter, nos dois idiomas. O `check.sh` avisa (WARN) para você não esquecer que ela está escondida.

### Esconder um item do menu

Veja a seção 4.

---

## 9. Atualizar o tema Blowfish com segurança

O tema é um **git submodule**: o repositório do site guarda só "qual commit do Blowfish usar". Hoje: **v3.9.0** (commit `ebe683e`, outubro de 2026), que aceita Hugo **0.164.0 a 0.167.0**.

Não precisa atualizar sempre. Atualize quando houver uma correção ou recurso que você queira. Antes, leia o que mudou em https://github.com/nunocoracao/blowfish/releases (navegador).

### Passo a passo (Terminal, na pasta do site)

1. Comece com tudo limpo:
   ```bash
   git pull
   git status          # tem que dizer "nothing to commit"
   ```
2. Veja as versões disponíveis e mude para a escolhida (troque `v3.10.0` pela versão real):
   ```bash
   cd themes/blowfish
   git fetch --tags
   git tag --sort=-v:refname | head -5     # as 5 mais novas
   git checkout v3.10.0
   cd ../..
   ```
3. Confira a faixa de Hugo que a versão nova aceita:
   ```bash
   grep -A4 hugoVersion themes/blowfish/config.toml
   ```
   Se o `min` for maior que o `HUGO_VERSION` do workflow (hoje 0.167.0), **atualize o Hugo do workflow junto** (seção 10).
4. Teste com a mesma versão de Hugo do workflow (seção 10, "Testar com a versão exata") e com o `check.sh`:
   ```bash
   bash scripts/check.sh
   hugo server
   ```
   No navegador, passe por **todas** as seções nos dois idiomas, em tela cheia e no modo celular: home, About (faixa de foto), Experience (timeline), projetos (vídeos, galerias), galerias de fotografia (clique para ampliar), contato (formulário e captcha).
5. Deu certo:
   ```bash
   git add themes/blowfish
   git commit -m "Update Blowfish theme to v3.10.0"
   git push
   ```
   Confira a aba **Actions** e o site publicado.
6. Deu errado (ou não quer mais): volte para a versão anterior sem commit nenhum:
   ```bash
   git submodule update --init themes/blowfish
   ```

**Por que os `rz-*` costumam sobreviver:** os shortcodes e partials próprios ficam em `layouts/` e o CSS em `assets/css/`, fora do tema. O que pode quebrar numa versão nova são nomes de parâmetros do `params.toml` e shortcodes do próprio Blowfish (`badge`, `timelineItem`, `icon`, `button`). Se algum sumir ou mudar, o build avisa com `WARN` ou `ERROR` e o nome do arquivo.

**Em outro computador** (ou depois de um clone novo), se a pasta `themes/blowfish` estiver vazia: `git submodule update --init --recursive`.

---

## 10. Versão do Hugo

Existem **duas** versões de Hugo, e tudo bem serem diferentes:

| Onde | Versão | Quem manda |
|---|---|---|
| Seu PC (snap) | atualiza sozinho (hoje 0.169) | O snap |
| Publicação (GitHub Actions) | **0.167.0**, fixa | `HUGO_VERSION` em `.github/workflows/hugo.yml` |

O que vale é a da **publicação**. Ela fica fixa de propósito: nunca deve passar do `max` do Blowfish. No seu PC, a versão mais nova mostra um `WARN` de compatibilidade do tema; é inofensivo.

### Testar com a versão exata da publicação

Antes de mudar o tema ou o Hugo, vale compilar com a mesma versão que o GitHub vai usar. No Terminal, uma vez por versão (troque `0.167.0` se for outra):

```bash
mkdir -p ~/bin/hugo-0.167.0 && cd ~/bin/hugo-0.167.0
wget -q https://github.com/gohugoio/hugo/releases/download/v0.167.0/hugo_extended_0.167.0_linux-amd64.tar.gz
tar -xzf hugo_extended_0.167.0_linux-amd64.tar.gz hugo
cd ~/Projects/mr.rizzo
~/bin/hugo-0.167.0/hugo version
```

Depois, para testar, use esse caminho no lugar de `hugo`:

```bash
~/bin/hugo-0.167.0/hugo --gc --minify          # build igual ao da publicação (sem WARN de compatibilidade)
~/bin/hugo-0.167.0/hugo server                 # prévia com essa versão
```

O `hugo` do snap continua sendo o padrão. Nada muda no sistema.

### Mudar a versão da publicação

1. Confira o `max` do tema: `grep -A4 hugoVersion themes/blowfish/config.toml`.
2. Escolha uma versão **dentro** da faixa (de preferência o `max`).
3. Teste com essa versão exata (acima).
4. No VS Code, em `.github/workflows/hugo.yml`, mude só a linha `HUGO_VERSION: 0.167.0`. Atualize também o comentário do topo do arquivo e a linha "Hugo is pinned to..." do `README.md` e do `README.pt-br.md`, e a do `CLAUDE.md`.
5. Commit (`Bump Hugo to 0.xxx.0 in deploy workflow`), push e confira a aba Actions. Se der ❌, volte o número e faça push de novo: o site antigo continua no ar enquanto isso.

### Avisos de "actions" desatualizadas

Às vezes a aba Actions mostra um aviso amarelo do tipo "Node.js XX actions are deprecated" ou pede versão nova de `actions/checkout`, `actions/cache`, `actions/configure-pages`, `actions/upload-pages-artifact` ou `actions/deploy-pages`. Não é urgente enquanto for só aviso. Para resolver, troque o número depois do `@` no `hugo.yml` pela versão indicada em cada página da action no GitHub, faça push e confira se o deploy sai verde.

---

## 11. Quando algo dá errado

| Sintoma | O que fazer |
|---|---|
| ❌ na aba Actions | Clique na execução → **build** → leia a linha do erro. Corrija localmente, rode o `check.sh`, push de novo. O site antigo continua no ar |
| Site publicado não mudou | Espere 3 minutos, confira se o Actions terminou ✅, recarregue numa aba anônima |
| `hugo server` mostra versão velha | `Ctrl+C` e rode de novo (sempre depois de mexer em `photos.yaml`, shortcodes ou config) |
| `themes/blowfish` vazio depois de clonar | `git submodule update --init --recursive` |
| `git push` recusado (rejected) | Alguém (ou você, de outro aparelho) fez push antes: `git pull` e depois `git push` |
| Quer desfazer o último commit **antes** do push | `git reset --soft HEAD~1` (as mudanças continuam nos arquivos) |
| Quer desfazer algo **já publicado** | `git revert <commit>` e push. Cria um commit novo que desfaz o anterior; o histórico fica limpo |

Para ver os últimos commits e seus códigos: `git log --oneline -10`.

---

## 12. Privacidade (sempre)

O repositório é **público**: tudo nele, inclusive `docs/` e o histórico do git, pode ser lido por qualquer pessoa.

- Nada de e-mail ou telefone pessoal, endereço, família, casa ou rotina.
- Nenhuma senha, token ou chave secreta (a chave do Web3Forms é a única chave no repositório e é pública por design).
- Toda imagem passa pelo `prepare-images.sh` ou pelo `new.sh`; o `check.sh` confere EXIF/GPS/XMP antes de cada push.
- Antes de publicar, olhe cada foto: casa, placa de carro ou rua, reflexos, telas com dados, pessoas da família.
- Dados de projetos (ex.: Family Finance) só com valores fictícios; nada de IP, rede ou acesso externo do homelab.
