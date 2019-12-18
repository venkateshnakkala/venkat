Trigger DocApi on echosign_dev1__SIGN_Agreement__c (after insert, after update) 
{
    List<echosign_dev1__SIGN_Agreement__c> Agreements=[SELECT Id, Application__c FROM echosign_dev1__SIGN_Agreement__c WHERE id=:Trigger.new AND application__c!=NULL AND name LIKE '%[%'];
    Map<Id,Id> Ids = new Map<Id,Id>();
    
    for(echosign_dev1__SIGN_Agreement__c a :Agreements){
        Ids.put(a.Application__c, a.Application__c);
    }
    
    if(Ids.Size()>0){
        DocAPI d = new DocAPI(Ids.values());
        Database.executeBatch(d,100);
    }
}