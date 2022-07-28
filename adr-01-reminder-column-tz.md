#Number: ADR-01 

##Date: 
  07/26/2022 

##Title: 
  Storing reminders set by users from different time zones 

##Context (Why): 
  When a user creates a reminder for a task from a different time zone than that of the Application/DB server, it must be stored appropriately in the database regardless of the time zone to ensure data reliability. 

##Decision (What/How):
  To handle this scenario, we have collectively decided to have a single time zone and store reminder dates and times with respect to the standard time zone. This will be automatically handled using DB timestamp with zone/timestamptz datatype for the reminder column. 

##Status: 
  Approved 

##Consequences: 
  This decision will prove effective in storing reminder data regardless of user and DB server time zones. 
