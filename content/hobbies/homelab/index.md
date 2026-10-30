---
title: "Homelab & Networking"
summary: "My home network as a lab: segmentation, filtered DNS, local AI and a separate test environment."
weight: 30
---

My home network ended up becoming my lab. It is organized in simple, functional layers, focused on performance, device segmentation and DNS-level content filtering.

```
Internet
   │
Cable modem (ISP router (NAT))
   │
Wi-Fi 6 router – TP-Link Archer AX23  (routing, DHCP, Wi-Fi)
   │
Managed switch – Netgear GS305E  (wired distribution)
   │
Wired devices
```
The ISP router and the AX23 both perform NAT (double NAT).

On top of that, I put a few concepts into practice:

- **IoT segmentation:** smart devices sit on an isolated network, separated from computers and phones, keeping a vulnerable device further away from important data.
- **Guest network:** visitors get internet access without seeing the main network.
- **DNS filtering:** DHCP hands out a public DNS that blocks ads and trackers, so the protection covers the whole network with nothing to install on each device.
- **Versioned documentation:** configurations and step-by-step setup guides live in git repositories, making any change easy to redo or roll back.

The centrepiece of the homelab is the local AI server: a PC that runs language models on the machine itself, with no external services, reachable from any computer on the network. Details are in the [Local AI]({{< relref "/projects/local-ai" >}}) project.

Outside the main setup, I keep a Ubiquiti lab with a UniFi Security Gateway (USG-3P) and a Cloud Key Gen2 for study and occasional testing. They stay out of production because the gateway can't keep up with my internet speed. Deciding not to put a piece of equipment into production is also part of designing a network.

In the end, the homelab is where networking, security and systems administration theory turns into practice: plan a change, test it in a separate environment, document it, and only then apply it. It's the same cycle as day-to-day IT, at home scale.