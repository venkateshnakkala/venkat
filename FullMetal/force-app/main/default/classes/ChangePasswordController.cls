/**
 * An apex page controller that exposes the change password functionality
 */
public with sharing class ChangePasswordController {

    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    public String message{get;set;}  
    
    public ChangePasswordController() {
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
}