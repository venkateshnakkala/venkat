trigger CreateUserTrigger on Contact (After Update) {

    List<Id> ids = new List<Id>();
    
    if(CreateCommunityUser.isFirstTime)
    {
        CreateCommunityUser.isFirstTime=false;
        
        for(Contact c :trigger.new){
            if(c.school_status__c=='Enrolled' || c.school_status__c=='Enrolled - Trial Period'){
                ids.add(c.id);
            }
        }
        /*
        if(ids.size()>0){
            CreateCommunityUser u = new CreateCommunityUser (ids);
            Database.executeBatch(u,50);
        }
        */
    }
}