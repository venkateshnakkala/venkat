trigger UpdateOwner on Contact (after update) 
{
    List<Id> Ids = new List<Id>();
    
    Map<Id,Contact> old = trigger.oldMap;
    
    for(Contact c :trigger.new)
    {
        if(old.containsKey(c.id) && c.Program_Code__c!=NULL && !c.Program_Code__c.contains('-O') && (c.ownerid!=old.get(c.id).ownerid || c.SyStudentId__c!=old.get(c.id).SyStudentId__c)){
            Ids.add(c.id);
        }
    }
    
    if(Ids.size()>0){
        UpdateOwner u = new UpdateOwner(Ids);
        database.executebatch(u,100);
    }
}