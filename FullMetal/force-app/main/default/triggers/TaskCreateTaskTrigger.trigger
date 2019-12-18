trigger TaskCreateTaskTrigger on Task (after Update) {
    {
        if(trigger.isupdate)
        {
            Map<id,Task> taskoldmap = trigger.oldmap;
            list<Task> tasklist = new list<Task>();
            
            for(Task t : trigger.new) 
            {
                Task told = taskoldmap.get(t.id);
                if(t.Event_Results__c != told.Event_Results__c)
                {
                    if(t.Event_Results__c == 'No Show')
                    {
                        date duedate = system.today();
                        date newdate = duedate.addDays(1);
                        
                            Task t2 = new Task ();
                            t2.Subject = 'No Show Call Back';
                            t2.ActivityDate = newdate;
                            t2.Activity_Subject__c = 'No Show Call Back';
                            t2.WhoId = t.whoid;
                            t2.RecordTypeId = '0121a000000V73C';
                            tasklist.add(t2);                                                                                                                                 
                    }
                }
            }
            insert tasklist;
        }
    }
}