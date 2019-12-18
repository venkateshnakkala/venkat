@isTest
public class TestNewApplicationHeaderController {
 public String username;
 public String password;
 public Boolean resetPassword;
    
    public static testMethod void resetPasswordTrue () { 
        PageReference pageRef = Page.NewApplication;
        pageRef.getParameters().put('resetPassword', 'true');
        Test.setCurrentPage(pageRef);
        NewApplicationHeaderComponentController controller = new NewApplicationHeaderComponentController();
    }
    
    public static testMethod void resetPasswordFalse () { 
        PageReference pageRef = Page.NewApplication;
        pageRef.getParameters().put('resetPassword', 'false');
        Test.setCurrentPage(pageRef);
        NewApplicationHeaderComponentController controller = new NewApplicationHeaderComponentController();
                
    } 
    
    public static testMethod void testPageVar () {
        NewApplicationHeaderComponentController controller = new NewApplicationHeaderComponentController();
        controller.page='test';
    }
     
}