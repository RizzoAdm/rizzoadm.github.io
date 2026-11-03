---
title: "Política de Privacidade"
description: "Como o rizzoadm.github.io e o app privado de backup no Google Drive do dono do site tratam dados: sem analytics, sem anúncios, nenhum dado vendido ou compartilhado."
showDate: false
showDateUpdated: false
showReadingTime: false
showWordCount: false
showAuthor: false
showTableOfContents: false
showPagination: false
sharingLinks: false
---

**Última atualização:** 3 de novembro de 2026

Esta política cobre duas coisas mantidas por Mr. Rizzo: este site, **rizzoadm.github.io**, e o **Arquivos pessoais e backups gerais**, um aplicativo privado da API do Google usado só pelo dono do site para fazer backup dos próprios arquivos no próprio Google Drive. Dúvidas sobre esta política podem ser enviadas pela página de [Contato](/pt-br/contact/).

*A versão em inglês ([Privacy Policy](/privacy/)) é a versão de referência.*

## Este site

**Sem rastreamento.** Este site não tem contas de usuário, analytics, anúncios nem cookies de rastreamento. Nada do que você faz aqui é usado para montar um perfil seu.

**Hospedagem.** O site é um conjunto de arquivos estáticos hospedado no [GitHub Pages](https://pages.github.com/). Como qualquer hospedagem, o GitHub pode processar dados técnicos, como o seu endereço IP, para entregar as páginas e manter o serviço seguro. Veja a [Declaração de Privacidade do GitHub](https://docs.github.com/pt/site-policy/privacy-policies/github-general-privacy-statement).

**Armazenamento no navegador.** O tema do site pode guardar preferências de exibição (como o idioma) no armazenamento local do seu navegador. Esses dados ficam no seu aparelho e nunca são enviados ao dono do site.

**Formulário de contato.** Se você enviar uma mensagem pela página de [Contato](/pt-br/contact/), o nome, o e-mail e a mensagem que você digitar são entregues na caixa de entrada do dono do site pelo [Web3Forms](https://web3forms.com/privacy). Eles são usados só para responder a você, nunca são vendidos nem compartilhados, e você pode pedir a exclusão da sua mensagem a qualquer momento. O formulário usa o [hCaptcha](https://www.hcaptcha.com/privacy) para bloquear spam, que processa dados técnicos do seu navegador só para essa finalidade.

**Vídeos incorporados.** Algumas páginas de projeto mostram vídeos hospedados no Vimeo (com "do not track" ativado) ou no YouTube (no modo de privacidade aprimorada). Esses serviços podem processar dados quando você dá play, conforme as políticas deles: [Vimeo](https://vimeo.com/privacy) e [Google/YouTube](https://policies.google.com/privacy?hl=pt-BR).

**Links para outros sites.** Links para o LinkedIn, o GitHub e outros sites levam a serviços com políticas de privacidade próprias.

**Fotos.** Toda foto publicada neste site tem os metadados ocultos (EXIF, inclusive a localização por GPS) removidos antes da publicação.

## App de backup no Google Drive ("Arquivos pessoais e backups gerais")

**O que é.** Um cliente OAuth privado, registrado no Google Cloud e usado com o [rclone](https://rclone.org/), uma ferramenta de linha de comando open source, para que o dono do site faça backup, sincronize e restaure **os próprios arquivos** entre o próprio computador e **o próprio Google Drive**. Não é oferecido ao público, não tem outros usuários e não tem site, servidor ou banco de dados próprio.

**Dados de usuário do Google acessados.** Pela API do Google Drive, e só com as permissões concedidas na tela de consentimento do Google, o app pode listar, ler, criar, atualizar e excluir arquivos e pastas no Google Drive do dono (conteúdo, nomes, pastas e metadados dos arquivos, como tamanho e data de modificação).

**Como os dados são usados.** Só para as operações de backup, sincronização e restauração que o dono executa no próprio computador. Os dados não são usados para publicidade, criação de perfil ou pesquisa de mercado, nem para treinar modelos de IA ou de machine learning.

**Como os dados são guardados.** Os arquivos trafegam direto entre o Google Drive e o computador do dono, por conexões criptografadas (HTTPS). O token de acesso emitido pelo Google fica guardado só no arquivo de configuração do rclone, no computador do dono. Nenhuma cópia dos dados do Drive ou dos tokens fica em outro lugar.

**Compartilhamento.** Dados de usuário do Google nunca são vendidos, compartilhados ou transferidos a terceiros.

**Uso limitado.** O uso e a transferência, pelo Arquivos pessoais e backups gerais, de informações recebidas das APIs do Google para qualquer outro app seguem a [Política de Dados do Usuário dos Serviços de API do Google](https://developers.google.com/terms/api-services-user-data-policy), inclusive os requisitos de Uso Limitado.

**Revogar o acesso e excluir dados.** O acesso pode ser revogado a qualquer momento em [Conta do Google → Conexões de terceiros](https://myaccount.google.com/connections). Revogar o acesso ou apagar a configuração do rclone remove o token guardado; os arquivos no Google Drive continuam sob o controle do dono da conta.

## Mudanças nesta política

Se esta política mudar, a nova versão é publicada nesta página com uma nova data de "Última atualização".

## Contato

Use a página de [Contato](/pt-br/contact/). Nenhum e-mail pessoal é publicado neste site.
