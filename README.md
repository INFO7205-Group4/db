# db
This repo will contain all your database migration-related code.

## Docker Commands to be used with the project
1) docker build  -t <tagname>.
 
2) docker tag <imageId> info7205group4/db:<tagname>
 
3) docker push info7205group4/db:<tagname>
4) docker container run -e Hostname="<Hostname>" -e Port="<Port>" -e DBName="<Db>" -e FLYWA
Y_PASSWORD="<Password>" -e FLYWAY_USERNAME="<Username>" -e FLYWAY_SCHEMAS="<Schema>"  <Imageid>
 ## Through Docker compose 

docker-compose -f docker-compose up 
\l
\c todo
\dn
\dt todo.*
