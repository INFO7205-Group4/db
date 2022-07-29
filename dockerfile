# Get image "flyway" from Flyway's repository
FROM flyway/flyway:latest-alpine

#Environment variables to be sent to bash migration script

ENV Hostname=""
ENV Port=""
ENV DBName=""
ENV FLYWAY_USERNAME=""
ENV FLYWAY_PASSWORD=""
ENV FLYWAY_SCHEMAS=""

#Copy the migration script fom local to container
COPY ./sql_versions /flyway/migrations/
ENTRYPOINT exec flyway migrate -url="jdbc:postgresql://${Hostname}:${Port}/${DBName}" -defaultSchema=${FLYWAY_SCHEMAS} -user="${FLYWAY_USERNAME}" -password="${FLYWAY_PASSWORD}" -locations="filesystem:/flyway/migrations" -connectRetries=60 -outputType=json
