/**
 * An apex page controller that exposes the site forgot password functionality
 */
public with sharing class NewForgotPasswordController {
    public String username {get; set;}  
    
    public string message{get;set;}
    public Boolean isSuccess{get;set;}
     public string pageName{get;set;}  
    public Boolean displaysignin{get;set;}
    public NewForgotPasswordController ()
    {pageName='NewApplicationForgotPassword';
        displaysignin=False;
       // pageName = ApexPages.currentPage().getUrl();
       // pageName = pageName.replaceFirst('/apex/',''); 
         system.debug('pageName=='+pageName);
       
        message='';
        isSuccess=false;
    }
    
    public PageReference forgotPassword() {
        try {
            List<User> u =[select id, isActive from user where email=:username];
            
            if(u.size()>0){
                List<user> activeUser=[select id, isActive from user where email=:username and isActive=true];
                if(activeUser.size()==0){
                    isSuccess=False;
                    message='Your username has been disabled.';
                    return NULL;
                }
                boolean success = Site.forgotPassword(username);
                system.debug('===success==='+success);
                
                if (success) { 
                    message='An email has been sent to you with your password Reset Link.'; 
                    isSuccess=True;
                    return NULL;           
                }
            }
            else{
                message='The Email ID you entered does not exist.'; 
                return NULL;
            }
        }
        catch(Exception e){
            message=e.getMessage();
        }
        return null;
    }
}