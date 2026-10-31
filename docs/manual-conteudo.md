# Manual: rotina para conteúdo novo

Como adicionar e atualizar conteúdo no site sem esquecer nada. Vale para projetos, galerias, hobbies e atualizações.

- Todos os comandos rodam no **Terminal**, na pasta do site: `cd ~/Projects/mr.rizzo`.
- Os textos são editados no **VS Code**. Para abrir a pasta inteira: `code .`
- Os detalhes de galeria (destaques, `photos.yaml`, boas práticas de imagem) estão em [`manual-galerias.md`](manual-galerias.md).
- Configuração, formulário de contato e atualização do tema/Hugo: [`manual-site.md`](manual-site.md).

---

## As 3 ferramentas

| Ferramenta | O que faz | Quando usar |
|---|---|---|
| `bash scripts/new.sh ...` | Cria a página em EN e PT a partir dos modelos (`archetypes/`), coloca o `weight` no fim da lista, processa as imagens (sem metadados) e gera a capa | Sempre que for **criar** algo ou **acrescentar imagens** |
| `bash scripts/check.sh` | Faz o checklist antes de publicar: EN e PT, `summary`, TODO esquecido, rascunho, capa, EXIF, tamanho das imagens, build | **Sempre antes do commit** |
| `hugo server` | Mostra a prévia em http://localhost:1313 | Para ver o resultado, inclusive no modo celular |

Os modelos ficam em `archetypes/` (`projects/`, `gallery/`, `hobby/`). Eles vêm com marcações **TODO** em tudo que você precisa escrever. O `check.sh` não deixa passar nenhum TODO.

---

## Começo de toda sessão

```bash
cd ~/Projects/mr.rizzo
git pull
```

Se for trabalhar com imagens, guarde os **originais fora do repositório**, por exemplo em `~/Pictures/site-originais/<seção>/<nome>`.

---

## Rotina 1: projeto novo

```bash
bash scripts/new.sh project 3d-robot ~/Pictures/site-originais/projects/3d-robot
```

- O nome (`3d-robot`) vira o endereço `/projects/3d-robot/`. Use inglês, letras minúsculas e hífens. O script recusa nomes inválidos.
- A pasta de imagens é opcional. Se for informada, as imagens vão para `gallery/01.jpg...` e a primeira vira a capa (`feature.jpg`, recorte central em 3:2).

Depois:
1. Abra no VS Code o `content/projects/3d-robot/index.md` e o `index.pt-br.md` e troque todos os TODO.
2. **Status:**
   - em andamento: deixe o badge (`In progress` / `Em andamento`) e comece o `summary` com `In progress · ` / `Em andamento · `;
   - concluído: apague a linha do badge e o prefixo do `summary`.
3. **Ordem:** o `weight` já vem como o último + 10. Para mudar a posição, troque o número nos **dois** arquivos (menor = aparece primeiro).
4. **Imagens e vídeo no texto:** copie um dos [trechos prontos](#trechos-prontos) abaixo.
5. **Capa melhor:** `bash scripts/new.sh cover content/projects/3d-robot content/projects/3d-robot/gallery/03.jpg`
6. Siga o [checklist antes de publicar](#checklist-antes-de-publicar).

Mensagem de commit sugerida: `Add project: 3D Robot`.

---

## Rotina 2: galeria nova (Fotografia, 3D por diversão, Cozinha)

```bash
bash scripts/new.sh gallery photography winter-2026 ~/Pictures/site-originais/photography/winter-2026
```

- Seções aceitas: `photography`, `3d-for-fun`, `cooking`.
- O script cria `index.md`, `index.pt-br.md` e `photos.yaml`, processa as fotos e gera a capa.
- **Cozinha está escondida.** O script avisa. Para publicar a primeira galeria de Cozinha, apague o bloco `build:` (e o mesmo bloco dentro de `cascade:`) em `content/hobbies/cooking/_index.md` **e** `_index.pt-br.md`.

Depois:
1. Troque os TODO nos dois `index` (título, uma linha de `summary`, uma linha de texto).
2. Se quiser destaques, edite o `photos.yaml` (veja [`manual-galerias.md`](manual-galerias.md), passo 4).
3. **Olhe cada foto** procurando casa, placa, rua, reflexo, família (lista completa no manual de galerias).
4. Siga o [checklist](#checklist-antes-de-publicar).

Commit: `Add photo gallery: Winter 2026` (ou `Add 3D hobby gallery: ...`).

---

## Rotina 3: atualizar algo que já existe

### Texto (ex.: status da IA jurídica)

1. Abra os **dois** arquivos: `content/projects/legal-ai/index.md` e `index.pt-br.md`.
2. Mude o texto nos dois idiomas. Na IA jurídica, normalmente são:
   - a seção **What is built so far / O que já está pronto**;
   - a lista **The plan / O plano** (troque `in progress` / `em andamento` por `done` / `concluída` e marque a próxima etapa);
   - o `summary`, se o resumo do card mudou;
   - o `date` no front matter, se quiser registrar a data da atualização.
3. Quando o projeto terminar: apague o badge e o prefixo `In progress · ` / `Em andamento · ` do `summary`.
4. Siga o [checklist](#checklist-antes-de-publicar). Commit: `Update Legal AI status`.

### Mais imagens numa página ou galeria

```bash
bash scripts/new.sh images content/hobbies/photography/moon ~/Pictures/novas-luas
```

O script descobre sozinho o próximo número (se já existem 01 a 12, começa no 13). Depois, se for o caso, ajuste o `photos.yaml` ou os `files="..."` no texto.

### Trocar uma imagem

Processe a nova numa pasta temporária e copie por cima, com o mesmo nome:

```bash
bash scripts/prepare-images.sh ~/Pictures/nova /tmp/nova
cp /tmp/nova/01.jpg content/hobbies/photography/moon/gallery/05.jpg
```

---

## Rotina 4: hobby novo (página própria, como Cycling ou Swimming)

```bash
bash scripts/new.sh hobby climbing ~/Pictures/site-originais/hobbies/climbing
```

1. Troque os TODO nos dois `index`.
2. Para colocar fotos entre os parágrafos, use `rz-photos` com `files` (veja [trechos prontos](#trechos-prontos)).
3. Se o hobby for ter **várias galerias** (como Fotografia), ele é uma **seção** e não uma página. Nesse caso, peça ajuda para criar o `_index.md`, ou copie a pasta `content/hobbies/3d-for-fun` como modelo.
4. Siga o [checklist](#checklist-antes-de-publicar). Commit: `Add hobby: Climbing`.

---

## Checklist antes de publicar

### 1. Automático (Terminal)

```bash
bash scripts/check.sh
```

- `ERROR`: corrija antes de publicar. O script termina avisando quantos erros encontrou.
- `WARN`: confira. Pode ser intencional (ex.: um rascunho que ainda não é para sair).
- Para uma conferência rápida sem o build: `bash scripts/check.sh --quick`.

O que ele confere: os dois idiomas, `summary`/`description`, TODO esquecido, `draft: true`, capa `feature.jpg`, metadados (EXIF/GPS/XMP), tamanho das imagens (até 2560 px e 2 MB) e o build de produção. No fim, mostra a lista do que vai entrar no commit.

### 2. Manual (navegador)

```bash
hugo server
```

Abra http://localhost:1313 e confira:
- [ ] o card aparece na lista, com capa e frase;
- [ ] a página abre em EN **e** em PT (troque o idioma no menu);
- [ ] imagens, galeria e vídeo aparecem; o clique amplia;
- [ ] **modo celular**: no Firefox, `Ctrl+Shift+M`; no Chrome, `F12` e depois o ícone de celular. Teste com 390 px de largura;
- [ ] nenhuma foto mostra casa, família, placa ou lugar identificável.

Para parar o servidor: `Ctrl+C` no Terminal.

### 3. Publicar (Terminal)

```bash
git status
git add <pasta ou arquivos que você mudou>
git commit -m "Add project: 3D Robot"
git push
```

- Leia o `git status` antes do `git add`: só deve aparecer o que você quer publicar.
- Mensagem de commit em inglês, curta, no imperativo: `Add ...`, `Update ...`, `Fix ...`.

### 4. Conferir a publicação (navegador)

1. Abra https://github.com/RizzoAdm/rizzoadm.github.io/actions. A execução mais recente precisa terminar com ✅ verde (leva uns 2 a 3 minutos).
2. Se aparecer ❌ vermelho, clique nela, depois em **build**, e leia a linha do erro. O site antigo continua no ar até a próxima publicação dar certo.
3. Abra https://rizzoadm.github.io **no celular** e confira a página nova. Se ainda aparecer a versão antiga, recarregue (ou abra numa aba anônima).

---

## Trechos prontos

Cole nos **dois** arquivos de idioma (traduzindo `title` e `caption`).

**Galeria em grade** (projetos):
```
{{< rz-gallery dir="gallery" cols="2" ratio="auto" >}}
```
`cols`: colunas; `ratio`: `auto` (formato original) ou `3x2`, `1x1`...; `wide="true"`: largura total; `zoom="false"`: sem clique.

**Fotos em linhas justificadas** (galerias e hobbies):
```
{{< rz-photos >}}                                         todas as fotos de gallery/
{{< rz-photos files="01 02" caption="Legenda" >}}         só algumas, com legenda
{{< rz-photos from="5" count="4" >}}                      um trecho em sequência
```

**Vídeo** (Vimeo ou YouTube, nunca no repositório):
```
{{< rz-video vimeo="ID" hash="HASH" ratio="16x9" title="Animation" >}}
{{< rz-video youtube="ID" title="Animation" >}}
```

**Vídeo ao lado de 2x2 imagens:** veja o uso no topo de `layouts/shortcodes/rz-feature.html`.

**Badge de status:**
```
{{< badge >}}In progress{{< /badge >}}
{{< badge >}}Em andamento{{< /badge >}}
```

---

## Comandos do `new.sh` (resumo)

```bash
bash scripts/new.sh project <nome> [pasta de imagens]
bash scripts/new.sh gallery <seção> <nome> <pasta de imagens>
bash scripts/new.sh hobby   <nome> [pasta de imagens]
bash scripts/new.sh images  <pasta da página> <pasta de imagens>
bash scripts/new.sh cover   <pasta da página> [imagem]
```

O script **nunca** altera os originais e **nunca** sobrescreve uma página que já existe.

Sem o script (manual): `hugo new content projects/<nome>`, `hugo new content hobbies/<seção>/<nome> --kind gallery` ou `hugo new content hobbies/<nome> --kind hobby`. Nesse caso, as imagens passam pelo `prepare-images.sh` à mão e o `weight` fica `999` até você mudar.

---

## Problemas comuns

| Sintoma | Causa provável |
|---|---|
| `check.sh` acusa TODO | Sobrou marcação do modelo. A linha e o arquivo aparecem na mensagem |
| `check.sh` acusa metadados | A imagem foi copiada direto, sem passar pelo script. Use `new.sh images` ou `prepare-images.sh` |
| Página nova não aparece | `draft: true` nos arquivos, ou a seção está escondida (Cozinha) |
| Aparece em EN mas não em PT | Falta o `index.pt-br.md`. O `check.sh` acusa |
| Card no lugar errado | `weight` diferente entre EN e PT, ou igual ao de outro card |
| Mudança no `photos.yaml` não aparece | Pare o `hugo server` (`Ctrl+C`) e rode de novo |
| Actions com ❌ | Leia o erro no log. O mais comum é um shortcode com aspas ou `>}}` faltando |
