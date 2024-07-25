# Guide d'Installation et de Configuration de VyOS

VyOS est un système d'exploitation basé sur Linux qui agit comme un routeur logiciel. Il est utilisé pour créer des appliances de réseau comme des routeurs, des pare-feu et des VPN. 

## Pré-requis
- Un ordinateur ou un serveur compatible x86_64
- Une connexion Internet pour télécharger l'image ISO de VyOS
- Un logiciel de virtualisation (facultatif, si vous installez VyOS sur une VM)
- Un logiciel pour créer une clé USB bootable (ex. : Rufus)

## Téléchargement de l'Image ISO
1. Rendez-vous sur le site officiel de VyOS : [vyos.io](https://vyos.io/)
2. Allez dans la section de téléchargement et téléchargez l'image ISO de la version stable la plus récente.

## Création d'une Clé USB Bootable
1. Téléchargez et installez Rufus depuis [rufus.ie](https://rufus.ie/).
2. Branchez une clé USB d'au moins 1 Go.
3. Ouvrez Rufus et sélectionnez l'image ISO de VyOS téléchargée.
4. Configurez Rufus pour créer une clé USB bootable et cliquez sur "Démarrer".

## Installation de VyOS
1. Insérez la clé USB dans le serveur ou l'ordinateur sur lequel vous souhaitez installer VyOS.
2. Démarrez le système et entrez dans le BIOS/UEFI pour configurer le démarrage sur la clé USB.
3. Sélectionnez la clé USB comme périphérique de démarrage et redémarrez.
4. Suivez les instructions à l'écran pour installer VyOS sur votre disque dur.

### Étapes d'Installation
1. Après le démarrage à partir de la clé USB, vous verrez le menu d'installation de VyOS.
2. Sélectionnez `Install VyOS` et appuyez sur Entrée.
3. Choisissez le disque cible pour l'installation.
4. Configurez le partitionnement si nécessaire (automatique recommandé pour la plupart des utilisateurs).
5. Suivez les invites pour définir le mot de passe du compte administrateur.
6. Une fois l'installation terminée, redémarrez le système sans la clé USB.

## Configuration Initiale
1. Connectez-vous à VyOS avec le nom d'utilisateur `vyos` et le mot de passe que vous avez défini.
2. Passez en mode de configuration :
    ```bash
    configure
    ```
3. Configurez l'adresse IP de l'interface réseau :
    ```bash
    set interfaces ethernet eth0 address '192.168.1.1/24'
    ```
4. Configurez la passerelle par défaut :
    ```bash
    set protocols static route 0.0.0.0/0 next-hop '192.168.1.254'
    ```
5. Configurez le DNS :
    ```bash
    set system name-server '8.8.8.8'
    set system name-server '8.8.4.4'
    ```
6. Validez et enregistrez les modifications :
    ```bash
    commit
    save
    exit
    ```

## Configuration Avancée

### Configurer un DHCP Server
1. Activez le serveur DHCP sur une interface :
    ```bash
    configure
    set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 range 0 start 192.168.1.100
    set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 range 0 stop 192.168.1.200
    set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 default-router 192.168.1.1
    set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 dns-server 8.8.8.8
    commit
    save
    exit
    ```

### Configurer un VPN
1. Pour un VPN OpenVPN :
    ```bash
    configure
    set interfaces openvpn vtun0 mode server
    set interfaces openvpn vtun0 server subnet 10.8.0.0/24
    set interfaces openvpn vtun0 tls ca-cert-file /config/auth/ca.crt
    set interfaces openvpn vtun0 tls cert-file /config/auth/server.crt
    set interfaces openvpn vtun0 tls key-file /config/auth/server.key
    commit
    save
    exit
    ```

## Mise à Jour de VyOS
1. Pour mettre à jour VyOS, téléchargez la nouvelle image ISO et chargez-la sur le système :
    ```bash
    add system image /path/to/vyos-1.x.x-amd64.iso
    ```
2. Suivez les instructions à l'écran pour compléter la mise à jour.

## Ressources Utiles
- [Documentation officielle de VyOS](https://docs.vyos.io/)
- [Communauté VyOS](https://forum.vyos.io/)

