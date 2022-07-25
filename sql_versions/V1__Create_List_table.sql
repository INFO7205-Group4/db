CREATE TABLE Users(
   UserId SERIAL PRIMARY KEY,
   FName           TEXT    NOT NULL,
   MName           TEXT    ,
   LName           TEXT    NOT NULL,
   EmailAddress    TEXT    NOT NULL UNIQUE,
   Password        char(60)     NOT NULL,
   EmailValidated  Boolean     default false,
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL
);
