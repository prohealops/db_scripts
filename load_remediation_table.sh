#!/bin/bash

# Load Database Credentials
source /root/.db_config

# Set Table Name
TABLE_NAME="remediation"

# CSV File Path
CSV_FILE="$1"

# Check if file exists
if [[ ! -f "$CSV_FILE" ]]; then
    echo "Error: CSV file '$CSV_FILE' not found!"
    exit 1
fi

# Read and insert CSV data
while IFS=',' read -r Inspec_Control_ID Remediation_File Remediation_Command; do
    # Skip header
    if [[ "$Inspec_Control_ID" == "Inspec_Control_ID" ]]; then
        continue
    fi

    # Remove Windows carriage returns if present
    Inspec_Control_ID=$(echo "$Inspec_Control_ID" | tr -d '\r' | sed "s/'/''/g")
    Remediation_File=$(echo "$Remediation_File" | tr -d '\r' | sed "s/'/''/g")
    Remediation_Command=$(echo "$Remediation_Command" | tr -d '\r' | sed "s/'/''/g")

    # Debugging: Print Values
    echo "Processing: [$Inspec_Control_ID] | [$Remediation_File] | [$Remediation_Command]"

    # Corrected SQL Query (Ensure "VALUES")
    SQL_QUERY="INSERT INTO $TABLE_NAME (Inspec_Control_ID, Remediation_File, Remediation_Command) 
               VALUES ('$Inspec_Control_ID', '$Remediation_File', '$Remediation_Command')
               ON DUPLICATE KEY UPDATE 
               Remediation_File='$Remediation_File', 
               Remediation_Command='$Remediation_Command';"

    echo "Executing SQL: $SQL_QUERY"

    # Execute MySQL Command
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "$SQL_QUERY"

    if [[ $? -ne 0 ]]; then
        echo "❌ Error inserting record: $Inspec_Control_ID"
    else
        echo "✅ Inserted: $Inspec_Control_ID | $Remediation_File | $Remediation_Command"
    fi

done < <(tail -n +2 "$CSV_FILE")  # Correctly skip header

echo "CSV Import Completed."

