ALTER USER 'root'@'localhost' IDENTIFIED BY 'rootpassword';

CREATE USER 'bde-wits'@'%' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON *.* TO 'bde-wits'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;
