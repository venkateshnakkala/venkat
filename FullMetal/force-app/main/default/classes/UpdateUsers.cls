global class UpdateUsers implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful { 

    private Map<Id,String> UserData{get;set;}
    
    public UpdateUsers(Map<Id,String> users){
        UserData=users;
    }

    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([select id, contactid, email, username from user where contactid =:UserData.keySet()]);
    }

    public void execute(Database.BatchableContext BC, List<User> Users)
    {
        Boolean updatable=false;
        
        for(User s: Users)
        {
            if(!UserData.get(s.contactid).contains('@lafilm.'))
            {
                s.email=UserData.get(s.contactid);
                s.username=UserData.get(s.contactid);
                
                if(!updatable){ updatable=true; }
            }
        }
        if(updatable){
            update Users;
        }
    }
    
    public void finish(Database.BatchableContext BC){}
}