#!/bin/zsh

printf "Destroying services..."
docker compose down >> /dev/null 2>&1
echo "OK"

printf "Purging services..."
rm -rf ./tmp/services >> /dev/null 2>&1
echo "OK"

printf "Creating services..."
docker compose up --detach --wait >> /dev/null 2>&1
echo "OK"

printf "Configuring postgres database..."
until pg_isready -q; do
  sleep 1
done
createuser --superuser $USER
echo "OK"

printf "Configuring mysql database..."
until mysqladmin ping >> /dev/null 2>&1; do
  sleep 1
done
mysql <<SQL >> /dev/null 2>&1
CREATE USER 'rails'@'%';
GRANT ALL PRIVILEGES ON activerecord_unittest.* to 'rails'@'%';
GRANT ALL PRIVILEGES ON activerecord_unittest2.* to 'rails'@'%';
GRANT ALL PRIVILEGES ON inexistent_activerecord_unittest.* to 'rails'@'%';
SQL
echo "OK"
