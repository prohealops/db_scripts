#!/bin/bash

# Database connection details

# SQL command to create the table with nullable columns
SQL_COMMAND="CREATE TABLE IF NOT EXISTS pre_scan (
    Primary_Key INT AUTO_INCREMENT PRIMARY KEY,
    Node_ID VARCHAR(255),
    Server_Name VARCHAR(255),
    Inspec_Control_ID VARCHAR(255),
    Inspec_Control_Title VARCHAR(255),
    Inspec_Status VARCHAR(50),
    Incident_Number VARCHAR(255)
);"

# Execute SQL command
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "$SQL_COMMAND"

# Confirm table creation
echo "Table 'pre_scan' created successfully!"

