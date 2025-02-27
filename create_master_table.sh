#!/bin/bash

# Database connection details


# SQL statement to create the table (allow NULL values)
SQL_QUERY="CREATE TABLE IF NOT EXISTS master (
    Primary_Key VARCHAR(50) NOT NULL PRIMARY KEY,
    Node_ID VARCHAR(50),
    Incident_Number VARCHAR(50),
    Inspec_Control_ID VARCHAR(50),
    Inspec_Control_Title VARCHAR(255),
    Incident_Status VARCHAR(50),
    Remediation_Status VARCHAR(50),
    Failure_Reason TEXT
);"

# Execute SQL query
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "$SQL_QUERY"

# Output result
if [ $? -eq 0 ]; then
    echo "Table 'master_table' created successfully."
else
    echo "Error creating table."
fi

