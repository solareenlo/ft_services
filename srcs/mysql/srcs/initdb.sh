#!bin/sh

until mysql
do
	echo "NO_UP"
done

DATABASE_NAME=wordpress
USERNAME=username
PASSWORD=password
DATABASE_HOST=localhost
DB_PHPMYADMIN=phpmyadmin

echo "CREATE USER '$USERNAME'@'$DATABASE_HOST' IDENTIFIED BY '$PASSWORD';" | mysql -u root
echo "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME" | mysql -u root
echo "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$USERNAME'@'$DATABASE_HOST';" | mysql -u root
echo "CREATE DATABASE $DB_PHPMYADMIN;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON $DB_PHPMYADMIN.* TO '$USERNAME'@'$DATABASE_HOST';" | mysql -u root
# mysql $DATABASE_NAME -u root --password= < /tmp/wordpress.sql
