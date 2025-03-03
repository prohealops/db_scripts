#!/bin/bash

# Database connection details
source /root/.db_config
# Get the list of tables
TABLES=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -se "SHOW TABLES;")

# Check if tables exist
if [ -z "$TABLES" ]; then
    echo "No tables found in database: $DB_NAME"
    exit 1
fi

# Display the list of tables
echo "Tables in database '$DB_NAME':"
echo "$TABLES"

# Loop through each table and display its contents
for TABLE in $TABLES; do
    echo "Contents of table: $TABLE"
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "SELECT * FROM $TABLE;"
    echo "------------------------------------------------------------"
done



# Display the list of tables and their schema
echo "Tables and their Schema in database '$DB_NAME':"
echo "------------------------------------------------------------"

for TABLE in $TABLES; do
    echo "Schema for table: $TABLE"
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "DESC $TABLE;"
    echo "------------------------------------------------------------"
done
