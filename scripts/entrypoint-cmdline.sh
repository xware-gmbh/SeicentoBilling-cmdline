#!/bin/bash

# Copyright (c) 2020. XWare GmbH - Josef Muti
# SeicenotBilling command line tools.

# init_databases. creates seicenot database, and loads demo data if JRS_LOAD_SAMPLES = true
# Default "init"

# Sets script to fail if any command fails.
set -e

initialize_deploy_properties() {
  # If environment is not set, uses default values for postgres
  DB_TYPE=${DB_TYPE:-postgresql}
  DB_USER=${DB_USER:-postgres}
  DB_PASSWORD=${DB_PASSWORD:-postgres}
  DB_HOST=${DB_HOST:-localhost}
  DB_NAME=${DB_NAME:-seicentopg}
  DB_PORT=${DB_PORT:-5432}   
}

# tests for existing seicento Database and creates it if necessary
init_databases() {	
  echo 'seicentobilling-cmdline check DB' ${DB_TYPE} 'on host' ${DB_HOST} ${DB_PORT}
  java -cp "/usr/src/seicentobilling-cmdline/seicentobilling-cmdline.jar" ch.xwr.seicento.billing.cmdline.Main    
}

# START-POINT of scipt 
initialize_deploy_properties
init_databases

