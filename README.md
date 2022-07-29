# db
This repo will contain all your database migration-related code.

## Docker Commands to be used with the project
1) docker build -t group --build-arg Hostname=34.75.77.255 --build-arg Port=5432 --build-arg DBName=test --build-arg Username=postgres --build-arg Password=Info7205 --build-arg Schema=todo  .
 
2) docker tag a12cea7c75d2  info7205group4/db:db_migration
 
3) docker push info7205group4/db:db_migration
 ## Through Docker compose 

docker-compose -f docker-compose up 
\l
\c todo
\dn
\dt todo.*
