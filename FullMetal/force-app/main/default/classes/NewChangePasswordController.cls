public with sharing class NewChangePasswordController {
    
     public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    public String message{get;set;}  
    
    public NewChangePasswordController() {
        message='';
    }    
    public PageReference changePassword() {
        System.PageReference page;
        try {
            page=Site.changePassword(newPassword,verifyNewPassword);
        }
        catch(Exception e){
            message=e.getMessage();
        } 
        return page; 
    }  
    public PageReference init(){
    return null;
    }   
    
     public PageReference checkApplications() {
       
        User u = [SELECT Id,Name,ContactId FROM User WHERE Id = :userInfo.getUserId()];
     //   applicationList = [SELECT Id,Name,Program__c,Application_Status__c,CreatedDate,Start_Date__c,Expected_Start_Date__c,Application_Submitted__c FROM Application__c WHERE Student__c = :u.ContactId ORDER BY CreatedDate DESC];
       
        //redirect homepage based on the custom meta data value - changes made by CR team on 04-09-2019
        Lafilmschool_Application__mdt appFlow = [select Enable_Flow__c  from Lafilmschool_Application__mdt where DeveloperName= 'ApplicationFlow'];
    
     
             if(appFlow.Enable_Flow__c!= null && appFlow.Enable_Flow__c.equalsIgnoreCase('TRUE')){ 
             //   return new PageReference('/apex/NewApplicationdetail');
            return null;
             }
             else{
                 return null; 
             }
         
    }

}