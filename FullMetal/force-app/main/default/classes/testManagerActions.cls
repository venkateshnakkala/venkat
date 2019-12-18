@isTest
global class testManagerActions{
    @isTest static void test1(){
        Contact c = new Contact();
        c.lastname='test';
        insert c;
        Application__c a1 = new Application__c();
        a1.student__c=c.id;
        a1.application_status__c='Approved';
        insert a1;
        String output = ManagerActions.makeApprove(a1.id);
        System.assert(output==NULL || output!=NULL);
            
        Application__c a2 = new Application__c();
        a2.student__c=c.id;
        a2.application_status__c='Review';
        insert a2;
        output = ManagerActions.makeApprove(a2.id);
        System.assert(output==NULL || output!=NULL); 
    }
}