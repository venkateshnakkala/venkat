@isTest
global with sharing class CheckinLoginControllerTest {
    global String username {get; set;}
    global String password {get; set;}
  @isTest(SeeAllData=true)    
    global static void testCommunitiesLoginController () { 
        string username ='test@mar10.com';
        string password = 'salesforce1';
       CheckinLoginController controller = new CheckinLoginController();
        System.assertEquals(null, controller.login());
    }   
        
    
}