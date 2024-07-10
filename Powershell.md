Pour créer un script PowerShell afin de configurer Active Directory selon les données de votre fichier Excel (Annexe.xlsx), nous devons d'abord analyser le contenu du fichier. Ensuite, nous utiliserons ces données pour créer les Unités d'Organisation (OU), les groupes, et intégrer les utilisateurs et les ordinateurs dans Active Directory.

Voici les étapes principales :

1. **Analyser le fichier Excel pour extraire les données nécessaires.**
2. **Écrire le script PowerShell pour configurer l'Active Directory en fonction des données extraites.**

Je vais d'abord analyser le fichier Excel pour comprendre sa structure et extraire les informations nécessaires.

### Analyse du fichier Excel

Je vais lire le fichier Excel pour voir comment les données sont organisées. Ensuite, je créerai un script PowerShell pour configurer Active Directory.

Le fichier Excel contient une seule feuille nommée "Feuille 1". Nous allons maintenant examiner le contenu de cette feuille pour comprendre la structure des données et extraire les informations nécessaires.

Je vais charger et afficher les premières lignes de cette feuille pour avoir une vue d'ensemble.

La feuille "Feuille 1" du fichier Excel contient les colonnes suivantes :

- Prénom
- Nom
- Société
- Site
- Département
- Service
- Fonction
- Manager - prénom
- Manager - nom
- PC
- Date de naissance
- Téléphone fixe
- Téléphone portable
- Nomadisme - Télétravail

### Plan du Script PowerShell

1. **Créer les Unités d'Organisation (OU)**
    - OU de départements
    - OU de services

2. **Créer les groupes**
    - Groupes de départements
    - Groupes de services
    - Groupes fonctionnels
    - Groupes de sécurité

3. **Créer les utilisateurs et les ordinateurs**
    - Utilisateurs
    - Ordinateurs

Je vais maintenant créer le script PowerShell en fonction des données extraites.

```powershell
# Charger le module Active Directory
Import-Module ActiveDirectory

# Créer les OU de départements et de services
$departements = @{}
$services = @{}

# Importer les données Excel
$data = Import-Csv -Path "C:\path\to\Annexe.csv"

foreach ($row in $data) {
    $departement = $row.Département
    $service = $row.Service

    if ($departement -ne "-" -and -not $departements.ContainsKey($departement)) {
        # Créer l'OU pour le département
        New-ADOrganizationalUnit -Name $departement -Path "OU=Ekolocast,DC=Ekolocast,DC=com"
        $departements[$departement] = $true
    }

    if ($service -ne "-" -and -not $services.ContainsKey($service)) {
        # Créer l'OU pour le service sous le département correspondant
        New-ADOrganizationalUnit -Name $service -Path "OU=$departement,OU=Ekolocast,DC=Ekolocast,DC=com"
        $services[$service] = $true
    }
}

# Créer les groupes
foreach ($row in $data) {
    $departement = $row.Département
    $service = $row.Service
    $fonction = $row.fonction
    $nomComplet = "$($row.Prénom) $($row.Nom)"

    # Créer le groupe de département
    if ($departement -ne "-" -and -not (Get-ADGroup -Filter { Name -eq $departement })) {
        New-ADGroup -Name $departement -GroupScope Global -GroupCategory Security -Path "OU=$departement,OU=Ekolocast,DC=Ekolocast,DC=com"
    }

    # Créer le groupe de service
    if ($service -ne "-" -and -not (Get-ADGroup -Filter { Name -eq $service })) {
        New-ADGroup -Name $service -GroupScope Global -GroupCategory Security -Path "OU=$service,OU=$departement,OU=Ekolocast,DC=Ekolocast,DC=com"
    }

    # Créer le groupe fonctionnel
    if ($fonction -ne "-" -and -not (Get-ADGroup -Filter { Name -eq $fonction })) {
        New-ADGroup -Name $fonction -GroupScope Global -GroupCategory Security -Path "OU=Fonctions,OU=Ekolocast,DC=Ekolocast,DC=com"
    }
}

# Créer les utilisateurs et les ordinateurs
foreach ($row in $data) {
    $samAccountName = "$($row.Prénom.Substring(0,1))$($row.Nom)"
    $ouPath = "OU=$($row.Service),OU=$($row.Département),OU=Ekolocast,DC=Ekolocast,DC=com"
    
    # Créer l'utilisateur
    New-ADUser -Name "$($row.Prénom) $($row.Nom)" -GivenName $row.Prénom -Surname $row.Nom -SamAccountName $samAccountName -UserPrincipalName "$samAccountName@Ekolocast.com" -Path $ouPath -AccountPassword (ConvertTo-SecureString "Password123!" -AsPlainText -Force) -Enabled $true

    # Ajouter l'utilisateur aux groupes correspondants
    Add-ADGroupMember -Identity $row.Département -Members $samAccountName
    Add-ADGroupMember -Identity $row.Service -Members $samAccountName
    Add-ADGroupMember -Identity $row.fonction -Members $samAccountName
    
    # Créer l'ordinateur
    New-ADComputer -Name $row.PC -Path $ouPath -Enabled $true
}
```

Ce script PowerShell fait les opérations suivantes :
1. Crée les OUs pour les départements et les services.
2. Crée les groupes pour les départements, les services, et les fonctions.
3. Crée les utilisateurs et les ordinateurs en les associant aux OUs et aux groupes correspondants.

Pour exécuter ce script :
1. Sauvegardez le fichier Excel en format CSV.
2. Modifiez le chemin du fichier CSV dans le script.
3. Exécutez le script sur un serveur Windows avec le module Active Directory installé et les droits administratifs.
