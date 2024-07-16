Fichier de configuration (config.ini)
# config.ini
DB_NAME=glpi
DB_USER=glpi_user
DB_PASSWORD=securepassword
DB_HOST=localhost
GLPI_VERSION=10.0.3
WEB_ROOT=/var/www/html


Script Bash (install_glpi.sh)
#!/bin/bash

# Chargement du fichier de configuration
CONFIG_FILE="config.ini"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Le fichier de configuration $CONFIG_FILE est introuvable."
    exit 1
fi

# Lire le fichier de configuration
source "$CONFIG_FILE"

# Mettre à jour le système et installer les dépendances
echo "Mise à jour du système et installation des dépendances..."
sudo apt-get update
sudo apt-get install -y apache2 mariadb-server php php-mysql php-xml php-curl php-gd php-mbstring php-zip wget unzip

# Télécharger et extraire GLPI
echo "Téléchargement de GLPI version $GLPI_VERSION..."
wget "https://github.com/glpi-project/glpi/releases/download/$GLPI_VERSION/glpi-$GLPI_VERSION.tgz"
tar -xzf "glpi-$GLPI_VERSION.tgz"

# Déplacer GLPI dans le répertoire web
echo "Déplacement de GLPI vers $WEB_ROOT/glpi..."
sudo mv "glpi" "$WEB_ROOT/glpi"
sudo chown -R www-data:www-data "$WEB_ROOT/glpi"

# Configurer la base de données
echo "Configuration de la base de données..."
sudo mysql -e "CREATE DATABASE $DB_NAME;"
sudo mysql -e "CREATE USER '$DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'$DB_HOST';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Configuration d'Apache
echo "Configuration d'Apache..."
APACHE_CONFIG="
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot $WEB_ROOT/glpi

    <Directory $WEB_ROOT/glpi>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
"

echo "$APACHE_CONFIG" | sudo tee /etc/apache2/sites-available/glpi.conf

# Activer le site et les modules Apache nécessaires
sudo a2ensite glpi
sudo a2enmod rewrite

# Redémarrer Apache pour appliquer les changements
echo "Redémarrage d'Apache..."
sudo systemctl restart apache2

echo "Installation de GLPI terminée. Accédez à http://localhost/glpi pour terminer l'installation via l'interface web."


Utilisation
Créez un fichier config.ini avec les paramètres souhaités.
Exécutez le script Bash avec les permissions nécessaires :

sudo chmod +x install_glpi.sh
sudo ./install_glpi.sh

ATTENTION : Le fichier config.ini doit être enregistré dans le même répertoire que le script install_glpi.sh. Le script est conçu pour lire ce fichier de configuration dans son répertoire de travail actuel.
