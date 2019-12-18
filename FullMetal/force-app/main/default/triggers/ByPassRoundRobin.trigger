trigger ByPassRoundRobin on Application__c (after insert) 
{
    Map<Id,Contact> con = new Map<Id,Contact>();
    
    for(Application__c newApp :Trigger.new)
    {
        if(newApp.Addmissions_Representative__c!=NULL)
        {
            con.put(newApp.Student__c,new Contact(Id=newApp.Student__c, OwnerId=newApp.Addmissions_Representative__c));
        }
    }

    if(con.size()>0){
        update con.values();
    }
}