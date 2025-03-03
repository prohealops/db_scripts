#!/bin/bash

# Load Database Credentials from an External Config File
source /root/.db_config

# Table Name
TABLE_NAME="remediation"

# SQL Query to Create Table with Primary Key
SQL_QUERY="CREATE TABLE IF NOT EXISTS $TABLE_NAME (
    Inspec_Control_ID VARCHAR(50) NOT NULL PRIMARY KEY,
    Remediation_File VARCHAR(255) NOT NULL,
    Remediation_Command VARCHAR(255) NOT NULL
);"

# Execute the SQL Query
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$SQL_QUERY"

