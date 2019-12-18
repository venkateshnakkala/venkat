/**
 * An apex page controller that exposes the site forgot password functionality
 */
@IsTest(SeeAllData=true)
 public with sharing class ForgotPasswordControllerTest {
     @IsTest(SeeAllData=true) public static void testForgotPasswordController() {
        
        ForgotPasswordController controller = new ForgotPasswordController();
        
        User u1 = [select id, username, email from user where isActive=false limit 1];

        controller.username = u1.email;        
        System.assertEquals(controller.forgotPassword(),null); 
       
        User u2 = [select id, username, email from user where isActive=true limit 1];
        
        controller.username = u2.username;        
        System.assertEquals(controller.forgotPassword(),null); 
        
        controller.username = '123';        
        System.assertEquals(controller.forgotPassword(),null); 
    }
}