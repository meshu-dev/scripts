#!/bin/bash

source common.sh

check_var "DB_LIST"
check_var "DB_CONFIG_PATH"
check_var "BACKUP_OUTPUT_PATH"
check_var "S3_BUCKET_URL"

backup_databases() {
  DATE=$(date '+%Y-%m-%d')

  for DATABASE in $DB_LIST
  do 
    generate_db_backup DATABASE
  done
}

generate_db_backup() {
  DATABASE="${!1}"
  echo "Backing up $DATABASE database"

  DB_FILE_PATH="$BACKUP_OUTPUT_PATH/$DATE-$DATABASE.sql"

  mysqldump --defaults-file=$DB_CONFIG_PATH $DATABASE > $DB_FILE_PATH
  s3cmd put $DB_FILE_PATH $S3_BUCKET_URL
}

backup_databases

echo "Done!"
