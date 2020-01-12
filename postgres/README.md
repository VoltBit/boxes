The user 1001 does not exist in the system, so no 'su' command will work.
To execut psql commands use the -U flag to specify the postgres configured used:
`psql -U postgres`.
Reference: https://github.com/bitnami/bitnami-docker-postgresql/issues/103


For the migrations to be executed the permissions might need to be 777 and
the old volumes removed.
Reference: https://github.com/docker-library/mariadb/issues/62
