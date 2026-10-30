# Manual: galerias de 3D e fotografia

Como adicionar e atualizar galerias em **Hobbies → 3D por diversão**, **Hobbies → Fotografia** e **Hobbies → Cozinha**.

- Todos os comandos rodam no **Terminal**, na pasta do site (`cd ~/Projects/mr.rizzo`).
- Os arquivos de texto são editados no **VS Code**.

---

## Resumo rápido (para quem já fez uma vez)

```bash
cd ~/Projects/mr.rizzo
cp -r content/hobbies/3d-for-fun/example-gallery content/hobbies/3d-for-fun/NOME
bash scripts/prepare-images.sh ~/PASTA-ORIGEM content/hobbies/3d-for-fun/NOME/gallery
# editar index.md e index.pt-br.md (apagar draft: true) e photos.yaml
convert content/hobbies/3d-for-fun/NOME/gallery/01.jpg -resize 1200x800^ -gravity center -extent 1200x800 -strip -quality 88 content/hobbies/3d-for-fun/NOME/feature.jpg
hugo server
git add content/hobbies/3d-for-fun/NOME && git commit -m "Add 3D hobby gallery: TÍTULO" && git push
```

Para fotografia, troque `3d-for-fun` por `photography`. Para cozinha, por `cooking`.

---

## Onde fica cada coisa

```
content/hobbies/
├── 3d-for-fun/                 ← seção 3D por diversão (cards das galerias)
│   ├── _index.md / _index.pt-br.md   texto do topo da seção
│   ├── example-gallery/        ← MODELO (rascunho, não é publicado)
│   └── robo-low-poly/          ← uma galeria = uma pasta
│       ├── index.md            texto em inglês
│       ├── index.pt-br.md      texto em português
│       ├── photos.yaml         destaques e ordem (opcional)
│       ├── feature.jpg         capa do card (3:2, 1200x800)
│       └── gallery/            imagens: 01.jpg, 02.jpg, ...
├── photography/                ← seção Fotografia (mesma estrutura)
└── cooking/                    ← seção Cozinha (mesma estrutura)
```

---

## Passo a passo: nova galeria

### 1. Criar a pasta a partir do modelo

```bash
cd ~/Projects/mr.rizzo
cp -r content/hobbies/3d-for-fun/example-gallery content/hobbies/3d-for-fun/robo-low-poly
```

O nome da pasta vira o endereço da página (`/hobbies/3d-for-fun/robo-low-poly/`). Regras:
- em inglês, minúsculas, sem acento nem espaço, com hífen no lugar do espaço;
- curto e descritivo: `night-sky`, `winter-2025`, `robot-low-poly`;
- **não use nomes de ruas, bairros ou lugares perto de casa.**

### 2. Preparar as imagens (sempre pelo script)

```bash
bash scripts/prepare-images.sh ~/Pictures/renders-robo content/hobbies/3d-for-fun/robo-low-poly/gallery
```

O script **não altera os originais**. Ele grava cópias novas na pasta `gallery/` e faz isto com cada imagem:
1. renomeia em sequência (`01.jpg`, `02.jpg`…), seguindo a ordem dos nomes originais;
2. **remove todos os metadados**: EXIF, GPS, modelo da câmera, data, caminho do arquivo do Blender;
3. converte para JPEG sRGB, qualidade 88, com o lado maior limitado a 2560 px.

Para **acrescentar fotos** a uma galeria existente, informe o próximo número. Por exemplo, se já existem 01 a 12:

```bash
bash scripts/prepare-images.sh ~/Pictures/novas content/hobbies/3d-for-fun/robo-low-poly/gallery 13
```

### 3. Escrever os textos

Abra no VS Code o `index.md` (EN) e o `index.pt-br.md` (PT):

```yaml
---
title: "Low-Poly Robot"
summary: "Character modeled and lit in Blender."
weight: 10
---

One line about this project.

{{< rz-photos >}}
```

- **Apague a linha `draft: true`.** Enquanto ela existir, a página só aparece com `hugo server -D` e não é publicada.
- `title`: o título da página e do card.
- `summary`: a frase do card. Deixe em uma linha curta.
- `weight`: a ordem dos cards. O número menor aparece primeiro. Use 10, 20, 30… para sobrar espaço entre eles.
- Os **dois idiomas** precisam do arquivo. Se faltar um, a página não aparece naquele idioma.
- O `{{< rz-photos >}}` é a galeria. Ele pode ficar abaixo do texto ou entre parágrafos.

### 4. Definir os destaques (opcional): `photos.yaml`

Esse arquivo vale para os dois idiomas ao mesmo tempo.

| Nível | Resultado |
|---|---|
| **1** | Linha inteira só para a foto |
| **2** | Grande: divide a linha com no máximo 1 outra |
| **3** | Normal (padrão) |
| **4** | Pequena: cabem mais por linha |

**Opção A: só as exceções.** As demais ficam no nível 3, em ordem de nome.
```yaml
highlight: "01:1 05:2 09:2"
```

**Opção B: lista completa.** Controla a ordem e o destaque de cada foto. Se ela existir, tem prioridade.
```yaml
order:
  - 05.jpg: 1
  - 01.jpg
  - 02.jpg: 2
  - 03.jpg
```
As fotos que não estiverem na lista entram no final, no nível 3.

Dicas de diagramação:
- Use o nível 1 com moderação: uma ou duas fotos por galeria, de preferência horizontais.
- Intercale as fotos de nível 2 com fotos normais. Duas de nível 2 seguidas acabam dividindo a mesma linha.
- Uma foto vertical logo antes de um destaque pode sobrar sozinha na linha. Para resolver, mude a ordem.
- No YAML, use **espaços** para indentar, nunca Tab.

### 5. Vídeo (opcional)

Os vídeos ficam no **Vimeo** ou no **YouTube**, nunca no repositório. Coloque a linha nos dois arquivos de idioma:

```
{{< rz-video vimeo="1240101454" hash="6a315bf987" ratio="16x9" title="Animation" >}}
{{< rz-video youtube="VIDEO_ID" title="Animation" >}}
```

- No Vimeo, o `hash` é o valor depois de `?h=` no código de incorporação (Share → Embed).
- `ratio`: `16x9` (padrão), `4x5` (feed do Instagram), `1x1` (quadrado), `9x16` (vertical).
- No Vimeo, configure a privacidade como **"Hide from Vimeo"** e permita a incorporação em `rizzoadm.github.io`.

### 6. Capa do card: `feature.jpg`

A capa é obrigatória para o card ter imagem. Use 3:2, 1200x800 px, sem metadados. Para gerar a partir de uma imagem da galeria, cortando pelo centro:

```bash
convert content/hobbies/3d-for-fun/robo-low-poly/gallery/01.jpg -resize 1200x800^ -gravity center -extent 1200x800 -strip -quality 88 content/hobbies/3d-for-fun/robo-low-poly/feature.jpg
```

- Escolha uma imagem com o assunto no centro, porque as bordas são cortadas.
- Se quiser uma capa feita à parte, salve-a como `feature.jpg` na pasta da galeria, em 1200x800, e passe pelo `-strip` como acima.

### 7. Conferir antes de publicar

```bash
hugo server
```
Abra `http://localhost:1313/hobbies/` no navegador e confira:
- [ ] o card aparece, com capa e frase;
- [ ] a versão PT funciona (troque o idioma no menu);
- [ ] os destaques ficaram como você queria;
- [ ] no celular a página também fica boa. Para simular no Firefox, use `Ctrl+Shift+M`. No Chrome, `F12` e depois o ícone de celular;
- [ ] o clique amplia a imagem.

Para parar o servidor, use `Ctrl+C` no Terminal.

### 8. Publicar (git)

```bash
git status
git add content/hobbies/3d-for-fun/robo-low-poly
git commit -m "Add 3D hobby gallery: Low-Poly Robot"
git push
```

Antes do `git add`, leia o `git status` e confira se só aparece o que você quer publicar.

---

## Boas práticas de imagem

### Resolução e tamanho
- **Lado maior de até 2560 px** é suficiente (o script já limita). Quem gera as versões menores para tela e celular é o próprio Hugo, então não envie originais de 6000 px.
- **Tamanho por arquivo:** de 300 KB a 1,5 MB depois do script. Para conferir, rode `du -h content/hobbies/*/*/gallery/*`.
- Se alguma imagem passar de ~2 MB, abra `scripts/prepare-images.sh` e reduza `QUALITY=88` para 82, ou `MAX=2560` para 2000. Depois rode o script de novo numa pasta vazia.
- **O repositório guarda tudo para sempre.** Uma imagem enviada e depois apagada continua no histórico do git, então mantenha as imagens leves desde o início. O GitHub recomenda repositórios abaixo de 1 GB.

### Formato
- **JPEG** é o formato final de fotos e renders. O script converte PNG, TIFF e WebP para JPEG.
- O fundo **transparente** de PNG vira **preto** na conversão. Se precisar de outro fundo, renderize ou exporte já com fundo.
- **Cor:** o site usa **sRGB** (o script converte). No Blender, exporte com a transformação de vista que você usou no render (AgX/Filmic/Standard) já aplicada na imagem salva.
- **Vídeo** nunca vai no repositório, só no Vimeo ou YouTube.

### Metadados e privacidade
- **Sempre passe as imagens pelo script**, mesmo renders. Um render do Blender guarda o caminho do arquivo, que pode ter o seu nome de usuário e nomes de pastas.
- Para conferir se uma imagem está limpa, rode o comando abaixo. Se ele não imprimir nada, a imagem está sem EXIF:
  ```bash
  identify -format "%[EXIF:*]" content/hobbies/3d-for-fun/robo-low-poly/gallery/01.jpg
  ```
- O GPS é removido, mas **o conteúdo da foto também pode revelar** informação. Antes de publicar, olhe cada foto procurando:
  - fachada ou interior de casa, número de casa, placa de carro;
  - nomes de rua, pontos conhecidos perto de casa, rotas frequentes (bicicleta!);
  - reflexos em vidros, óculos e espelhos;
  - telas com informações pessoais, documentos, crachás;
  - família e crianças. Outras pessoas só entram com consentimento e sem identificação.
- **Nada de originais no repositório:** só entra o que saiu do script.

### Capa e diagramação
- Capas de **todas** as galerias em 3:2, 1200x800, para os cards ficarem alinhados.
- Galerias pequenas (até 6 imagens) ficam bem com um destaque 1 e as demais normais.
- Galerias grandes (20+) ficam bem com 1 ou 2 destaques de nível 1, alguns de nível 2 e o resto normal.

---

## Atualizar ou remover

| Quero… | Como |
|---|---|
| Acrescentar fotos | Script com o número inicial (passo 2) |
| Mudar a ordem ou os destaques | Editar o `photos.yaml` |
| Trocar uma foto | Apague `gallery/05.jpg` e coloque a nova com o mesmo nome. Rode o script numa pasta temporária e copie o arquivo para lá |
| Esconder uma galeria sem apagar | Coloque `draft: true` nos dois `index` |
| Mudar a ordem dos cards | Alterar o `weight` |
| Apagar uma galeria | `git rm -r content/hobbies/3d-for-fun/NOME` → commit → push |
| Esconder uma categoria inteira de Hobbies | Ver abaixo |

### Esconder uma categoria de Hobbies (sem apagar)

Copie este bloco no cabeçalho (entre os `---`) dos **dois** arquivos do idioma:
- **seção** (Fotografia, 3D, Cozinha): `_index.md` e `_index.pt-br.md`;
- **página simples** (Homelab, Bicicleta, Natação): `index.md` e `index.pt-br.md`.

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

Com isso somem o card, a página, as galerias de dentro e as imagens, inclusive no `hugo server -D`. Para mostrar de novo, apague o bloco.

- Em páginas simples, o `cascade` não é necessário, mas não atrapalha. Use o bloco inteiro sempre.
- **Não use `draft: true` em seções.** Ele esconde o card, mas as galerias publicadas de dentro continuam acessíveis pelo endereço direto.
- Revise a `description` em `content/hobbies/_index.md` e `_index.pt-br.md`, que lista os hobbies.

---

## Problemas comuns

| Sintoma | Causa provável |
|---|---|
| A galeria não aparece na lista | Ficou `draft: true`, ou o servidor está rodando sem `-D` (normal para rascunho) |
| Aparece em EN mas não em PT | Falta o `index.pt-br.md` |
| O card está sem imagem | Falta o `feature.jpg` na pasta da galeria |
| A galeria aparece vazia | As imagens não estão na pasta `gallery/` ou não são `.jpg/.png/.webp` |
| Caixa tracejada com nome de arquivo | O nome está no `order:` do `photos.yaml`, mas o arquivo não existe |
| Erro ao rodar `hugo server` mencionando `photos.yaml` | Indentação com Tab ou dois-pontos faltando no YAML |
| "There are no articles to list here yet" | A seção ainda não tem galeria publicada |
| A página não atualiza | Pare com `Ctrl+C` e rode `hugo server` de novo, depois recarregue com `Ctrl+Shift+R` |
