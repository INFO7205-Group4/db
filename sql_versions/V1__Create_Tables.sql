CREATE TABLE IF NOT EXISTS Users(
   UserId SERIAL PRIMARY KEY,
   FName           TEXT    NOT NULL,
   MName           TEXT    ,
   LName           TEXT    NOT NULL,
   EmailAddress    TEXT    NOT NULL UNIQUE  CHECK (EmailAddress ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
   UserPassword        char(60)     NOT NULL  ,
   EmailValidated  Boolean     default false,
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE IF NOT EXISTS List(
   List_Id SERIAL PRIMARY KEY,
   List_Name     TEXT    NOT NULL,
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL,
   UserId INT NOT NULL,
   CONSTRAINT fk_user
      FOREIGN KEY(userid) 
	  REFERENCES users(userid)  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS Task(
   Task_Id SERIAL PRIMARY KEY,
   Task_Summary varchar(50)    NOT NULL,
   Task_Name varchar(20)    NOT NULL,
   DueDate  TIMESTAMP WITH TIME ZONE  NOT NULL  CHECK (DueDate > CURRENT_TIMESTAMP ),
   Task_Priority INT default 0 check (Task_Priority in (0, 1,2)),
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL,
   List_Id INT NOT NULL,
   CONSTRAINT fk_list
      FOREIGN KEY(List_Id) 
	  REFERENCES List(List_Id) ON DELETE CASCADE ON UPDATE CASCADE,
   Task_State INT default 0 check (Task_State in (0, 1,2))
);

CREATE TABLE IF NOT EXISTS Attachment(
   Attachment_Id SERIAL PRIMARY KEY,
   Attachment_Name varchar(20)    NOT NULL,
   Attached_AtTime  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Attachment_Size SMALLINT NOT NULL check (Attachment_Size > 0 AND Attachment_Size <= 10000),
   Attachment_File bytea NOT NULL ,
   Task_Id INT NOT NULL,
      FOREIGN KEY(Task_Id) 
	  REFERENCES Task(Task_Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Tag(
   Tag_Id SERIAL PRIMARY KEY,
   Tag_Name varchar(20)    NOT NULL,
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL,
   UserId INT NOT NULL,
   CONSTRAINT fk_tag
      FOREIGN KEY(UserId) 
	  REFERENCES Users(UserId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE  IF NOT EXISTS task_tag (
  Task_Id int NOT NULL REFERENCES Task (Task_Id) ON UPDATE CASCADE ON DELETE CASCADE
, Tag_Id int NOT NULL REFERENCES Tag (Tag_Id) ON UPDATE CASCADE ON DELETE CASCADE
, CONSTRAINT task_tag_pkey PRIMARY KEY (Task_Id, Tag_Id)
);

CREATE TABLE IF NOT EXISTS Comment(
   Comment_Id SERIAL PRIMARY KEY,
   Comment text    NOT NULL,
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Task_Id INT NOT NULL,
   CONSTRAINT fk_comment
      FOREIGN KEY(Task_Id) 
	  REFERENCES Task(Task_Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Reminder(
   Reminder_Id SERIAL PRIMARY KEY,
   Reminder_DateTime  TIMESTAMP WITH TIME ZONE  NOT NULL CHECK (Reminder_DateTime > CURRENT_TIMESTAMP ),
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Task_Id INT NOT NULL,
   CONSTRAINT fk_reminder
      FOREIGN KEY(Task_Id) 
	  REFERENCES Task(Task_Id) ON DELETE CASCADE ON UPDATE CASCADE
);
