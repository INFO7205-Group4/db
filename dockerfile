#Database container 
FROM postgres:14.4-alpine as postgres_database
ENV POSTGRES_PASSWORD=""
ENV POSTGRES_USER=""
ENv POSTGRES_DB=""

#Get image "flyway" from Flyway's repository
FROM flyway/flyway:latest-alpine as flyway

#Copy the migration script fom local to container
COPY ./sql_versions /flyway/migrations/
ENTRYPOINT exec flyway migrate -url="$FLYWAY_URL" -defaultSchema=${FLYWAY_SCHEMAS} -user="$FLYWAY_USER" -password="$FLYWAY_PASSWORD" -locations="filesystem:/flyway/migrations" -connectRetries=60 -outputType=json




