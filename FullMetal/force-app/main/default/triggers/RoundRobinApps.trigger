trigger RoundRobinApps on Contact (after insert, after update)
{
    if(RoundRobinApps.isFirstTimeContact)
    {
        RoundRobinApps.isFirstTimeContact=false;
        
        List<contact> cons= [select id, owner.id, school_status__c, (select id, Enrollment_Reperesentative__c, Enrollment_Guide_Team_2__c from applications__r where program_code__c like '%-O%' order by id) from Contact where id=:trigger.new and (school_status__c='Enrolled' or school_status__c='Enrolled - Trial Period' or school_status__c='Cancel Enrollment'  or school_status__c='Withdrawn') and Program_Code__c like '%-O%'];
        RoundRobinApps.whoIsNext(cons,trigger.oldmap);
    }
}