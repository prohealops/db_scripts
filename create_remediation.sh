#!/bin/bash

# Database Credentials (Pass password as an argument instead of hardcoding)


# Table Name
TABLE_NAME="remediation"

# SQL Query to Create Table
SQL_QUERY="CREATE TABLE IF NOT EXISTS $TABLE_NAME (
    Inspec_Control_ID VARCHAR(50) NOT NULL,
    Remediation_File VARCHAR(255) NOT NULL,
    Remediation_Command VARCHAR(255) NOT NULL
);"

# Execute the SQL Query
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$SQL_QUERY"

if [ $? -eq 0 ]; then
    echo "Table '$TABLE_NAME' created successfully in database '$DB_NAME'."
else
    echo "Error: Failed to create table '$TABLE_NAME'."
fi

