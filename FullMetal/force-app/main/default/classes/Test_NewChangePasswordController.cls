@isTest
public class Test_NewChangePasswordController {
    public static testmethod void ChangePassword(){
        Account testAccount = new Account( Name ='acctest'
                                         );
        insert testAccount;
        
        Contact testContact= new Contact(FirstName ='Test',
                                         LastName ='User',
                                         Phone ='9389378344',
                                         OtherPhone ='8878777654',
                                         AccountId = testAccount.Id,
                                         Email ='testuserma@test.com'
                                        );
        insert testContact;
        
        
        Id newprofile = [select id from Profile where name='Application User'].id;
        
        user u= new user(LastName ='test1',
                         FirstName ='test2',
                         Email ='gayathri.aila@criticalriver.com',
                         Alias ='tvjd',
                         Username = 'jason@banana.com',
                         CommunityNickname = 'dsfgh',
                         ProfileId = newprofile,
                         ContactId = testContact.id,
                         TimeZoneSidKey = 'GMT',
                         LanguageLocaleKey = 'en_US',
                         EmailEncodingKey = 'UTF-8',
                         LocaleSidKey = 'en_US'
                        );
        
        insert u;
        
        
        PageReference ref1 = new PageReference('/apex/NewApplicationChangePassword');
        Test.setCurrentPage(ref1); 
        
        NewChangePasswordController controller = new NewChangePasswordController();
        controller.newPassword='berry';
        controller.verifyNewPassword='berry';
        controller.message='zzzzzzzzz';
        controller.changePassword();
        controller.init();
        controller.checkApplications();
    }
   
    
    public static testmethod void ChangePassword1(){
        Account testAccount = new Account( Name ='acctest'
                                         );
        insert testAccount;
        
        Contact testContact= new Contact(FirstName ='Test',
                                         LastName ='User',
                                         Phone ='9389378344',
                                         OtherPhone ='8878777654',
                                         AccountId = testAccount.Id,
                                         Email ='testuserma@test.com'
                                        );
        insert testContact;
        
        
        Id newprofile = [select id from Profile where name='Application User'].id;
        
        user u= new user(LastName ='test1',
                         FirstName ='test2',
                         Email ='gayathri.aila@criticalriver.com',
                         Alias ='tvjd',
                         Username = 'jason@banana.com',
                         CommunityNickname = 'dsfgh',
                         ProfileId = newprofile,
                         ContactId = testContact.id,
                         TimeZoneSidKey = 'GMT',
                         LanguageLocaleKey = 'en_US',
                         EmailEncodingKey = 'UTF-8',
                         LocaleSidKey = 'en_US'
                        );
        
       // insert u;
       
        PageReference ref1 = new PageReference('/apex/NewApplicationChangePassword');
        Test.setCurrentPage(ref1); 
         PageReference ref2 = new PageReference('/apex/ApplicationChangePassword');
        Test.setCurrentPage(ref2); 
        NewChangePasswordController controller1 = new NewChangePasswordController();
        //controller1.newPassword='';
        //controller1.verifyNewPassword='';
       // controller1.message='';
        controller1.changePassword();
       
    }
}