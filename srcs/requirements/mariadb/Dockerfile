FROM debian:bookworm

# Mettre à jour les packages et installer MariaDB (serveur) 
RUN apt-get update -y && apt-get upgrade -y \
 && apt-get install -y mariadb-server


RUN mkdir -p /var/lib/mysql/sys /var/lib/mysql/performance_schema

# Copier le script d'initialisation de la base de données dans l'image
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh

# Donner les permissions d'exécution au script
RUN chmod +x /usr/local/bin/entrypoint.sh

# Lancer le script d'initialisation lors du démarrage du conteneur
# et s'assurer que le processus MariaDB reste au premier plan (PID 1)
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
