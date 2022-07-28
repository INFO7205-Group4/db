# Get image "flyway" from Flyway's repository
FROM flyway/flyway:9.0.0

# Argument to be passed from docker build command 
ARG Hostname
ARG Port
ARG DBName
ARG Username
ARG Password
ARG Schema

#Environment variables to be sent to bash migration script
ENV FLYWAY_URL="jdbc:postgresql://$Hostname:$Port/$DBName"
ENV FLYWAY_USERNAME="$Username"
ENV FLYWAY_PASSWORD="$Password"
ENV FLYWAY_SCHEMAS="$Schema"

#Copy the migration script fom local to container
COPY ./sql_versions /flyway/migrations/

#Copy the Bash script fom local to container
COPY RunMigration.sh /flyway/RunMigration.sh

ENTRYPOINT ["/flyway/RunMigration.sh"]

