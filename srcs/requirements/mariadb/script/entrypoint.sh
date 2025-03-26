#!/bin/bash
set -e

# Créer les répertoires nécessaires et régler les permissions
mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Si la base n'a pas encore été initialisée, la créer
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialisation de la base de données..."
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

# Démarrer temporairement MariaDB en arrière-plan avec mysqld_safe
echo "Démarrage temporaire de MariaDB en arrière-plan..."
mysqld_safe --skip-networking=0 &

# Attendre que le socket soit créé (timeout de 30 secondes)
COUNTER=0
while [ ! -S /run/mysqld/mysqld.sock ]; do
    sleep 1
    COUNTER=$((COUNTER+1))
    if [ $COUNTER -gt 30 ]; then
        echo "Le serveur MariaDB ne démarre pas dans les 30 secondes."
        exit 1
    fi
done

echo "Le socket est disponible, lancement de l'initialisation..."

# Exécuter les commandes SQL pour créer la base et l'utilisateur
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

# (Optionnel) Modifier le mot de passe root si MYSQL_ROOT_PASSWORD est défini
if [ -n "$MYSQL_ROOT_PASSWORD" ]; then
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"
fi

echo "Arrêt du serveur temporaire..."
mysqladmin -u root shutdown

echo "Relance de MariaDB en mode foreground..."
exec mysqld --bind-address=0.0.0.0
