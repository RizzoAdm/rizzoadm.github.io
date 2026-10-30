---
title: "Homelab e redes"
summary: "A rede de casa como laboratório: segmentação, DNS filtrado, IA local e um ambiente de testes."
weight: 30
---

A rede de casa acabou virando o meu laboratório. Ela é organizada em camadas simples e funcionais, com foco em desempenho, segmentação de dispositivos e filtragem de conteúdo no nível do DNS.

```
Internet
   │
Modem a cabo (Roteador da operadora (NAT))
   │
Roteador Wi-Fi 6 – TP-Link Archer AX23  (roteamento, DHCP, Wi-Fi)
   │
Switch gerenciável – Netgear GS305E  (distribuição cabeada)
   │
Dispositivos cabeados
```
O roteador da operadora e o AX23 fazem NAT em sequência (dual NAT).

Em cima dessa base, coloquei alguns conceitos em prática:

- **Segmentação de IoT:** os dispositivos inteligentes ficam numa rede isolada, separados dos computadores e celulares. Assim, um dispositivo vulnerável fica mais longe dos dados importantes.
- **Rede de convidados:** visitantes têm acesso à internet sem enxergar a rede principal.
- **DNS com filtragem:** o DHCP já entrega aos aparelhos um DNS público com bloqueio de anúncios e rastreadores, então a proteção vale para a rede inteira, sem instalar nada em cada aparelho.
- **Documentação versionada:** configurações e o passo a passo de cada instalação ficam em repositórios git, o que facilita refazer ou desfazer qualquer mudança.

A peça principal do homelab é o servidor de IA local: um PC que roda modelos de linguagem na própria máquina, sem depender de serviços externos, e que pode ser acessado de qualquer computador da rede. Os detalhes estão no projeto [IA local]({{< relref "/projects/local-ai" >}}).

Fora da estrutura principal, mantenho um laboratório Ubiquiti com um UniFi Security Gateway (USG-3P) e um Cloud Key Gen2, que uso para estudo e testes pontuais. Eles não vão para produção porque o gateway não acompanha a velocidade da minha internet. Esse tipo de decisão, de não colocar um equipamento em produção, também faz parte de projetar uma rede.

No fim, o homelab é onde a teoria de redes, segurança e administração de sistemas vira prática: planejar uma mudança, testar num ambiente separado, documentar e só então aplicar. É o mesmo ciclo do dia a dia de TI, em escala doméstica.