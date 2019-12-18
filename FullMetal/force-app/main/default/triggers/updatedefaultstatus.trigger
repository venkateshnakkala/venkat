trigger updatedefaultstatus on Application__c (before insert, after update) 
{
    Set<Id> contactID = new Set<Id>();
    Set<Id> appID = new Set<Id>();
    

    for(Application__c app:trigger.new)
    {
        if(app.NSLDS_status__c == 'default' && (trigger.oldmap==NULL || app.NSLDS_status__c!=trigger.oldmap.get(app.id).NSLDS_status__c)){
            contactID.add(app.Student__c);
            appID.add(app.ID);
            
        }
    }
    
    List<Application__c>  updateOtherApps = [SELECT ID,NSLDS_status__c,Application_Status__c FROM Application__c WHERE Student__C IN :contactID AND ID NOT IN:appID];
    
    for(Application__c app:updateOtherApps){
        app.NSLDS_status__c = 'default'; 
    }
    
    update updateOtherApps;
        
}