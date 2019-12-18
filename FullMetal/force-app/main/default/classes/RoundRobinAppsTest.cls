@isTest
Public Class RoundRobinAppsTest
{
    static testMethod void test1() 
    {
        Contact c = new Contact(firstname='fdsfsdfsd', lastname='tefdfsdt', program_code__c='ASMP-O');
        insert c;
        Application__c a = new Application__c(student__c=c.id, program_code__c='ASMP-O');
        insert a;
        
        RoundRobinApps.isFirstTimeContact=true;
        RoundRobinApps.isFirstTimeApplication=true;
        
        //#1
        c.ownerid='0051a000000c3qPAAQ'; //Michael Welch
        c.school_status__c='Enrolled';
        update c;
        c.school_status__c='Enrolled - Trial Period';
        update c;
        
        List<User> users = [select id, userrole.id, Weight_Value__c from user where userrole.id in ('00E1P000000ih0KUAQ','00E1a000000YD0lEAG') and isactive=true and out_of_office__c=false];
        
        for(User u :users)
        {
            u.Weight_Value__c=10;
        }
        update users;
        
        RoundRobinApps.isFirstTimeContact=true;
        RoundRobinApps.isFirstTimeApplication=true;
        
        //#2
        c.ownerid='0051a000002HC6fAAG'; //Joseph Melo
        c.school_status__c='Active';
        update c;
        a.Enrollment_Reperesentative__c=NULL;
        update a;
        c.school_status__c='Enrolled';
        update c;
        
        RoundRobinApps.isFirstTimeContact=true;
        RoundRobinApps.isFirstTimeApplication=true;

        //#3
        a.Enrollment_Reperesentative__c='0051a000002DULaAAO';
        update a;
        c.school_status__c='Enrolled - Trial Period';
        update c;
        Application__c aa = new Application__c(student__c=c.id, program_code__c='BSGD-O');
        insert aa;
        
        RoundRobinApps.isFirstTimeContact=true;
        RoundRobinApps.isFirstTimeApplication=true;
        
        //#4
        a.Enrollment_Reperesentative__c=NULL;
        a.Enrollment_Guide_Team_2__c=NULL;
        update a;
        c.ownerid='0051a000002HC6fAAG'; //Joseph Melo
        c.school_status__c='New Lead';
        update c;
        c.school_status__c='Enrolled';
        update c;
        
        RoundRobinApps.isFirstTimeContact=true;
        RoundRobinApps.isFirstTimeApplication=true;
        
        //#5
        c.school_status__c='Enrolled - Trial Period';
        update c;
        
        RoundRobinApps.isFirstTimeContact=true;
        RoundRobinApps.isFirstTimeApplication=true;
        
        //#6
        c.school_status__c='Cancel Enrollment';
        update c;
        
        RoundRobinApps.isFirstTimeContact=true;
        RoundRobinApps.isFirstTimeApplication=true;
        
        RoundRobinApps.updateUser(c.id,0);
        
        RoundRobinApps.isFirstTimeContact=true;
        RoundRobinApps.isFirstTimeApplication=true;
        
        RoundRobinApps.updateUsers();
    }
    
    static testMethod void test2() 
    {
        Contact c = new Contact(firstname='fdsfgsfgsdsdfsd', lastname='tefdfsfdsfsdt', program_code__c='ASMP-O', school_status__c='Active');
        insert c;
        Application__c a = new Application__c(student__c=c.id, program_code__c='ASMP-O');
        insert a;
        
        c.school_status__c='Cancel Enrollment';
        update c;
        
        RoundRobinApps.isFirstTimeContact=true;
        RoundRobinApps.isFirstTimeApplication=true;
        c.school_status__c='Enrolled';
        update c;
    }
}