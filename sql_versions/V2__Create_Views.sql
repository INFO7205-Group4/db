/*
Object: View
Script Date: July 26, 2022
Description: This view gives an overview of lists and the corresponding tasks for each user.

To fetch lists of a particular user, we have done an inner join on Users table, and list_table on UserId.
User_Id is present as a foreign key in list_table.

To fetch tasks of a particular List, we have done a left join on list table, and task table on List_Id
List_Id is present as foreign key in task table.

Thereafter, we have grouped my list_Id, user_Id, and task_Id to group all the lists that has been created by the users.

*/


CREATE or REPLACE VIEW Overview_UserTasks AS 
   SELECT list_table.List_Name, task_table.Task_Name, task_table.DueDate, users_table.Userid from List list_table
   INNER JOIN Users users_table
   ON list_table.UserId=users_table.UserId
   left JOIN Task task_table
   ON list_table.List_Id= task_table.List_Id
   GROUP BY list_table.List_Id, users_table.userId, task_table.Task_Id
   order by users_table.userId;


/*
Object: View
Script Date: July 26, 2022
Description: 

This view gives a detailed overview a user's lists, tasks, attachments, and 
comments, of the users. This gives a detailed picture a user's details.

To fetch lists of a particular user, we have done an inner join on UserId from Users table, and list_table
which is present as a foreign key in list_table.

To obtain tasks of a particular list, we have done a left join on List_Id from both task table, and list_table
that is present as a foreign key in task table.

To obtain the attachments of a particular task, we have done a left join on task, and attachment table using Task_Id 
that is present as a foreign key on attachment table. 

To obtain the tags for a particular task, and the corresponding tasks for a tag, we have done a full join on 
task table and tag table on TaskId since it has many-to many relation

To obtain comments for a particular task, we have done a left join on task table and comment table on Task_Id.
Task_Id is a foreign key in comment table.

To obtain the reminders of a particular task, we have done a left join on task table, and reminder table
on Task_id which is a foreign key in reminder table.

In order to show all these details for each user we have grouped by list_id, userId, Task_Id,
Attachment_Id, Tag_Id, Task_Id, Tag_Name.

*/

CREATE or REPLACE VIEW DetailedOverview_User AS 
   SELECT list_table.List_Name, 
   task_table.Task_Name, task_table.DueDate,task_table.Task_Summary,task_table.Task_Priority, task_table.Task_State,
   attachment_table.Attachment_Name,attachment_table.Attached_AtTime,attachment_table.Attachment_Size,attachment_table.Attachment_File
   ,users_table.UserId, tag_table.Tag_Name , 
   comment_table.Comment,reminder_table.Reminder_DateTime  from List list_table
   INNER JOIN Users users_table
   ON list_table.UserId=users_table.UserId
   left JOIN Task task_table
   ON list_table.List_Id= task_table.List_Id
   left JOIN Attachment attachment_table
   ON task_table.Task_Id = attachment_table.Task_Id
   left JOIN task_tag task_tag_table
   ON task_table.Task_Id = task_tag_table.Task_Id
   full JOIN Tag tag_table
   ON tag_table.Tag_id = task_tag_table.Tag_Id
   left join Comment comment_table 
   ON task_table.Task_Id = comment_table.Task_Id 
   left join Reminder reminder_table
   ON task_table.Task_Id = reminder_table.Task_Id
   GROUP BY list_table.List_Id, users_table.userId, task_table.Task_Id, attachment_table.Attachment_Id, task_tag_table.Tag_Id,task_tag_table.Task_Id,tag_table.Tag_Name,
   comment_table.Comment,reminder_table.Reminder_DateTime
   order by users_table.userId;
   
