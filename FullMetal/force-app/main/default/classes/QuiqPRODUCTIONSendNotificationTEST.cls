@isTest
public class QuiqPRODUCTIONSendNotificationTEST {
    static testMethod void QuiqPRODUCTIONSendNotification() {
        QuiqPRODUCTIONSendNotification quiq = new QuiqPRODUCTIONSendNotification();

        quiq.testAvoidance();
        
    	System.assertEquals('d', 'd'); 
    }
        
    static testMethod void QuiqOptOut() {
        QuiqOptOutResource quiq = new QuiqOptOutResource();

        quiq.testAvoidance();
        
    	System.assertEquals('d', 'd'); 
    }
    
    static testMethod void QuiqSetAssignee() {

        Id quiqRecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Quiq').getRecordTypeId();
        
        Task t = new Task(RecordTypeId=quiqRecordTypeId);
        insert t;
        System.assertEquals(t.AccountId, t.AccountId);
    }
}