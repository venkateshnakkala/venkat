@isTest(seeAlldata=true)
private class TestNewApplicationController {
    static Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
    static UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
    static Id profile = [select id from profile where name='Application User'].id;
    static Account acc = new Account(name ='test Account') ;
    static  Contact con = new Contact(FirstName = 'Bob',
                                      LastName = 'Jones',
                                      Phone = '654-654-6548',
                                      OtherPhone = '654-987-6548',
                                      MailingStreet = '123 main',
                                      MailingCity = 'Waukesha',
                                      MailingState = 'WI',
                                      MailingPostalCode = '53186',
                                      Email = 'test@mail.com',
                                      MailingCountry = 'United States',
                                      SSN__c = '321-65-9874',
                                      Country_of_Citizenship__c = 'Jamaica',
                                      Alien_Registration_Number__c = '65',
                                      Citizenship_Status__c = 'test',
                                      Visa_Type__c= 'test',
                                      Visa_School_Name__c= 'test',
                                      Visa_School_Address__c= 'test',
                                      Visa_School_City__c= 'test',
                                      Visa_School_State__c= 'test',
                                      Visa_School_Country__c= 'test',
                                      Eligible_For_Military_Benefits__c = true,
                                      Affiliation__c = 'test',
                                      Military_Branch__c = 'test',
                                      Authorize__c = true,
                                      Certificate_or_NOBE__c= true,
                                      Gender__c = 'test',
                                      Ethnicity__c = 'test',
                                      Nationality__c = 'test',
                                      Student_Info_Complete__c = true
                                     );
    static User testUser = new User( Email = 'test@mail.com',
                                    FirstName = 'Bob',
                                    LastName = 'Jones',
                                    Alias = 'bjones', 
                                    EmailEncodingKey='UTF-8', 
                                    LanguageLocaleKey='en_US', 
                                    LocaleSidKey='en_US', 
                                    //ProfileId = c.Id, 
                                    Phone = '123-123-1234',
                                    TimeZoneSidKey='America/Los_Angeles', 
                                    UserName='test@mail.com',
                                    ContactId = con.Id );    
    
    static Application__c app = new Application__c(Student__c = con.Id,
                                                   Application_Status__c = 'Incomplete',
                                                   Start_Date__c=system.today(),
                                                   Application_Submitted__c= true);
    
    @isTest static void newStartApplication() {
        Test.startTest();
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.checkpgmconsideration = false;
        newApplication.prconsider = false;
        newApplication.selectAgreementToSign();
        newApplication.changeconsentration();
        newApplication.resetpassmodal=true;
        Test.stopTest();
    }
    @isTest static void testProgramOption(){
        Test.startTest();
        Campus_Option__c campusOption = new Campus_Option__c();
        campusOption.Name='OnCampus';
        insert campusOption;
        
        Program_Option__c programOption =  new Program_Option__c();
        programOption.Program_Code__c = 'BSPO';
        programOption.Name = 'Bachelor of Science in Animation Online'; 
        programOption.Campus_Option__c = campusOption.Id;
        insert programOption;  
        
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.CampusOption = campusOption.Id;
        
        List<SelectOption> prgmOPtion = newApplication.Programoptions;
        Test.stopTest();
        
    }
    @isTest static void testProgramOptionFalse(){
        Test.startTest();
        NewApplicationController newApplication = new NewApplicationController();
        Program_Option__c programOption =  new Program_Option__c();
        programOption.Program_Code__c = 'BSPO';
        programOption.Name = 'Bachelor of Science in Animation Online'; 
        insert programOption;  
        List<SelectOption> prgmOPtion = newApplication.Programoptions;
        Test.stopTest();
    }
    @isTest static void testProgramConsideration(){
        Test.startTest();
        NewApplicationController newApplication = new NewApplicationController();
        Campus_Option__c campusOption = new Campus_Option__c();
        campusOption.Name='Online';
        insert campusOption;
      
        newApplication.campusOption=campusOption.Name;
        Program_Option__c programOption =  new Program_Option__c();
        programOption.Name='Bachelor of Science in Animation Online';
        programOption.Campus_Option__c = campusOption.Id;
        programOption.Program_Code__c='test';
        insert programOption; 
 
        
        newApplication.studentProgram = programOption.Program_Code__c;
        Program_Concentration__c programConcentration = new Program_Concentration__c();
        programConcentration.Name='Visual Effects';
        programConcentration.Program_Option__c=programOption.Id;
        insert programConcentration;
        List<SelectOption> listofprm = newApplication.Programconsiderations;
        Test.stopTest();
    }
    @isTest static void testProgramConsiderationFalse(){
        NewApplicationController newApplication = new NewApplicationController();
        List<SelectOption> listofprm = newApplication.Programconsiderations;
    }
    @isTest static void pageReference(){
        Test.startTest();
        NewApplicationController newApplication = new NewApplicationController();
        PageReference pref = Page.NewApplicationForm;
        Test.setCurrentPage(pref);
        newApplication.startapplication();
        newApplication.sendtofogotpassword();
        Test.stopTest();
    }
    @isTest static void testLandingPage(){
        Test.startTest();
        NewApplicationController newApplication = new NewApplicationController();
        Landing_Page_Additional_Section__c l = new Landing_Page_Additional_Section__c();
        l.Title__c='test title';
        l.content__c='test Content';
        l.isActive__c=true;
        insert l;
        List<NewApplicationController.LandingPageSectionsWrapper> newLandingPage = newApplication.LandingPageSections;
        Test.stopTest();
    }
    
    @isTest static void testBannerPage(){
        test.startTest();
        NewApplicationController newApplication = new NewApplicationController();
        Landing_Page_Banner__c bannerpage = new Landing_Page_Banner__c();
        bannerpage.content__c = 'test bannaer page';
        bannerpage.Name = 'lafs';
        bannerpage.isActive__c = TRUE;
        insert bannerpage;
        List<NewApplicationController.BannersWrapper> newApplicationwrap = newApplication.banners;
        test.stopTest();
    } 
  /*  @isTest static void testRequestedDocuments(){
        
        NewApplicationController newApplication = new NewApplicationController();
         newApplication.RequestedDocuments();
        
               
        
    } */
    
    @isTest static void testCreatesiteuser(){
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.studentFirstName='test';
        newApplication.studentLastName='user1';
        newApplication.studentEmail='testUser@bigCo.com';
        newApplication.studentEmailconformation='testUser@bigCo.com';
        newApplication.studentPhone=newApplication.hiddenPhone;
        newApplication.hiddenPhone = con.phone;
        newApplication.studentProgram = con.Program_Code__c;
        newApplication.CampusOption = con.Program_Type__c;
        newApplication.Programconsideration = con.Program_Consideration__c;
        newApplication.password = 'abcd1234';
        Account a = new Account(Name='Test Big Co');
        Insert a;
        Contact c = new Contact(LastName='TestUser', Email='testUser@bigCo.com', AccountId=a.Id);
        Insert c;
        User u = new User();
        u.Username = 'testUser@bigCo.com';
        u.Email = 'testUser@bigCo.com';
        u.CommunityNickname = 'testUser';             
        u.ContactId = c.Id;
        test.startTest();
        PageReference pageRef = Page.NewApplicationDetail;
        Test.setCurrentPage(pageRef);
        String userId = Site.createPortalUser(u, a.Id, 'abc123!',true); 
        newApplication.createsiteuser();
        test.stopTest(); 
    }
    @isTest static void testuserCreationWithNullValues(){
        
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.studentFirstName='';
        newApplication.studentLastName='';
        newApplication.studentEmail='';
        newApplication.studentEmailconformation='';
        newApplication.studentPhone='';
        newApplication.studentProgram = '';
        newApplication.CampusOption = '';
        newApplication.Programconsideration ='';
        newApplication.password = '';
        newApplication.createsiteuser();
        
    }
    @isTest static void testuserCreationInvalidEmail(){
        
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.studentFirstName='test';
        newApplication.studentLastName='user1';
        newApplication.studentEmail='testnew@gmail.com';
        newApplication.studentEmailconformation='testne@gmail.com';
        newApplication.studentPhone=newApplication.hiddenPhone;
        newApplication.studentProgram = con.Program_Code__c;
        newApplication.CampusOption = con.Program_Type__c;
        newApplication.Programconsideration = con.Program_Consideration__c;
        newApplication.password = 'abcd1234';
        
        Test.startTest();
        newApplication.createsiteuser();
        test.stopTest();
        
        System.assertEquals( 0, [ SELECT COUNT() FROM User WHERE email = :newApplication.studentEmail 
                                 AND Profile.Name = 'Application User'
                                ]
                           );
    }
    @isTest static void testuserCreationEmail(){
        
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.studentFirstName='test';
        newApplication.studentLastName='user1';
        newApplication.studentEmail='testne@gmail.com';
        newApplication.studentEmailconformation='testne@gmail.com';
        newApplication.studentPhone=newApplication.hiddenPhone;
        newApplication.studentProgram = con.Program_Code__c;
        newApplication.CampusOption = con.Program_Type__c;
        newApplication.Programconsideration = con.Program_Consideration__c;
        newApplication.password = 'abcd1234';
        Account a = new Account(Name='Test Big Co');
        Insert a;
        Contact c = new Contact(LastName='TestUser', Email='usereffbdhs@bigCo.com', AccountId=a.Id);
        Insert c;
        User u = new user();
        u.LastName = 'test user';
        u.Email = 'usereffbdhs@bigCo.com';
        u.ContactId = c.id; 
        u.Alias = 'teslias';
        u.emailencodingkey='UTF-8';
        u.languagelocalekey = 'en_US';
        u.timezonesidkey='America/Los_Angeles';
        u.localesidkey = 'en_US';
        u.profileid = profile;
        u.Username = 'testusbbu@gjn.com';
        insert u;
        Test.startTest();
        newApplication.createsiteuser();
        test.stopTest();
        
       /* System.assertEquals( 1, [ SELECT COUNT() FROM User WHERE email = :newApplication.studentEmail 
                                 AND Profile.Name = 'Application User'
                                ]
                           ); //*/
    }
    @isTest static void testCreateValidEmailUser(){
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.studentFirstName='test';
        newApplication.studentLastName='user1';
        newApplication.studentEmail='testUser12@bigCo.com';
        newApplication.studentEmailconformation='testUser12@bigCo.com';
        newApplication.studentPhone=newApplication.hiddenPhone;
        newApplication.hiddenPhone = con.phone;
        newApplication.studentProgram = con.Program_Code__c;
        newApplication.CampusOption = con.Program_Type__c;
        newApplication.Programconsideration = con.Program_Consideration__c;
        newApplication.password = 'abcd1234';
        Account a = new Account(Name='Test Big Co');
        Insert a;
        Contact c = new Contact(LastName='TestUser', Email='testUser12@bigCo.com', AccountId=a.Id);
        Insert c;
        
        Test.startTest();
        newApplication.createsiteuser(); 
        test.stopTest();
        
        /*System.assertEquals( 1, [ SELECT COUNT() FROM User WHERE email = :newApplication.studentEmail 
                                 AND Profile.Name = 'Application User'
                                ]
                           ); //*/
        newApplication.createsiteuser(); 
     /*   System.assertEquals( 1, [ SELECT COUNT() FROM User WHERE email = :newApplication.studentEmail 
                                 AND Profile.Name = 'Application User' AND IsActive = TRUE
                                ]
                           );//*/
    }
    
    @isTest static void testForToActiveUser(){
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.studentFirstName='test';
        newApplication.studentLastName='user1';
        newApplication.studentEmail='usereffbdhs@bigCo.com';
        newApplication.studentEmailconformation='usereffbdhs@bigCo.com';
        newApplication.studentPhone=newApplication.hiddenPhone;
        newApplication.hiddenPhone = con.phone;
        newApplication.studentProgram = con.Program_Code__c;
        newApplication.CampusOption = con.Program_Type__c;
        newApplication.Programconsideration = con.Program_Consideration__c;
        newApplication.password = 'abcd1234';
        Account a = new Account(Name='Test Big Co');
        Insert a;
        Contact c = new Contact(LastName='TestUser', Email='usereffbdhs@bigCo.com', AccountId=a.Id);
        Insert c;
        User u = new user();
        u.LastName = 'test user';
        u.Email = 'usereffbdhs@bigCo.com';
        u.ContactId = c.id; 
        u.IsActive = False;
        u.Alias = 'teslias';
        u.emailencodingkey='UTF-8';
        u.languagelocalekey = 'en_US';
        u.timezonesidkey='America/Los_Angeles';
        u.localesidkey = 'en_US';
        u.profileid = profile;
        u.Username = 'testuser12bbu@gjn.com';
        insert u;
        Test.startTest();
        newApplication.createsiteuser();   
        test.stopTest();
        System.assertEquals( 1, [ SELECT COUNT() FROM User WHERE email = :newApplication.studentEmail 
                                 AND Profile.Name = 'Application User'
                                ]
                           ); 
        newApplication.createsiteuser(); 
        System.assertEquals( 1, [ SELECT COUNT() FROM User WHERE email = :newApplication.studentEmail 
                                 AND Profile.Name = 'Application User' AND IsActive = FALSE
                                ]
                           ); 
    }
    @isTest static void testCreatesiteuserException(){
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.studentFirstName='test';
        newApplication.studentLastName='user1';
        newApplication.studentEmail='test@gmail.com';
        newApplication.studentEmailconformation='test@gmail.com';
        newApplication.studentPhone=newApplication.hiddenPhone;
        newApplication.hiddenPhone = con.phone;
        newApplication.studentProgram = con.Program_Code__c;
        newApplication.CampusOption = con.Program_Type__c;
        newApplication.Programconsideration = con.Program_Consideration__c;
        newApplication.password = 'abcd1234';
        Test.StartTest();
        newApplication.createsiteuser();
        test.StopTest();
    }
    @isTest static void testVerifyApplication(){
        NewApplicationController newApplication  = new NewApplicationController();
        insert con;
        Application__c testApp = new Application__c(
            student__c = con.Id            
        );    
        insert testApp; 

        Test.StartTest();
        newApplication.verifyApplication();
        PageReference pref = Page.NewTotalApplications; 
        pref.getParameters().put('id', String.valueOf(testApp.Id));
       // pref.getParameters().put('id',testApp.id);
		Test.setCurrentPage(pref);
        Test.StopTest();
    }
    @isTest static void testResetPassWordEamilFalse(){
        NewApplicationController newApplication  = new NewApplicationController();
        newApplication.forgotPasswordEmail = 'testuser12bbu@gjn.com';
        Test.startTest();
        newApplication.resetPasswordemail('testuser12bbu@gjn.com');
        newApplication.resetPassword();
        test.stopTest();
    }
    @isTest static void testResetPassWordEamil(){
        NewApplicationController newApplication  = new NewApplicationController();
        newApplication.forgotPasswordEmail = 'testuser12bbu@gjn.com';
        Account a = new Account(Name='TestBigCo');
        Insert a;
        Contact c = new Contact(LastName='Test11Users', Email='testUsr5@bigCo.com', AccountId=a.Id);
        Insert c;
        User u = new user();
        u.LastName = 'test user';
        u.Email = 'testUsr5@bigCo.com';
        u.ContactId = c.id; 
        u.IsActive = TRUE;
        u.Alias = 'testias';
        u.emailencodingkey='UTF-8';
        u.languagelocalekey = 'en_US';
        u.timezonesidkey='America/Los_Angeles';
        u.localesidkey = 'en_US';
        u.profileid = profile;
        u.Username = 'testuser12bbu@gjn.com';
        insert u;
        Test.startTest();
        newApplication.resetPasswordemail('testuser12bbu@gjn.com');
        newApplication.resetPassword();
        test.stopTest();
        
        System.assertEquals( 1, [ SELECT COUNT() FROM User WHERE userName = :newApplication.forgotPasswordEmail 
                                 AND Profile.Name = 'Application User'
                                ]
                           );
        newApplication.resetPasswordemail('testuser12bbu@gjn.com');
        newApplication.resetPassword();
        System.assertEquals( 1, [ SELECT COUNT() FROM User WHERE userName = :newApplication.forgotPasswordEmail 
                                 AND Profile.Name = 'Application User' AND IsActive = TRUE
                                ]
                           );
    }
    @isTest static void testloginApplictaion(){
        NewApplicationController newApplication  = new NewApplicationController();
        newApplication.sectionName= 'test Section Name';
        newApplication.applicantUserName = 'usertesy@gmaisk.com';
        newApplication.applicantpassword = 'yfsytdl!';
        
        Account a = new Account(Name='TestABigCo');
        Insert a;
        Contact c = new Contact(LastName='Test11Users', Email='testUsr564@bigCo.com', AccountId=a.Id);
        Insert c;
        User u = new user();
        u.LastName = 'test user';
        u.Email = 'testUsr564@bigCo.com';
        u.ContactId = c.id; 
        u.IsActive = TRUE;
        u.Alias = 'teetias';
        u.emailencodingkey='UTF-8';
        u.languagelocalekey = 'en_US';
        u.timezonesidkey='America/Los_Angeles';
        u.localesidkey = 'en_US';
        u.profileid = profile;
        u.Username = 'usertesy@gmaisk.com';
        insert u;
        Test.startTest();
        newApplication.loginToApplicationAfterResettingPassword();
        Test.stopTest();
        System.assertEquals( 1, [ SELECT COUNT() FROM User WHERE userName = :newApplication.applicantUserName 
                                 AND Profile.Name = 'Application User'
                                ]
                           );
        newApplication.loginToApplicationAfterResettingPassword();
        System.assertEquals( 1, [ SELECT COUNT() FROM User WHERE userName = :newApplication.applicantUserName 
                                 AND Profile.Name = 'Application User' AND IsActive = TRUE
                                ]
                           );
    }
    @isTest static void testloginApplictaionElse(){
        NewApplicationController newApplication  = new NewApplicationController();
        newApplication.sectionName= 'test Section Name';
        newApplication.applicantUserName = 'usertesbd@gmaisk.com';
        newApplication.applicantpassword = 'yfsytdl!';
        
        Account a = new Account(Name='TestABigCo');
        Insert a;
        Contact c = new Contact(LastName='Test11Users', Email='testUsr54@bigCo.com', AccountId=a.Id);
        Insert c;
        User u = new user();
        u.LastName = 'test user';
        u.Email = 'testUsr54@bigCo.com';
        u.ContactId = c.id; 
        u.IsActive = FALSE;
        u.Alias = 'teetias';
        u.emailencodingkey='UTF-8';
        u.languagelocalekey = 'en_US';
        u.timezonesidkey='America/Los_Angeles';
        u.localesidkey = 'en_US';
        u.profileid = profile;
        u.Username = 'userte@gmaisk.com';
        insert u;
        Test.startTest();
        newApplication.loginToApplicationAfterResettingPassword();
        Test.stopTest();
        
    }
    @isTest static void testCheckApplications(){
        
        Lafilmschool_Application__mdt appFlow = [select Enable_Flow__c  from Lafilmschool_Application__mdt where DeveloperName= 'ApplicationFlow'];
        User u = [select id, username, email, contactid from user where profile.name='Application User' and isActive=true and contactid!=NULL limit 1];
        
        system.runAs(u){
            Test.startTest();
            PageReference pageRef = Page.NewTotalApplications;
            pageRef.getParameters().put('sId', '01');
            Test.setCurrentPage(pageRef);
            
            NewApplicationController newApplication  = new NewApplicationController();
            newApplication.sectionName='test';
            newApplication.applicantUserName='jfkdjf@fskfjs.com';
            newApplication.applicantpassword='abcd1234';
            newApplication.selecteduserId=u.id;
            newApplication.checkApplications();
            newApplication.isNewApplicationFlow();
            Test.stopTest();
        } 
        
        User u1 = [select id, username, email, contactid from user where profile.name='Application User' and isActive=true and contactid!=NULL limit 1];
        Application__c app = new Application__c();
        app.Student__c = u1.ContactId;
        app.Application_Status__c = 'Submitted';
        insert app;
        system.runAs(u1){
            NewApplicationController newApplication  = new NewApplicationController();
            newApplication.sectionName='test';
            newApplication.applicantUserName='jfkdjf@fskfjs.com';
            newApplication.applicantpassword='abcd1234';
            newApplication.selecteduserId=u1.id;
            newApplication.checkApplications();
        }
    }
    @isTest static void testGuestUser() 
    {
        String[] toAddresses = new String[] {'iaraia@lafilm.edu','dcuevas@lafilm.edu','jkottahachchige@lafilm.edu'};
            List<User> userList =[SELECT Id,Email FROM User WHERE Email IN :toAddresses];
        for(User u: userList){
            u.email='123'+u.email;
        }
        update userList;
        NewApplicationController.emailErrors('test','test');
        Map<String,String> toAddress2 = new Map<String,String>();
        toAddress2.put('123iaraia@lafilm.edu','iaraia@lafilm.edu');
        toAddress2.put('123dcuevas@lafilm.edu','dcuevas@lafilm.edu');
        toAddress2.put('123jkottahachchige@lafilm.edu','jkottahachchige@lafilm.edu');
        toAddress2.put('123tp.deshpande07@gmail.com','tp.deshpande07@gmail.com');
        List<User> listofUser =[SELECT Id,Email FROM User WHERE Email IN :toAddress2.keySet()];
        for(User u2: listofUser){
            u2.email=toAddress2.get(u2.email);
        }
        update listofUser;
        NewApplicationController.emailErrors('test','test',toAddress2);
    }
    
    @IsTest static void testcheckIfUserAlreadyExists(){
        try{ 
            User user1 = [select id, username, email, contactid from user where usertype like '%guest%' and isActive=true limit 1];
            system.runAs(user1){
                User ss =[select id, firstname, lastname, email, phone from user where isActive=true limit 1];
                Map<String,String> o = new Map<String,String>();
                o.put('email',ss.email);
                o.put('firstname',ss.firstname);
                o.put('lastname',ss.lastname);
                o.put('phone',ss.phone);
                NewApplicationController.checkIfUserAlreadyExists(o);
                
                contact c = new contact();
                c.email='testUsr54@bigCo.com';
                c.firstname='test';
                c.lastname='con';
                c.phone='8578945985';
                insert c;
                o.put('email','testUsr54@bigCo.com');
                o.put('firstname','test');
                o.put('lastname','con');
                o.put('phone','8578945985');
                NewApplicationController.checkIfUserAlreadyExists(o);
            }
        }
        catch(Exception e){
            
        }
    } 
    
    @IsTest static void testLogInToNewApplication(){
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.username = 'verifyloginuser@gmail.com';
        newApplication.password = 'password123';
        Account a = new Account(Name='TestABigCo');
        Insert a;
        Contact c = new Contact(LastName='Test11User', Email='testUsr64@bigCo.com', AccountId=a.Id);
        Insert c;
        User u = new user();
        u.LastName = 'test1 user';
        u.Email = 'testUsr64@bigCo.com';
        u.ContactId = c.id; 
        u.IsActive = TRUE;
        u.Alias = 'dhffd';
        u.emailencodingkey='UTF-8';
        u.languagelocalekey = 'en_US';
        u.timezonesidkey='America/Los_Angeles';
        u.localesidkey = 'en_US';
        u.profileid = profile;
        u.Username = 'verifyloginuser@gmail.com';
        insert u;
        Test.startTest();
        newApplication.loginToNewApplication(); 
        test.stopTest();
    }
    @IsTest static void testLogInToNewApplicationFalse(){
        
        NewApplicationController newApplication = new NewApplicationController();
        newApplication.username = 'usertesy@gmaisk.com';
        newApplication.password = 'yfsytdl';
        Test.startTest();
        newApplication.loginToNewApplication(); 
        test.stopTest();
    }
    @IsTest static void testCheckLogIn(){
        NewApplicationController newApplication = new NewApplicationController();
        insert con;
        List<SelectOption> t1 = newApplication.UserList;
        List<String> t2 = newApplication.StartDateOptions;
        User adminUser = new User(
            Email = 'testAdmin2@mail.com',
            FirstName = 'Sally2',
            LastName = 'Sallerson2',
            Alias = 'ssall2', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = p.Id, 
            Phone = '666-166-1234',
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='testAdmin2@mail.com'
        );
        insert adminUser;
        
        System.runAs(adminUser){
            PageReference pageRef = new PageReference('/apex/NewApplication');
            Test.setCurrentPage(pageRef);
            Test.startTest();
            newApplication.chkLogIn();
            
            Test.stopTest();
        }
    }
    
    @IsTest static void testCheckLogElseCondition(){
        NewApplicationController newApplication = new NewApplicationController();
        Account a = new Account(Name='Application Community');
        Insert a;
        Contact c = new Contact(LastName='Test11Users', 
                                FirstName='testuser',
                                Email='testU556@bigCo.com',
                                AccountId=a.Id
                               );
        Insert c;
        User u = new user();
        u.LastName = 'testyuu';
        u.Email = 'testU556@bigCo.com';       
        u.Alias = 'twhds';
        u.emailencodingkey='UTF-8';
        u.languagelocalekey = 'en_US';
        u.timezonesidkey='America/Los_Angeles';
        u.localesidkey = 'en_US';
        u.profileid =profile;
        u.Username = 'testugsr1277@gjn.com';
        u.ContactId = c.Id;
        insert u;
        System.runAs(u){
            PageReference pageRef = new PageReference('/apex/NewApplication');
            Test.setCurrentPage(pageRef);
            Test.startTest();
            newApplication.chkLogIn();
            Test.stopTest();
        }
    }
    @IsTest static void testSign(){
        User u = [select id, username, email, contactid from user where profile.name='Application User' and isActive=true and contactid!=NULL limit 1];
        system.runAs(u){
            Test.StartTest();
            NewApplicationController app = new NewApplicationController();
            
            String leadId = NewApplicationController.leadId;
            String attachId = app.attachId;
            String payLater = app.payLater;
            String pageSection = app.pageSection;
            String hsDiploma = app.hsDiploma;
            String collegeTranscript = app.collegeTranscript;
            String computerSpecs = app.computerSpecs;
            String parentsPhotoID = app.parentsPhotoID;
            String masterPromissoryNote = app.masterPromissoryNote;
            String i20 = app.i20;
            String i539 = app.i539;
            String i94 = app.i94;
            String passport = app.passport;
            String toefl = app.toefl;
            String usVisa = app.usVisa;
            String bankStatement = app.bankStatement;
            String dd214 = app.dd214;
            String ccaf = app.ccaf;
            String entranceCounseling = app.entranceCounseling;
            String plusMasterPromissoryNote = app.plusMasterPromissoryNote;
            String parentTaxReturn2017 = app.parentTaxReturn2017;
           // String parentTaxTranscripts2016 = app.parentTaxTranscripts2016;
            String spouseTaxReturn2017 = app.spouseTaxReturn2017;
            String spouseTaxTranscript2016 = app.spouseTaxTranscript2016;
            String studentTaxReturn2017 = app.studentTaxReturn2017;
            String studentTaxTranscripts2016 = app.studentTaxTranscripts2016;
            String w2Form = app.w2Form;
            String ISIRCCode030 = app.ISIRCCode030;
            String ISIRCCode146 = app.ISIRCCode146;
            String defaultResolutionLetter = app.defaultResolutionLetter;
            String dependencyOverrideStatement = app.dependencyOverrideStatement;
            String legalGuardianshipDocument = app.legalGuardianshipDocument;
            String wardOfCourtDocument = app.wardOfCourtDocument;
            
            app.getSignCount();
            
            app.sectionName='test';
            app.applicantUserName='fffs@fskfjs.com';
            app.applicantpassword='abcd1234';
            
            app.selecteduserId=u.id;
            PageReference pageRef = Page.NewApplication;
            pageRef.getParameters().put('sId', '01');
            Test.setCurrentPage(pageRef);
            
            app = new NewApplicationController();
            app.studentDetailsJSON='{}';
            app.under24String='test';
            app.saveStudentInfo();
            
            //  NewApplicationController.emailErrors('test','test');
            
            User s =[select id, username from user where profile.name='Application User' and isactive=true limit 1];
            app.username=s.username;
            app.applicantUserName=s.username;
            app.password='abcd1234';
            app.forgotPasswordEmail=u.email;
            app.resetPassword();
            NewApplicationController.getStudentInfo();
           
            Contact c = [select id, owner.id from contact where id=:u.contactid];
            Application__c a = [select id from application__c limit 1];
           
            NewApplicationController.repInfo(c.owner.id);
            app.representativeId=c.owner.id;
            Map<String,String> m = new Map<String,String>();
           // m.put('studentId',c.id);
            m.put('src','');
            m.put('studentSelectedUsState',null);
            m.put('guest',null);
            m.put('studentId',null);
            m.put('studentDOB','2016-01-01');
            m.put('applicationId',a.id);
            m.put('residentialStatus','I am an international student'); 
            m.put('visaExpirationDate','2016-01-01');
            m.put('qualifyForBenefits','Yes');
            System.runAs(u){
                update u;
            }
           
            NewApplicationController.sendWelcomeEmail(u.id);
             /*  NewApplicationController.studentInfo(m,false);
            
            User g = [select id, name, isactive from user where name like 'application Community Site Guest User'and isActive=true limit 1];
            System.runAs(g){
                NewApplicationController.studentInfo(m,false);
            }
            
            m.put('residentialStatus','I am a citizen of the United States');
            NewApplicationController.studentInfo(m,false);
            
            m.put('residentialStatus','I am a legal resident of the United States');
            NewApplicationController.studentInfo(m,false);
			*/
            
            Map<String,String> r = new Map<String,String>();
            
            NewApplicationController.applicationId=a.id;
            r.put('applicationId',a.id);
            r.put('referFriendQuestion','yes');
            r.put('studentId',c.id);
            
            NewApplicationController.referFriendInfo(r);
            
            List<SelectOption> l = app.UserList;
            List<String> l2 = app.StartDateOptions;
            NewApplicationController.getDocusign((string)a.id);
            
            Map<String,String> ap = new Map<String,String>();
            NewApplicationController.getApplicationInfo(ap);
            
            Contact n = new Contact();
            n.firstname='test';
            n.lastname='test';
            n.email='gmail@gmail.com';
            insert n;
            
            Map<String,String> setApp = new Map<String,String>();
            setApp.put('studentId',n.id);
            setApp.put('password','abcd1234');
            NewApplicationController.setApplicantPassword(setApp);
            
            Map<string, string> parentDetails = new Map<string, string>();
            parentDetails.put('studentId',n.id);
            parentDetails.put('studentParentLastName','jkfjdlks');
            parentDetails.put('studentParentFirstName','jkfjdlks');
            parentDetails.put('studentParentEmail','jkfjdlks@jhgjhghj.cuy');
            parentDetails.put('studentParentPhone','4562357895');
            NewApplicationController.parentInfo(parentDetails);
            
            Map<string, string> emContDetails = new Map<string, string>();
            emContDetails.put('studentId',n.id);
            NewApplicationController.emContInfo(emContDetails);
            
            Map<string, string> studentDetails = new Map<string, string>();
            studentDetails.put('prefStartPeriod','Jan 1 2020');
            studentDetails.put('studentId',n.id);
            NewApplicationController.checkApplication(studentDetails, a.id);
            
            NewApplicationController.createApplication(studentDetails, false, a.id);
            
            Map<string, string> programDetails = new Map<string, string>();
            programDetails.put('prefStartPeriod','Jan 01, 2020');
            programDetails.put('studentId',n.id);
            programDetails.put('applicationId',a.id);
            NewApplicationController.programInfo(programDetails, false);
            Test.StopTest();
        }
    } 
    @isTest static void testEducation() {
        NewApplicationController application = new NewApplicationController(); 
        insert con;
        Application__c testApp = new Application__c(
            student__c = con.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(con.Id);
        Map<string, string> educationMap = new Map<string, string>();
        educationMap.put('highSchoolName', 'none');
        educationMap.put('graduationDate' , '1976-01-11');
        educationMap.put('degreeReceived', 'none');
        educationMap.put('highSchoolAddress', 'none');
        educationMap.put('highSchoolZip', 'none');
        educationMap.put('highSchoolCounty', 'none');
        educationMap.put('applicationId', appId);
        NewApplicationController.educationInfo(educationMap);
        NewApplicationController.SaveEducationAndBackgroundInfo(educationMap);
        
        educationMap.put('highSchoolSelectedUsState', 'asdfs');
        educationMap.put('setPassword', 'test');
        NewApplicationController.educationInfo(educationMap);
        
        Map<string, string> collegeDetails = new Map<string, string>();
            collegeDetails.put('applicationId',testApp.id);
            
            NewApplicationController.collegeInfo(collegeDetails);
            
            NewApplicationController.getReferralInfo(con.id);
            NewApplicationController.getEmerContInfo(con.id);
            NewApplicationController.getParentInfo(con.id);
        
     
           
        Map<string, string> essayMap = new Map<string, string>();
            essayMap.put('applicationId', appId);
            essayMap.put('shortEssay', 'lkjflkjlk');
            essayMap.put('setPassword','');
            NewApplicationController.shortEssayInfo(essayMap);
  
            Map<string, string> previousHistoryDetails = new Map<string, string>();
            previousHistoryDetails.put('applicationId',testApp.id);
            previousHistoryDetails.put('criminalHistoryQuestion','Yes');
            previousHistoryDetails.put('educationHistoryQuestion','Yes');
            
            NewApplicationController.previousHistoryInfo(previousHistoryDetails);
            
        	previousHistoryDetails.put('criminalHistoryQuestion' , 'No');
            previousHistoryDetails.put('educationHistoryQuestion', 'No');
        	NewApplicationController.previousHistoryInfo(previousHistoryDetails);
        
            Map<string, string> statisticsDetails = new Map<string, string>();
            statisticsDetails.put('studentId',con.id);
            statisticsDetails.put('gender','Male');
            statisticsDetails.put('ethnicity','test');
            statisticsDetails.put('nationality','test');
            statisticsDetails.put('applicationId',testApp.id);
            NewApplicationController.statisticsInfo(statisticsDetails);
            
            NewApplicationController.acceptApp(testApp.id);
        
    }
    @isTest static void testDisable() {
        NewApplicationController application = new NewApplicationController(); 
        insert con;
        Application__c testApp = new Application__c(
            student__c = con.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(con.Id);
        Map<string, string> disableMap = new Map<string, string>();
        disableMap.put('applicationId', appId);
        disableMap.put('disabilityServicesQuestion', 'Yes, I will be requesting the use of auxiliary aids and/or services as described above.');        
        disableMap.put('disabilityServicesExplanation', 'asdfads');
        NewApplicationController.disabilityServicesInfo(disableMap); 
        
        disableMap.put('disabilityServicesQuestion', 'No');
        NewApplicationController.disabilityServicesInfo(disableMap);
       
    }
    @isTest static void testDoc() {
        NewApplicationController application = new NewApplicationController(); 
        insert con;
        Application__c testApp = new Application__c(
            student__c = con.Id            
        );    
        insert testApp;
        Contact emCont = new Contact(
            LastName = 'Jyes',
            FirstName = 'Jeck',
            Email = 'ajoedfw@ioj.com'
        );
        insert emCont;
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(con.Id);
        string emContId = string.valueOf(emCont.Id);
        Map<string,string> appMap = new Map<string,string>();
        appMap.put('applicationId', appId);
        appMap.put('studentId', studentId);
        
        NewApplicationController.updateUploads('I539', appId);
        
        NewApplicationController.updateUploads('College Transcripts', appId);
        
        NewApplicationController.updateUploads('Photo Id', appId);
        
        NewApplicationController.updateUploads('Computer Specs', appId);
        
      //  NewApplicationController.updateUploads('High School Diploma', appId);
        
        NewApplicationController.updateUploads('CCAF', appId);
        
        NewApplicationController.updateUploads('DD-214', appId);
        
        NewApplicationController.updateUploads('EntranceCounseling', appId);
        
        NewApplicationController.updateUploads('PLUSMasterPromissory', appId);
        NewApplicationController.updateUploads('parentTaxReturn', appId);
        NewApplicationController.updateUploads('parentTaxTranscripts', appId);
         NewApplicationController.updateUploads('spouseTaxReturn', appId);
         NewApplicationController.updateUploads('studentTaxReturn', appId);
         NewApplicationController.updateUploads('studentTaxTranscripts', appId);
         NewApplicationController.updateUploads('ISIRCCode030', appId);
        // NewApplicationController.updateUploads('ISIRCCode030', appId);
        // NewApplicationController.updateUploads('defaultResolutionLetter', appId);
        // NewApplicationController.updateUploads('defaultResolutionLetter', appId);
        // NewApplicationController.updateUploads('wardOfCourtDoc', appId);
        
    }
     @isTest static void testDoc2() {
        NewApplicationController application = new NewApplicationController(); 
        insert con;
        Application__c testApp = new Application__c(
            student__c = con.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        
            NewApplicationController.updateUploads('TOEFL Scores', appId);
          	NewApplicationController.updateUploads('HSTransriptEvaluation', appId);
            NewApplicationController.updateUploads('Bank Statements', appId);
            NewApplicationController.updateUploads('hsDiploma', appId);
           // NewApplicationController.updateUploads('I-94', appId);
            NewApplicationController.updateUploads('collegeTranscript', appId);
            NewApplicationController.updateUploads('US Visa', appId);
            NewApplicationController.updateUploads('computerSpecs', appId);
            NewApplicationController.updateUploads('I-20', appId);
         	NewApplicationController.updateUploads('parentsPhotoID', appId);
            NewApplicationController.updateUploads('masterPromissoryNote', appId);
            NewApplicationController.updateUploads('Passport', appId);
         	NewApplicationController.updateUploads('i20', appId);
            NewApplicationController.updateUploads('I-539', appId);
            NewApplicationController.updateUploads('TOEFL', appId);
         	//NewApplicationController.updateUploads('USVisa', appId);
            NewApplicationController.updateUploads('bankStatementS', appId);
         	NewApplicationController.updateUploads('CCAF', appId);
            NewApplicationController.updateUploads('w2Form', appId);
         	//NewApplicationController.updateUploads('DD214', appId);
         	/* NewApplicationController.updateUploads('ISIRCCode030', appId);
         	NewApplicationController.updateUploads('ISIRCCode146', appId);
            NewApplicationController.updateUploads('defaultResolutionLetter', appId);
            NewApplicationController.updateUploads('legalGuardianshipDoc', appId);
         	NewApplicationController.updateUploads('dependencyOverrideStmt', appId);
            NewApplicationController.updateUploads('wardOfCourtDoc', appId);
            NewApplicationController.updateUploads('EntranceCounseling', appId);
            NewApplicationController.updateUploads('PLUSMasterPromissory', appId);
         	NewApplicationController.updateUploads('parentTaxReturn', appId);
            NewApplicationController.updateUploads('parentTaxTranscripts', appId);
            NewApplicationController.updateUploads('spouseTaxReturn', appId);
         	NewApplicationController.updateUploads('spouseTaxTranscript', appId);
         	NewApplicationController.updateUploads('studentTaxReturn', appId);
            NewApplicationController.updateUploads('studentTaxTranscripts', appId); */
    }
    @IsTest static void test2() {
        insert con;
        
        Application__c a = new Application__c();
        a.student__c=con.id;
        a.program_code__c='ASAP';
        insert a;
        
        Map<String,String> pdf = new Map<String,String>();
        pdf.put('studentId',con.id);
        pdf.put('applicationId',a.id);
        pdf.put('gender', 'test');
        pdf.put('ethnicity', 'test');
        pdf.put('nationality', 'test');
        pdf.put('friendFirstName', 'test');
        pdf.put('friendLastName', 'test');
        pdf.put('friendEmail', 'test@kjfkjdsfkjsd.cof');
        pdf.put('friendPhone', '3235556666');
        pdf.put('shortEssay', 'test');
        
        NewApplicationController.applicationFinalSubmit(pdf);
        pdf.put('gender', Null);
        pdf.put('ethnicity', Null);
        pdf.put('nationality', Null);
        NewApplicationController.applicationFinalSubmitSave(pdf);
        
        
        Application__c aa = new Application__c();
        aa.student__c=con.id;
        insert aa;
        
        Map<String,String> pdf2 = new Map<String,String>();
        pdf2.put('studentId',con.id);
        pdf2.put('applicationId',aa.id);
        NewApplicationController.savePdf(pdf2);
        Map<string, string> citizenDetails = new Map<string, string>();
        citizenDetails.put('studentId',con.id);
        citizenDetails.put('visaExpirationDate','2016-01-01');
        citizenDetails.put('residentialStatus','I am a citizen of the United States');
            
        NewApplicationController.citizenInfo(citizenDetails );
        
        citizenDetails.put('residentialStatus','I am a legal resident of the United States');
            
        NewApplicationController.citizenInfo(citizenDetails );
        citizenDetails.put('residentialStatus','I am an international student');
            
        NewApplicationController.citizenInfo(citizenDetails );
        
       
           
   }
    @ISTEST static void testMilitaryInfo(){
        insert con;
        Application__c aa = new Application__c();
        aa.student__c=con.id;
        insert aa;
       
        Map<String,String> militaryDetails = new Map<String,String>();
        militaryDetails.put('studentId',con.id);
        militaryDetails.put('applicationId',aa.id);
        militaryDetails.put('qualifyForBenefits','Yes');
        militaryDetails.put('authorizeTranscript','Yes');
        NewApplicationController.militaryInfo(militaryDetails);
       
        Map<String,String> mtryDetails = new Map<String,String>();
        mtryDetails.put('studentId',con.id);
        mtryDetails.put('applicationId',aa.id);
        NewApplicationController.militaryInfo(mtryDetails);
    }
   
    @IsTest static void testSavePayLater(){
        user s = [select id from user where usertype='guest' and isActive=true and name like '%application%'];
            system.runAs(s){
                Map<String,String> m = new Map<String,String>();
                Application__c a = [select id, student__c from application__c limit 1];
                m.put('studentId',a.student__c);
                m.put('studentDOB','2016-01-01');
                m.put('applicationId',a.id);
                m.put('residentialStatus','I am an international student');
                m.put('visaExpirationDate','2016-01-01');
                m.put('qualifyForBenefits','Yes');
                
                NewApplicationController.savePayLater(a.id,true);
            }
    }
    @IsTest static void TestPayment(){
               Account testAccount = new Account(
            Name ='acctest'
        ); 
        
        insert testAccount;
        
        Contact testContact= new Contact(
            
            FirstName ='test',
            LastName ='user',
            Phone ='987654345',
            AccountId = testAccount.Id,
            Email ='testuser343@gmail.com',
            MailingCountry='United States',
            MailingPostalCode='4567',
            MailingStreet='sdfgh',
            MailingCity='hyd',
            MailingState='iuytr'
            );
        insert testContact;
         
         List<Application__c> applist = new List<Application__c>();
         Application__c testApplication=New Application__c();
        testApplication.Student__c=testContact.id;
        testApplication.Program_Code__c='ASMP';
        testApplication.Pay_Later__c=true;
         insert testApplication;
         
         applist.add(testApplication);
         
         Test.startTest();
        NewApplicationController.getPaymentLink(testApplication.id);
         Test.stopTest();
    }
    @isTest static void testNumbers(){
        NewApplicationController.numberOnly('98997767676');
       
    }
  
    @isTest static void redirectPreviousMethods(){
        NewApplicationController NewAppCntl=new NewApplicationController();
        PageReference result=NewAppCntl.next();
        PageReference result1=NewAppCntl.previous();
        NewAppCntl.getCurrentPageNumber();
        NewAppCntl.getPrevRequired();
        NewAppCntl.getNextRequired();
        
    }  
    public static testmethod void testSaveSignature() {
        NewApplicationController NewAppCntl=new NewApplicationController();
         pageReference pager = page.TotalApplications;
        Test.setCurrentPage(pager);
        NewAppCntl.tryRedirectToLandingPage();
        
        insert con;
        Application__c testApp = new Application__c(
            student__c = con.Id            
        );    
        insert testApp; 
        
        NewApplicationController.echoSignListwrapper echo=new NewApplicationController.echoSignListwrapper();
       NewApplicationController.echoSignListwrapper echo1=new NewApplicationController.echoSignListwrapper(testApp.id,'test');
       NewApplicationController.echoSignListwrapper echo2=new NewApplicationController.echoSignListwrapper(testApp.id,'test','Out for Signature','test');
        Date strDate = Date.parse('12/15/15');
        NewApplicationController.echoSignListwrapper echo3=new NewApplicationController.echoSignListwrapper(testApp.id,'test','Out for Signature','test',strDate);
         
        NewApplicationController.echoSignListwrapper b=NewAppCntl.getPdfDocumentForApplication(testApp.id);
        NewApplicationController.echoSignListwrapper elw=new NewApplicationController.echoSignListwrapper();
        list<NewApplicationController.echoSignListwrapper> echlst=new list<NewApplicationController.echoSignListwrapper>();
        echlst.add(elw);
        Boolean echocntr=NewAppCntl.isDuplicate(echlst,elw);
        
   }
    public static testmethod void testRequestDoc(){
         NewApplicationController NewAppCntl=new NewApplicationController();
         list<NewApplicationController.echoSignListwrapper> echoSignlst=NewAppCntl.RequestedDocuments();
        
    }
    
    @IsTest static void testStudentInformation(){
        
        NewApplicationController application = new NewApplicationController();            
        String leadId;
        String attachId;
        String representativeId;
        String selecteduserId;           
        List<SelectOption> UserList;
        // Setup test data
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        User u = new User(
            Alias = 'standt', 
            Email='standt@mail.com',
            EmailEncodingKey='UTF-8', 
            LastName='Testing', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = p.Id, 
            Phone = '123-123-1234',
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='standt@mail.com'            
        );
        
        insert con;
        Application__c testApp = new Application__c(
            student__c = con.Id            
        );
        insert testApp;
        string appId = string.valueof(testApp.Id);        
        string studentId = string.valueof(con.Id);
        
        User testUser2 = new User(
            Email = 'test@mail.com',
            FirstName = 'Bob',
            LastName = 'Jones',
            Alias = 'bjones', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId =profile, 
            Phone = '123-123-1234',
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='test@mail.com',
            ContactId = con.Id
        );
        
        User us1=[select id from user where isActive=true limit 1];
        NewApplicationController.repInfo(us1.id);
        
        string repId = string.valueof(u.Id);
        
        MAP<string, string> studentMap = new Map<string, string>();
        studentMap.put('studentLastName','studentLastName');
        studentMap.put('studentFirstName','studentFirstName');
        studentMap.put('studentPhone','123-123-1234');
        studentMap.put('studentOtherPhone','123-123-1234');
        studentMap.put('studentEmail' , 'student@mail.com');        
        studentMap.put('MailingStreet' ,'studentHomeAddress');
        studentMap.put('MailingCity' , 'studentCity');
        studentMap.put('studentZip' ,'1234');
        studentMap.put('MailingCountry' ,'studentCountry'); 
        studentMap.put('representativeId', repId);          
        studentMap.put('studentDOB', '1976-01-01');
        studentMap.put('applicationId', appId);
        studentMap.put('studentId', studentId);   
         studentMap.put('qualifyForBenefits','Yes');
         studentMap.put('militaryStartDate','');
         studentMap.put('militaryEndDate','');
        studentMap.put('militaryETS','');
        studentMap.put('authorizeTranscript','Yes');
         studentMap.put('currentCertificate','Yes');
        studentMap.put('visaType','None');
        boolean isUnder24 = true;  
        
        Account as1 = new Account(name='Application Community');
        insert as1;
        NewApplicationController.studentInfo(studentMap, isUnder24);
        
        studentMap.put('studentSelectedUsState', 'asdf');         
        NewApplicationController.studentInfo(studentMap, isUnder24);  
        isUnder24 = false;       
        
        NewApplicationController.studentInfo(studentMap, isUnder24); 
        studentMap.put('representativeId', repId);  
        studentMap.put('studentId', null);
        studentMap.put('representativeId', null);
        studentMap.put('studentId', studentId);
        studentMap.put('applicationId', null);
        studentMap.put('prefStartPeriod','Jan 1 2020');
        studentMap.put('residentialStatus','I am a citizen of the United States');
        NewApplicationController.studentInfo(studentMap, isUnder24); 
        studentMap.put('residentialStatus','I am a legal resident of the United States');
        NewApplicationController.studentInfo(studentMap, isUnder24);
        studentMap.put('residentialStatus','I am an international student');
        NewApplicationController.studentInfo(studentMap, isUnder24); 
    }
    
}