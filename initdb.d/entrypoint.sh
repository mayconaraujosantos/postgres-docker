#!/bin/bash


set -o errexit


readonly REQUIRED_ENV_VARS=(
  "DATABASE_USER"
  "DATABASE_PASSWORD"
  "DATABASE_NAME"
  "POSTGRES_USER"
)


# Main execution:

main() {
  check_env_vars_set
  init_user_and_db
}


# Checks if all of the required environment

check_env_vars_set() {
  for required_env_var in ${REQUIRED_ENV_VARS[@]}; do
    if [[ -z "${!required_env_var}" ]]; then
      echo "Error:
    Environment variable '$required_env_var' not set.
    Make sure you have the following environment variables set:
      ${REQUIRED_ENV_VARS[@]}
Aborting."
      exit 1
    fi
  done
}


# using the preconfigured POSTGRE_USER user.
init_user_and_db() {
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
     CREATE USER $DATABASE_USER WITH PASSWORD '$DATABASE_PASSWORD';
     CREATE DATABASE $DATABASE_NAME;
     GRANT ALL PRIVILEGES ON DATABASE $DATABASE_NAME TO $DATABASE_USER;
EOSQL
}

main "$@"