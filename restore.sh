#!/usr/bin/env bash
echo "Doing old backup cleanup"
rm backup-*.sql

HOST="frontend-$1-mariadb-0"

echo "Restoring SDK for customer with no $1"

DATABASE_NAME="$1_SDK"
DOWNLOAD_PATH="microting-sdk-backup/$1/"

LAST_BACKUP=`aws s3 ls $DOWNLOAD_PATH | tail -1 | grep backup | head -1 | awk '{print $4}'`
echo $LAST_BACKUP
aws s3 cp s3://"$DOWNLOAD_PATH"$LAST_BACKUP $LAST_BACKUP
gunzip $LAST_BACKUP


echo "Resotoring to host : $HOST"

kubectl -n customers exec -it $HOST -- mysql -u root -psecretpassword -e "drop database $1_SDK"
kubectl -n customers exec -it $HOST -- mysql -u root -psecretpassword -e "create database $1_SDK"

kubectl -n customers exec -it $HOST -- mysql -u root -psecretpassword $DATABASE_NAME < backup*.sql

rm backup-*.sql

echo "Restoring Angular for customer with no $1"

DATABASE_NAME="$1_Angular"
DOWNLOAD_PATH="microting-angular-backup/$1/"

LAST_BACKUP=`aws s3 ls $DOWNLOAD_PATH | tail -1 | grep backup | head -1 | awk '{print $4}'`
echo $LAST_BACKUP
aws s3 cp s3://"$DOWNLOAD_PATH"$LAST_BACKUP $LAST_BACKUP
gunzip $LAST_BACKUP


echo "Resotoring to host : $HOST"

kubectl -n customers exec -it $HOST -- mysql -u root -psecretpassword -e "drop database $1_Angular"
kubectl -n customers exec -it $HOST -- mysql -u root -psecretpassword -e "create database $1_Angular"

kubectl -n customers exec -it $HOST -- mysql -u root -psecretpassword $DATABASE_NAME < backup*.sql


rm backup-*.sql
echo "Restoring Outer Inner Resource for customer with no $1"

DATABASE_NAME="$1_eform-angular-outer-inner-resource-plugin"
DOWNLOAD_PATH="microting-angular-plugin-backups/$1/eform-angular-outer-inner-resource-plugin/"

LAST_BACKUP=`aws s3 ls $DOWNLOAD_PATH | tail -1 | grep backup | head -1 | awk '{print $4}'`
echo $LAST_BACKUP
aws s3 cp s3://"$DOWNLOAD_PATH"$LAST_BACKUP $LAST_BACKUP
gunzip $LAST_BACKUP

echo "Resotoring to host : $HOST"

kubectl -n customers exec -it $HOST -- mysql -u root -psecretpassword -e 'drop database `'$DATABASE_NAME'`'
kubectl -n customers exec -it $HOST -- mysql -u root -psecretpassword -e 'create database `'$DATABASE_NAME'`'

kubectl -n customers exec -it $HOST -- mysql -u root -psecretpassword $DATABASE_NAME < backup*.sql
rm backup-*.sql
