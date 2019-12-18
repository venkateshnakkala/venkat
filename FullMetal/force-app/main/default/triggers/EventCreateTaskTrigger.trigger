trigger EventCreateTaskTrigger on Event (after update,after insert) {
    
    if(trigger.isupdate)
    {
        if(!EventCreateTaskUtility.hasAlreadyLaunchedTrigger())
        {
            EventCreateTaskUtility.setAlreadyLaunchedTrigger();
            
            
            Map<id,Event> eventoldmap = trigger.oldmap;
            list<Task> tasklist = new list<task>();
            Map<id,Event> eventnewmap = trigger.newmap;
            Map<id,Task> eventidtaskmap = new Map<id,Task>();
            
            for(Task t :[SELECT id,event_id__c,ActivityDate 
                         FROM Task 
                         WHERE event_id__c IN : eventnewmap.keySet()] )
            {
                eventidtaskmap.put(t.Event_ID__c,t);          
                
            }
            
            
            for(Event evt : trigger.new)
            { 
                Event eventold = eventoldmap.get(evt.Id);
                if(eventidtaskmap.containsKey(evt.Id)){
                    Task t = eventidtaskmap.get(evt.Id);
                    datetime dt = evt.EndDateTime;
                    Date myDate = date.newInstance(dt.year(),dt.month(),dt.day());
                    t.ActivityDate = myDate;
                    tasklist.add(t);                                             
                } else{
                    
                    if(evt.Event_Subject__c != null && evt.createdbyid != '0051a000000ZHO6' )
                    {
                        datetime dt = evt.EndDateTime;
                        Date Mydate = date.newInstance(dt.year(),dt.month(),dt.day());
                        
                        Task t = new Task();
                        t.Event_Subject__c = evt.Event_Subject__c;
                        t.ActivityDate = mydate;
                        t.Priority = 'Normal';
                        t.WhoId = evt.WhoId;
                        t.type = 'Event';
                        t.Event_ID__c = evt.id;
                        t.RecordTypeId = '0121a000000V73C';
                        tasklist.add(t);
                        
                    }                   
                    
                    
                }            
                
            }
//upsert tasklist;           
        }    
        
        if(trigger.isinsert)
        {
            if(!EventCreateTaskUtility.hasAlreadyLaunchedTrigger())
            {
                EventCreateTaskUtility.setAlreadyLaunchedTrigger();
                
                list<Task> tasklist = new list <task>();
                list<event> eventlist = new list <Event>();
                Map<id,Event> eventmapnew = trigger.newmap;
                for(Event evt : trigger.new){
                    if(evt.Event_Subject__c != null && evt.createdbyid != '0051a000000ZHO6')
                    {
                        datetime dt = evt.EndDateTime;
                        Date Mydate = date.newInstance(dt.year(),dt.month(),dt.day());
                        {
                            Task t = new Task();
                            t.Event_Subject__c = evt.Event_Subject__c;
                            t.ActivityDate = mydate;
                            t.Priority = 'Normal';
                            t.WhoId = evt.WhoId;
                            t.type = 'Event';
                            t.Event_ID__c = evt.id;
                            t.RecordTypeId = '0121a000000V73C';
                            tasklist.add(t);
                        }
                    }                   
                } 
//insert tasklist;
            }
        } 
    } 
}