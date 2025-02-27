i# Database Credentials
DB_HOST="sql12.freesqldatabase.com"
DB_USER="sql12760516"
DB_PASS=""
DB_NAME="sql12760516"
TABLE_NAME="pre_scan"
NEW_COLUMN="Inspec_Control_Title"

# MySQL command to add the column
SQL_COMMAND="ALTER TABLE $TABLE_NAME ADD COLUMN $NEW_COLUMN VARCHAR(255) NULL;"

# Execute the SQL command
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$SQL_COMMAND"

echo "Column '$NEW_COLUMN' added successfully to table '$TABLE_NAME'."
