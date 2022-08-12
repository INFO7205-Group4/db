ALTER TABLE IF EXISTS Users
ADD COLUMN confirmationEmailValidated Boolean  default false;