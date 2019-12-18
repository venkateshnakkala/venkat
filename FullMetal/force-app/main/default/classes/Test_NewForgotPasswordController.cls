@isTest
Private class Test_NewForgotPasswordController {
    @isTest static void Forgotpswd(){
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
                         Email ='jason@banana.com',
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
        u.IsActive=true;
        
        insert u;
        
        PageReference ref1 = new PageReference('/apex/NewApplicationForgotPassword');
        Test.setCurrentPage(ref1);
        
        NewForgotPasswordController controller = new NewForgotPasswordController();
        controller.username='jason@banana.com';
        controller.message='An email has been sent to you with your password Reset Link.';
        controller.isSuccess=true;
        controller.pageName='NewApplicationForgotPassword';
        controller.displaysignin=true;
        controller.forgotPassword();
    }
    @IsTest static void Forgotpswd1(){
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
                         Email ='jason@banana.com',
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
        u.IsActive=false;
        
        insert u;
        
        PageReference ref1 = new PageReference('/apex/NewApplicationForgotPassword');
        Test.setCurrentPage(ref1);
        
        NewForgotPasswordController controller1 = new NewForgotPasswordController();
        controller1.username='jason@banana.com';
        controller1.message='Your username has been disabled.';
        controller1.isSuccess=false;
        controller1.pageName='NewApplicationForgotPassword';
        controller1.displaysignin=true;
        controller1.forgotPassword();
        

    }
    @isTest static void Forgotpswd3(){
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
                         Email ='gayu@banana.com',
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
        u.IsActive=false;
        
        insert u;
        
        PageReference ref1 = new PageReference('/apex/NewApplicationForgotPassword');
        Test.setCurrentPage(ref1);
        
        NewForgotPasswordController controller2 = new NewForgotPasswordController();
        controller2.username='jason@banana.com';
        controller2.message='The Email ID you entered does not exist.';
        controller2.isSuccess=false;
        controller2.pageName='NewApplicationForgotPassword';
        controller2.displaysignin=false;
        controller2.forgotPassword();
    }
    
}