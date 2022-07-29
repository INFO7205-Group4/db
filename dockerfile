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
ENTRYPOINT exec flyway migrate -url="${FLYWAY_URL}" -defaultSchema=${FLYWAY_SCHEMAS} -user="${FLYWAY_USERNAME}" -password="${FLYWAY_PASSWORD}" -locations="filesystem:/flyway/migrations" -connectRetries=60 -outputType=json



