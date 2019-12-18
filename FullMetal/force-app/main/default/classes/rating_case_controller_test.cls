@isTest
public class rating_case_controller_test {
    
    public static testMethod void test1(){
        case cases = new case(SuppliedEmail= 'test@test.com',Rating__c = 4.0);
        insert cases;
        
        PageReference pageRef = Page.Rating_Case_Page;
        pageRef.getParameters().put('id', String.valueOf(cases.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(cases);
        rating_case_controller testAccPlan = new rating_case_controller(sc);
        
        
        testAccPlan.comment = 'test comment';
        //testAccPlan.rating = 5.0;
        testAccPlan.saveCase();
        
        Case cs = [SELECT id,Rating__c from Case where Id =: cases.Id];
        //system.assertEquals(5.0,cs.Rating__c );
    }
}