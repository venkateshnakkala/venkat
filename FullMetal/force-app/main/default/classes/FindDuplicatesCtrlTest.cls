@IsTest(SeeAllData=true)
public class FindDuplicatesCtrlTest
{
    static testMethod void test1() {
        FindDuplicatesCtrl ctrl = new FindDuplicatesCtrl();
        
        Contact c1 = [select id, firstname, lastname, email, phone from contact where firstname!=NULL and email!=NULL and phone!=NULL limit 1];
        ctrl.FindDupContact(c1.email, c1.firstname, c1.lastname, c1.phone);
        
        Contact c2 = c1.clone(true,true,false,false); 
        c2.phone=NULL;
        update c2;
        ctrl.FindDupContact(c2.email, c2.firstname, c2.lastname, c2.phone);
        
        Contact c3 = c1.clone(true,true,false,false); 
        c3.email=NULL;
        update c3;
        ctrl.FindDupContact(c3.email, c3.firstname, c3.lastname, c3.phone);
        
        Contact c4 = c1.clone(true,true,false,false); 
        c4.firstname=NULL;
        update c4;
        ctrl.FindDupContact(c4.email, c4.firstname, c4.lastname, c4.phone);
        
        ctrl.FindDupContact(c1.email, '!@#$%^&*()', ')(*&^%$#@!~', c1.phone);
    }
    
    static testMethod void test2() {
        Application__c a1 = [select student__r.id, program_code__c from application__c where program_code__c!=NULL and Application_Finalized__c=false limit 1];
        FindDuplicatesCtrl ctrl = new FindDuplicatesCtrl();
        ctrl.FindDupsApplication(a1.student__r.id, a1.program_code__c);
        ctrl.FindDupsApplication(a1.student__r.id, 'something');
    }
}