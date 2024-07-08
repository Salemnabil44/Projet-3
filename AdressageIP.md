### Plan d'adressage IP
Afin d'anticiper une expansion significative à l'avenir nous utiliseraons le réseau 192.168.0.0/16.  Un réseau /16 offre 65 536 adresses (dont 65 534 utilisables), ce qui est largement suffisant pour couvrir les besoins actuels et futurs et nous allons attribuer des sous-réseaux à chaque département.

#### Informations générales :
- Réseau principal : 192.168.0.0/16
- Total d'adresses disponibles : 65 534 (après exclusion de l'adresse de réseau et de diffusion)

### Sous-réseaux par département

Pour garantir une organisation claire et permettre une expansion future significative, nous allons utiliser des sous-réseaux /24, ce qui donne 256 adresses par sous-réseau (254 utilisables).

1. **Communication : 20 employés (prévoir expansion jusqu'à 100)**
   - Sous-réseau : 192.168.1.0/24
   - Adresses disponibles : 192.168.1.1 à 192.168.1.254

2. **Direction Financière : 14 employés (prévoir expansion jusqu'à 50)**
   - Sous-réseau : 192.168.2.0/24
   - Adresses disponibles : 192.168.2.1 à 192.168.2.254

3. **Direction Générale : 8 employés (prévoir expansion jusqu'à 30)**
   - Sous-réseau : 192.168.3.0/24
   - Adresses disponibles : 192.168.3.1 à 192.168.3.254

4. **Direction Marketing : 22 employés (prévoir expansion jusqu'à 100)**
   - Sous-réseau : 192.168.4.0/24
   - Adresses disponibles : 192.168.4.1 à 192.168.4.254

5. **DSI : 12 employés (prévoir expansion jusqu'à 50)**
   - Sous-réseau : 192.168.5.0/24
   - Adresses disponibles : 192.168.5.1 à 192.168.5.254

6. **R&D : 17 employés (prévoir expansion jusqu'à 100)**
   - Sous-réseau : 192.168.6.0/24
   - Adresses disponibles : 192.168.6.1 à 192.168.6.254

7. **RH : 24 employés (prévoir expansion jusqu'à 100)**
   - Sous-réseau : 192.168.7.0/24
   - Adresses disponibles : 192.168.7.1 à 192.168.7.254

8. **Services Généraux : 12 employés (prévoir expansion jusqu'à 50)**
   - Sous-réseau : 192.168.8.0/24
   - Adresses disponibles : 192.168.8.1 à 192.168.8.254

9. **Service Juridique : 8 employés (prévoir expansion jusqu'à 30)**
   - Sous-réseau : 192.168.9.0/24
   - Adresses disponibles : 192.168.9.1 à 192.168.9.254

10. **Ventes et Développement Commercial : 46 employés (prévoir expansion jusqu'à 200)**
    - Sous-réseau : 192.168.10.0/24
    - Adresses disponibles : 192.168.10.1 à 192.168.10.254

### Configuration IP des matériels réseaux :

- **Routeur**
  - Adresse IP : 192.168.0.1

- **Switches**
  - Switch 1 : 192.168.0.2
  - Switch 2 : 192.168.0.3

- **Points d'accès Wi-Fi**
  - Point d'accès 1 : 192.168.0.4
  - Point d'accès 2 : 192.168.0.5

- **Serveurs**
  - Serveur DHCP : 192.168.0.6
  - Serveur DNS : 192.168.0.7
  - Serveur de fichiers : 192.168.0.8

### Réserve pour expansion future :

Nous avons attribué des sous-réseaux /24 à chaque département, offrant une grande capacité d'expansion. De plus, il reste de nombreux sous-réseaux disponibles pour de nouveaux départements ou une expansion future :

- **Expansion future**
  - Sous-réseaux disponibles : 192.168.11.0/24 à 192.168.255.0/24

### Résumé des adresses IP par département avec plan d'expansion future :

- **Communication** : 192.168.1.1 - 192.168.1.254
- **Direction Financière** : 192.168.2.1 - 192.168.2.254
- **Direction Générale** : 192.168.3.1 - 192.168.3.254
- **Direction Marketing** : 192.168.4.1 - 192.168.4.254
- **DSI** : 192.168.5.1 - 192.168.5.254
- **R&D** : 192.168.6.1 - 192.168.6.254
- **RH** : 192.168.7.1 - 192.168.7.254
- **Services Généraux** : 192.168.8.1 - 192.168.8.254
- **Service Juridique** : 192.168.9.1 - 192.168.9.254
- **Ventes et Développement Commercial** : 192.168.10.1 - 192.168.10.254

### Adresses pour les équipements réseau :

- **Routeur** : 192.168.0.1
- **Switches** : 192.168.0.2, 192.168.0.3
- **Points d'accès Wi-Fi** : 192.168.0.4, 192.168.0.5
- **Serveurs** : 192.168.0.6 - 192.168.0.8

Ce plan d'adressage IP en /16 assure que chaque département dispose d'une plage d'adresses IP suffisante pour ses besoins actuels et futurs, tout en laissant de la place pour des équipements réseau et des extensions futures importantes.
