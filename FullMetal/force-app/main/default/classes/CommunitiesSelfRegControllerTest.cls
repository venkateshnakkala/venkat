/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
@IsTest 
public with sharing class CommunitiesSelfRegControllerTest {

    public static testMethod void testCommunitiesSelfRegController() {
    	PageReference pageRef = Page.Application;
    	pageRef.getParameters().put('sId', '02');
    	
    	Test.setCurrentPage(pageRef);
    	
    	
    	
        CommunitiesSelfRegController controller = new CommunitiesSelfRegController();
        controller.firstName = 'F';
        controller.lastName = 'La';
        controller.email = 'test@force.com';
        controller.password='abcd1234';
        controller.confirmPassword='abcd1234';
		System.assert(controller.registerUser() == null);
		
		Contact c = new Contact();
		c.lastname='test123';
		c.email='test123@email.com';
		
		insert c;
		
        controller.firstName = 'Frffsd';
        controller.lastName = 'Lafsdfsd';
        controller.email = 'test123@email.com';
        controller.password='abcd1234';
        controller.confirmPassword='abcd1234';
		System.assert(controller.registerUser() == null);
		c.validation_code__c='ABC123';
		update c;
		controller.ValidCode='ABC123';
		Blob b;
		b=Blob.valueOf(c.id+'~'+c.email+'~'+c.validation_code__c);
		pageRef.getParameters().put('code', EncodingUtil.base64Encode(b));
		
		System.assert(controller.registerUser() == null);
		controller.resend();
		System.assert(controller.registerUser() == null);
        // registerUser will always return null when the page isn't accessed as a guest user
        //
        System.assertNotEquals(null, controller.forwardToForgotPassPage());
        System.assertNotEquals(null, controller.forwardToLoginPage());
        
        controller.password = 'Salesforce1';
        controller.confirmPassword = 'Salesforce1';
        //System.assert(controller.registerUser() == null); 
        CommunitiesSelfRegController controller2 = new CommunitiesSelfRegController();
        
        controller.firstName = 'FirstName';
        controller.lastName = 'LastName';
        controller.email = 'test@force.com';
        
        // registerUser will always return null when the page isn't accessed as a guest user
        //System.assert(controller.registerUser() == null);
       	System.assertNotEquals(null, controller.forwardToForgotPassPage());
        System.assertNotEquals(null, controller.forwardToLoginPage());
        
        controller2.password = 'Sa';
        controller2.confirmPassword = 'Salesforce1';
        //System.assertEquals(null,controller.registerUser());
        
       PageReference pageRef2 = Page.Application;
    	
    	Test.setCurrentPage(pageRef2);
    	Test.setCurrentPage(pageRef2);
        CommunitiesSelfRegController controller3 = new CommunitiesSelfRegController();
        controller3.firstName = 'FirstName';
        controller3.lastName = 'LastName';
        controller3.email = 'test2@force.com';
        //controller3.registerUser();
        
        PageReference pageRef4= Page.Application;
    	
    	Test.setCurrentPage(pageRef4);
    	pageRef.getParameters().put('sId', '01');
        CommunitiesSelfRegController controller4 = new CommunitiesSelfRegController();
        controller4.firstName = 'FirstName';
        controller4.lastName = 'LastName';
        controller4.email = 'test2@force.com';
        //controller4.registerUser();
        
 
        
        controller3.password = 'Salesforce40';
        controller3.confirmPassword = null;
        
    	Test.setCurrentPage(pageRef4);
    }    
}