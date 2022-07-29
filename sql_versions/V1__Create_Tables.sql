/*
Object: Table for Users
Script Date: July 25, 2022
Description: This table stores a list of users 
when they register in the todo app with the following Attributes:

UserId - Pseudo-type is an auto-incremented integer with a storage size of 
four bytes and a range of one to 2,147,483,647.

FName,MName,LName -  Varchar datatype is used with limit 20 for each and
FName, LName are mandatory fields hence NOT NULL used

EmailAddress - Cannot be NULL and varchar datatype is used with 
limit 50 and check constraint added with regex to check for email address format

UserPassword - Cannot be NULL and varchar datatype is used 
Has to be hashed from Application layer

EmailValidated - Boolean datatype denoting if the email is validated or not, default value is false

Create_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Only created when a new user is created

Updated_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Updated everytime when there is
a change in the records
*/ 

CREATE TABLE IF NOT EXISTS Users(
   UserId SERIAL PRIMARY KEY,
   FName           varchar(20)    NOT NULL,
   MName           varchar(20)    ,
   LName           varchar(20)    NOT NULL,
   EmailAddress    varchar(50)    NOT NULL UNIQUE  CHECK (EmailAddress ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
   UserPassword    varchar     NOT NULL  ,
   EmailValidated  Boolean     default false,
   EmailSentTime   TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL
);

/*
Object: Table to Store Lists created by user
Default empty list is created when a user registers in the todo app
Script Date: July 25, 2022
Description: This table stores list details with the following Attributes:

ListId - Pseudo-type is an auto-incremented integer with a storage size of 
four bytes and a range of one to 2,147,483,647.

List_Name -  Varchar datatype is used with limit 20

Create_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Only created when a new user is created

Updated_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Updated everytime when there is
a change in the records

UserID - foreign key
*/ 
CREATE TABLE IF NOT EXISTS List(
   List_Id SERIAL PRIMARY KEY,
   List_Name     varchar(20),
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL,
   UserId INT NOT NULL,
   CONSTRAINT fk_user
      FOREIGN KEY(userid) 
	  REFERENCES users(userid)  ON DELETE CASCADE ON UPDATE CASCADE
);


/*
Object: Table for task
Script Date: July 25, 2022
Description: This table stores task details with the following Attributes:

Task_Id - Pseudo-type is an auto-incremented integer with a storage size of 
four bytes and a range of one to 2,147,483,647.

Task Summary -  Varchar datatype is used with limit 50 
Task_Name - Cannot be NULL and varchar datatype is used with 
limit 20

DueDate - Can be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used

Task_Priority - SMALLINT datatype is used with default value as 0 denoting low priority

Create_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Only created when a new user is created

Updated_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Updated everytime when there is
a change in the records

Task_State - Denotes the state of the task whether TODO, COMPLETE, OVERDUE(0,1,2)

List_Id - Foreign key
*/ 
CREATE TABLE IF NOT EXISTS Task(
   Task_Id SERIAL PRIMARY KEY,
   Task_Summary varchar(50),
   Task_Name varchar(20) NOT NULL ,
   DueDate  TIMESTAMP WITH TIME ZONE,
   Task_Priority SMALLINT default 0 check (Task_Priority in (0,1,2)),
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL,
   List_Id INT NOT NULL,
   CONSTRAINT fk_list
      FOREIGN KEY(List_Id) 
	  REFERENCES List(List_Id) ON DELETE CASCADE ON UPDATE CASCADE,
   Task_State INT default 0 check (Task_State in (0, 1,2))
);

/*
Object: Table for Attachments
Script Date: July 25, 2022
Description: This table stores task attachments with the following Attributes:

Attachment_Id - Pseudo-type is an auto-incremented integer with a storage size of 
four bytes and a range of one to 2,147,483,647.
 
Attachment_Name - Cannot be NULL and varchar datatype is used with 
limit 20

Attached_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used

Attachment_Size - Cannot be NULL and SmallInt datatype is used to check for file size, Max limit 10000kilobytes

Attachment_File - Cannot be NULL and bytea datatype is used

Task_Id - Foreignkey
*/ 
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

/*
Object: Table for tag
Script Date: July 25, 2022
Description: This table stores tags created by user with the following Attributes:

Tag_Id - Pseudo-type is an auto-incremented integer with a storage size of 
four bytes and a range of one to 2,147,483,647.
 
Tag_Name - Cannot be NULL and varchar datatype is used with 
limit 20

Create_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Only created when a new user is created

Updated_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Updated everytime when there is
a change in the records

User_Id - Foreignkey
*/ 
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

/*
Object: Table to link task and tag
Script Date: July 25, 2022
Description: This table links task id with tag id
(Max limit 10 per task)
*/ 
CREATE TABLE  IF NOT EXISTS task_tag (
  Task_Id int NOT NULL REFERENCES Task (Task_Id) ON UPDATE CASCADE ON DELETE CASCADE
, Tag_Id int NOT NULL REFERENCES Tag (Tag_Id) ON UPDATE CASCADE ON DELETE CASCADE
, CONSTRAINT task_tag_pkey PRIMARY KEY (Task_Id, Tag_Id)
);

/*
Object: Table for task Comments
Script Date: July 25, 2022
Description: This table stores task comments with the following Attributes:

Comment_Id - Pseudo-type is an auto-incremented integer with a storage size of 
four bytes and a range of one to 2,147,483,647.
 
Comment - Cannot be NULL and varchar datatype is used with 
limit 150

Create_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Only created when a new user is created

Updated_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Updated everytime when there is
a change in the records

Task_Id - Foreignkey
*/ 
CREATE TABLE IF NOT EXISTS Comment(
   Comment_Id SERIAL PRIMARY KEY,
   Comment varchar(150)  NOT NULL,
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Task_Id INT NOT NULL,
   CONSTRAINT fk_comment
      FOREIGN KEY(Task_Id) 
	  REFERENCES Task(Task_Id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
Object: Table for task reminders
Script Date: July 25, 2022
Description: This table stores task reminders with the following Attributes:

Reminder_Id - Pseudo-type is an auto-incremented integer with a storage size of 
four bytes and a range of one to 2,147,483,647.
 
Reminder_DateTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
to support users from multiple timezones

Create_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Only created when a new user is created

Updated_AtTime - Cannot be NULL and TIMESTAMP WITH TIME ZONE(TIMESTAMPTZ) datatype is used
Stores Current timestamp value of DB server if there's null value. Updated everytime when there is
a change in the records

Task_Id - Foreignkey
*/ 
CREATE TABLE IF NOT EXISTS Reminder(
   Reminder_Id SERIAL PRIMARY KEY,
   Reminder_DateTime  TIMESTAMP WITH TIME ZONE  NOT NULL,
   Created_AtTime  TIMESTAMP WITH TIME ZONE    DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Updated_AtTime   TIMESTAMP WITH TIME ZONE   DEFAULT CURRENT_TIMESTAMP NOT NULL,
   Task_Id INT NOT NULL,
   CONSTRAINT fk_reminder
      FOREIGN KEY(Task_Id) 
	  REFERENCES Task(Task_Id) ON DELETE CASCADE ON UPDATE CASCADE
);
