#!/bin/bash

CURRENT_DIR="$(dirname "${BASH_SOURCE[0]}")"
source $CURRENT_DIR/common.sh

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

  FILENAME="$DATE-$DATABASE.sql"
  DB_FILE_PATH="$BACKUP_OUTPUT_PATH/$FILENAME"

  mysqldump --defaults-file=$DB_CONFIG_PATH $DATABASE > $DB_FILE_PATH
  s3cmd put $DB_FILE_PATH "$S3_BUCKET_URL/$FILENAME"
}

backup_databases

echo "Done!"
