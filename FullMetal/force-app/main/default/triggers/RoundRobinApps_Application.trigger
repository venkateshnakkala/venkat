Trigger RoundRobinApps_Application on Application__c (after insert, after update) 
{
    if(RoundRobinApps.isFirstTimeApplication)
    {
        RoundRobinApps.isFirstTimeApplication=false;
        
        List<Id> conIds = new List<Id>();
        List<application__c> apps = [select id, Program_Code__c, student__r.id from application__c where id=:trigger.new];
        Application__c old = new Application__c();
        
        for(Application__c a :apps)
        {
            if(Trigger.isUpdate){
                old = Trigger.oldMap.get(a.id);
            }
            
            if((Trigger.isInsert && a.program_code__c!=NULL && a.program_code__c.endsWith('-O')) 
                || (Trigger.isUpdate && a.program_code__c!=NULL && a.program_code__c.endsWith('-O') && a.program_code__c!=old.program_code__c))
            {
                conIds.add(a.student__r.id);
            }
        }
        
        List<contact> cons = new List<contact>();
        if(conIds.size()>0){
            cons= [select id, owner.id, school_status__c, (select id, Enrollment_Reperesentative__c, Enrollment_Guide_Team_2__c from applications__r where program_code__c like '%-O%' order by id) from Contact where id=:conIds and (school_status__c='Enrolled' or school_status__c='Enrolled - Trial Period') and Program_Code__c like '%-O%'];
        }
        
        if(cons.size()>0){
            RoundRobinApps.whoIsNext(cons, new Map<Id,Contact>());
        }
    }
}