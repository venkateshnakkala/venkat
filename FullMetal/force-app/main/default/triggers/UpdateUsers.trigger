trigger UpdateUsers on Contact (before update) 
{
    
    Map<Id,String> emails = new Map<Id,String>();
    
    for(Contact c :Trigger.new)
    {
        Contact oldC = Trigger.oldMap.get(c.id);
        
        if(c.email!=oldC.email && c.email!=NULL && !c.email.contains('@lafilm.')){
            emails.put(c.id,c.email);
        }
    }
    
    if(emails.size()>0)
    {
        UpdateUsers u = new UpdateUsers(emails);
        Database.executeBatch(u);
    }
}