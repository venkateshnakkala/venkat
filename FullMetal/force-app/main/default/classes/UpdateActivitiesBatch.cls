global class UpdateActivitiesBatch implements Database.Batchable<sObject>,Schedulable
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String duedate = String.valueOf(system.today());
        String query = 'SELECT ActivityDate,Subject,WhoId,WhatId,Status FROM Task Where Subject=\'New Student Orientation\' AND Status=\'Pending\' AND ActivityDate='+duedate;
        system.debug(query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Task> scope)
    {
        system.debug('Scope '+Scope);
        Map<string,Task> TaskwithApplication=new Map<string,Task>();
        try{
            for(Task a : scope)
            { 
                string whtid=a.WhoId;
                boolean isApplication=whtid.startsWith('003');
                IF(whtid!=null && isApplication){
                    TaskwithApplication.put(whtid,a);
                }
            }
            List<Contact> App=new List<Contact>();
            Map<String,Contact> ApplicationWithTask=new Map<String,Contact>();
            List<Task> tk=new List<Task>();
            List<Task> UpdateTask=new List<Task>();
            
            if(TaskwithApplication.size()>0){
                App=[Select id,Name,School_Status__c,Contact_Owner_Email__c From Contact Where id IN:TaskwithApplication.keyset()];
                for(Contact av:App){
                    if(av.School_Status__c=='Enrolled' || av.School_Status__c=='Enrolled - Trial Period'){
                        tk.add(TaskwithApplication.get(av.id));
                        ApplicationWithTask.put(av.id,av);
                    }
                    
                }
                
                
            }
            if(tk.size()>0){
                for(Task a:tk){
                    a.Status = 'No Show';
                    UpdateTask.add(a);
                }
            }
            if(UpdateTask.size()>0) {
                update UpdateTask;
            }
        }catch(exception ex){
            system.debug('Exception '+ex);
        }
        
    } 
    global void execute(SchedulableContext sc)
    {
        UpdateActivitiesBatch b = new UpdateActivitiesBatch ();
        database.executebatch(b,9);
    }
    global void finish(Database.BatchableContext BC){}
}