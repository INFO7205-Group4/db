CREATE or REPLACE VIEW Overview_UserTasks AS 
   SELECT list_table.List_Name, task_table.Task_Name, task_table.DueDate, users_table.Userid from List list_table
   INNER JOIN Users users_table
   ON list_table.UserId=users_table.UserId
   left JOIN Task task_table
   ON list_table.List_Id= task_table.List_Id
   GROUP BY list_table.List_Id, users_table.userId, task_table.Task_Id
   order by users_table.userId;

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
   
