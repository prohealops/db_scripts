#!/bin/bash

# Database connection details

# Connect to the MySQL database
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" <<EOF
USE $DB_NAME;
SHOW TABLES;
EOF

echo "Connected to the database successfully!"

