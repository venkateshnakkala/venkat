@isTest
global with sharing class TestApplicationLoginController {
    global String username {get; set;}
    global String password {get; set;}
	@isTest(SeeAllData=true)    
    global static void testCommunitiesLoginController () { 
        string username ='test@mar10.com';
        string password = 'salesforce1';
     	ApplicationLoginController controller = new ApplicationLoginController();
     	System.assertEquals(null, controller.forwardToAuthPage()); 
        System.assertNotEquals(null, controller.forwardToCustomRegPage());
        System.assertNotEquals(null, controller.forwardToForgotPassPage());
        System.assertEquals(null, controller.login());
    }   
        
    
}