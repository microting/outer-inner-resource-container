#!/bin/bash

CUSTOMERS=('391' '775')

for CUSTOMER in ${CUSTOMERS[@]}; do
  echo "Updating customer with no $CUSTOMER"
  ./upgrade.sh $CUSTOMER
  echo "Done updating customer with no $CUSTOMER, sleeping 60 seconds before proceeding to the next"
  sleep 90
done
