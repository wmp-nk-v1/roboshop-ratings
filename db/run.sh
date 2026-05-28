#!/usr/bin/env bash
set -e

: "${MYSQL_HOST:?MYSQL_HOST is required}"
: "${DB_ROOT_PASS:?DB_ROOT_PASS is required}"

echo "Waiting for MySQL at ${MYSQL_HOST}..."
until mysqladmin ping -h "$MYSQL_HOST" -uroot -p"$DB_ROOT_PASS" --silent 2>/dev/null; do
    echo "MySQL not ready, retrying in 2s..."
    sleep 2
done

echo "Running ratings database setup..."
mysql -h "$MYSQL_HOST" -uroot -p"$DB_ROOT_PASS" < /db/schema.sql
mysql -h "$MYSQL_HOST" -uroot -p"$DB_ROOT_PASS" < /db/app-user.sql
echo "Ratings database setup complete"
