## Liste matériel :

Routeur : 1x Cisco ISR 4331

Switch principal (L3) : 1x Cisco Catalyst 3650

Points d'accès Wi-Fi : 1x Cisco Aironet 2802i

Serveurs : 3x Cisco UCS C220 M5

Switches de distribution : 10x Cisco Catalyst 3850

Switches d'accès : 10x Cisco Catalyst 2960-X

Firewall : 1x Cisco ASA 5506-X

Contrôleur sans fil : 1x Cisco 5520 Wireless Controller

## Note sur le câblage et l'infrastructure
Câblage Ethernet Cat6 pour les connexions filaires.
Fibre optique pour les liaisons entre les switches de distribution et le switch principal (backbone).
Baies de brassage pour organiser le câblage dans les salles de serveurs et les armoires réseau.
Onduleurs (UPS) pour assurer l'alimentation continue des équipements critiques.


Ce matériel couvre les besoins actuels et permet une future expansion du réseau, tout en garantissant une performance optimale et une gestion efficace du réseau.


L'allocation de ressources (mémoire, stockage, CPU) pour vos différents serveurs dépend de plusieurs facteurs, notamment la charge prévue, le nombre d'utilisateurs et les services exécutés. Voici quelques recommandations générales :

Serveur Windows Server 2022 GUI (AD-DS, DHCP, DNS)
RAM: 8-16 Go (selon la taille de l'environnement et le nombre d'utilisateurs)
CPU: 2-4 vCPU
Stockage: 60-100 Go (système d'exploitation + données AD + logs)
Serveur Windows Server 2022 Core (AD-DS)
RAM: 4-8 Go (selon la taille de l'environnement et le nombre d'utilisateurs)
CPU: 2 vCPU
Stockage: 40-60 Go (système d'exploitation + données AD + logs)
VM Serveur Linux Debian (membre du domaine, accessible en SSH)
RAM: 2-4 Go (selon la charge de travail prévue)
CPU: 1-2 vCPU
Stockage: 20-40 Go (système d'exploitation + applications + données)
VM Client Windows
RAM: 4-8 Go (selon l'utilisation prévue)
CPU: 2 vCPU
Stockage: 40-60 Go (système d'exploitation + applications + données)
