/**
 * An apex page controller that exposes the site forgot password functionality
 */
public with sharing class ForgotPasswordController {
    public String username {get; set;}  
    
    public string message{get;set;}
       
    public ForgotPasswordController() {
        message='';
    }
    
    public PageReference forgotPassword() {
        try {
            List<User> u =[select id, isActive from user where email=:username];
            
            if(u.size()>0){
                List<user> activeUser=[select id, isActive from user where email=:username and isActive=true];
                if(activeUser.size()==0){
                    message='Your username has been disabled.';
                    return NULL;
                }
                boolean success = Site.forgotPassword(username);
                
                if (success) { 
                    message='An email has been sent to you with your temporary password.';  
                    return NULL;           
                }
            }
            else{
                message='We could not find this email address.'; 
                return NULL;
            }
        }
        catch(Exception e){
            message=e.getMessage();
        }
        return null;
    }
    
    public PageReference checkApplications() {
       
        User u = [SELECT Id,Name,ContactId FROM User WHERE Id = :userInfo.getUserId()];
     //   applicationList = [SELECT Id,Name,Program__c,Application_Status__c,CreatedDate,Start_Date__c,Expected_Start_Date__c,Application_Submitted__c FROM Application__c WHERE Student__c = :u.ContactId ORDER BY CreatedDate DESC];
       
        //redirect homepage based on the custom meta data value - changes made by CR team on 04-09-2019
        Lafilmschool_Application__mdt appFlow = [select Enable_Flow__c  from Lafilmschool_Application__mdt where DeveloperName= 'ApplicationFlow'];
    
     
             if(appFlow.Enable_Flow__c!= null && appFlow.Enable_Flow__c.equalsIgnoreCase('TRUE')){ 
                return new PageReference('/apex/NewApplicationForgotPassword');
             }
             else{
                 return null; 
             }
         
    }
}