#!/bin/bash

# Variables
DB_NAME="glpi"
DB_USER="glpiuser"
DB_PASS="yourpassword"
GLPI_VERSION="9.5.4"
WEB_ROOT="/var/www/html"

# Mise à jour du système
sudo apt update && sudo apt upgrade -y

# Installation des dépendances
sudo apt install -y apache2 mariadb-server mariadb-client php php-mysql php-xml php-curl php-gd php-imap php-ldap php-apcu php-intl php-zip wget unzip

# Démarrage et activation des services Apache et MariaDB
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Configuration de la base de données MariaDB
sudo mysql -u root -e "CREATE DATABASE $DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -u root -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

# Téléchargement et installation de GLPI
cd /tmp
wget https://github.com/glpi-project/glpi/releases/download/$GLPI_VERSION/glpi-$GLPI_VERSION.tgz
tar -xzf glpi-$GLPI_VERSION.tgz
sudo mv glpi $WEB_ROOT/

# Permissions
sudo chown -R www-data:www-data $WEB_ROOT/glpi
sudo chmod -R 755 $WEB_ROOT/glpi

# Configuration d'Apache pour GLPI
sudo bash -c 'cat > /etc/apache2/sites-available/glpi.conf << EOF
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/glpi

    <Directory /var/www/html/glpi>
        Options FollowSymlinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/glpi_error.log
    CustomLog \${APACHE_LOG_DIR}/glpi_access.log combined
</VirtualHost>
EOF'

# Activation du site GLPI et des modules nécessaires
sudo a2ensite glpi
sudo a2enmod rewrite
sudo systemctl restart apache2

# Nettoyage
rm -rf /tmp/glpi-$GLPI_VERSION.tgz

# Message de fin
echo "Installation de GLPI terminée. Accédez à l'interface web pour finaliser la configuration : http://<votre-serveur>/glpi"
