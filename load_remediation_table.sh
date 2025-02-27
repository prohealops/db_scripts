#!/bin/bash

# Database Credentials
DB_HOST="mysql-2392fef6-ankit10093-528e.k.aivencloud.com"
DB_NAME="defaultdb"
DB_USER="avnadmin"
DB_PASS=""
DB_PORT="19635"
TABLE_NAME="remediation"


# CSV File Path (Passed as an argument)
CSV_FILE="$1"

# Check if the file exists
if [[ ! -f "$CSV_FILE" ]]; then
    echo "Error: CSV file '$CSV_FILE' not found!"
    exit 1
fi

# Read and insert CSV data
while IFS=',' read -r Inspec_Control_ID Remediation_File Remediation_Command; do
    # Skip header line
    if [[ "$Inspec_Control_ID" == "Inspec_Control_ID" ]]; then
        continue
    fi

    # Escape single quotes in values
    Inspec_Control_ID=$(echo "$Inspec_Control_ID" | sed "s/'/''/g")
    Remediation_File=$(echo "$Remediation_File" | sed "s/'/''/g")
    Remediation_Command=$(echo "$Remediation_Command" | sed "s/'/''/g")

    # Insert into database
    SQL_QUERY="INSERT INTO $TABLE_NAME (Inspec_Control_ID, Remediation_File, Remediation_Command) 
               VALUES ('$Inspec_Control_ID', '$Remediation_File', '$Remediation_Command')
               ON DUPLICATE KEY UPDATE 
               Remediation_File='$Remediation_File', 
               Remediation_Command='$Remediation_Command';"

    echo "Processing: [$Inspec_Control_ID] | [$Remediation_File] | [$Remediation_Command]"
    
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "$SQL_QUERY"

    if [[ $? -ne 0 ]]; then
        echo "❌ Error inserting record: $Inspec_Control_ID"
    else
        echo "✅ Inserted: $Inspec_Control_ID | $Remediation_File | $Remediation_Command"
    fi

done < "$CSV_FILE"

echo "CSV Import Completed."

