@isTest(seeAllData=true)
public class TestApplicationController {
    public static  Contact testStudent = new Contact(
        FirstName = 'Bob',
        LastName = 'Jones',
        Phone = '654-654-6548',
        OtherPhone = '654-987-6548',
        MailingStreet = '123 main',
        MailingCity = 'Waukesha',
        MailingState = 'WI',
        //Birthdate = 1986/01/01,
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
        //Visa_Expiration_Date__c= 'test',
        Eligible_For_Military_Benefits__c = true,
        Affiliation__c = 'test',
        Military_Branch__c = 'test',
        Authorize__c = true,
        //Start_Date_of_Service__c = '1986/01/01',
        //End_Date_of_Service__c = '1986/01/01',
        Certificate_or_NOBE__c= true,
        Gender__c = 'test',
        Ethnicity__c = 'test',
        Nationality__c = 'test',
        Student_Info_Complete__c = true
    );
    public static Profile c = [SELECT Id FROM Profile WHERE Name='System Administrator'];
    public static User testUser = new User(
        Email = 'test@mail.com',
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
        ContactId = testStudent.Id
    );
    public static User adminUser = new User(
    	Email = 'testAdmin@mail.com',
        FirstName = 'Sally',
        LastName = 'Sallerson',
        Alias = 'ssall', 
        EmailEncodingKey='UTF-8', 
        LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', 
        ProfileId = c.Id, 
        Phone = '555-155-1234',
        TimeZoneSidKey='America/Los_Angeles', 
        UserName='testAdmin@mail.com'
    );
    public static Account testAccount = new Account(
    	Name = 'testAccount',
    	OwnerId = adminUser.Id
    );
    
    public static testMethod void parentTest() {
        ApplicationController application = new ApplicationController();
        insert testStudent;
        //insert adminUser;
        //insert testAccount;
        List<SelectOption> t1 = application.UserList;
        List<String> t2 = application.StartDateOptions;
  		User adminUser2 = new User(
            Email = 'testAdmin2@mail.com',
            FirstName = 'Sally2',
            LastName = 'Sallerson2',
            Alias = 'ssall2', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = c.Id, 
            Phone = '666-166-1234',
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='testAdmin2@mail.com'
        );
        insert adminUser2;
        Account testAccount2 = new Account(
            Name = 'testAccount2',
            OwnerId = adminUser2.Id
        );
        insert testAccount2;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;
        
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Contact testParent = new Contact(
            LastName = 'Jonsfes',
            FirstName = 'Jafdck',
            Email = 'adsf@lkj.com'
        );
        insert testParent;
        string testParentId = string.valueOf(testParent.Id);
        Test.StartTest();
        ApplicationController.getParentInfo(testParentId);
      	Test.StopTest();
        MAP<string, string> parentMap = new Map<string, string>();
            parentMap.put('studentParentLastName','studentParentLastName');
            parentMap.put('studentParentFirstName','studentParentFirstName');
            parentMap.put('studentParentPhone','123-123-1234');
            parentMap.put('studentParentEmail' , 'parent@mail.com');        
            parentMap.put('applicationId', appId);
        	parentMap.put('householdId', testAccount2.Id);
     	//Test.startTest();
     	ApplicationController.getDocusign(appId);
     	ApplicationController ac = new ApplicationController();
     	System.runAs(adminUser2){
     		ApplicationController.getStudentInfo();
     		PageReference pageRef = new PageReference('/apex/Application');
     		Test.setCurrentPage(pageRef);
     		ac.chkLogIn();
     	}
     	User use=[select id from user where profileid='00e1a000000IzWx' and isActive=true limit 1];
     	System.runAs(use){
     		PageReference pageRef = new PageReference('/apex/Application');
     		Test.setCurrentPage(pageRef);
     		ac.chkLogIn();
     	}
        ApplicationController.parentInfo(parentMap);
     	//Test.StopTest();
     		parentMap.put('studentId', studentId);
            parentMap.put('parentId', testParentId);
            parentMap.put('studentParentLastName','studentPdgharentLastName');
            parentMap.put('studentParentFirstName','studentParendfghtFirstName');
            parentMap.put('studentParentEmail' , 'parent1@mail.com');
		//Test.startTest();
        ApplicationController.parentInfo(parentMap);
        //Test.StopTest();
  
    }
    @isTest
    public static void emContTest() {
        ApplicationController application = new ApplicationController();
        insert testStudent;
        //insert adminUser;
        //insert testAccount;
        //
     	User adminUser2 = new User(
            Email = 'testAdmin2@mail.com',
            FirstName = 'Sally2',
            LastName = 'Sallerson2',
            Alias = 'ssall2', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = c.Id, 
            Phone = '666-166-1234',
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='testAdmin2@mail.com'
        );
        insert adminUser2;
        Account testAccount2 = new Account(
            Name = 'testAccount2',
            OwnerId = adminUser2.Id
        );
        insert testAccount2;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;
        Contact emCont = new Contact(
            LastName = 'Jonrtyes',
            FirstName = 'Jatryeck',
            Email = 'asdfw@ioj.com'
        );
        insert emCont;
        string emContId = string.valueOf(emCont.Id);
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);  
        //Test.StartTest();
        ApplicationController.getEmerContInfo(emContId);
        //Test.stopTest();
        MAP<string, string> emContMap = new Map<string, string>();
        	emContMap.put('studentId',studentId);
            emContMap.put('emContLastName','LastfghjName');
            emContMap.put('emContFirstName','FirstdghName');
            emContMap.put('emContPhone','123-423-1234');
            emContMap.put('emContEmail' , 'emCont@mail.com');       
            emContMap.put('applicationId', appId);
        	emContMap.put('householdId', testAccount2.Id);
        /*MAP<string, string> emContMap2 = new Map<string, string>();
            emContMap.put('emContLastName','LasdsstfghjName');
            emContMap.put('emContFirstName','FirstdghName');
            emContMap.put('emContPhone','423-423-1234');
            emContMap.put('emContEmail' , 'emCont@maifddl.com');        
            emContMap.put('applicationId', appId);*/
            emContMap.put('emContFirstName','Firme');
            emContMap.put('emContPhone','173-423-1234');
            emContMap.put('emContLastName','Lastame');
        //Test.startTest();
        ApplicationController.emContInfo(emContMap);
        //Test.stopTest();
            emContMap.put('emContId', emContId);
            emContMap.put('emContFirstName','Fiqqqrme');
            emContMap.put('emContPhone','173-823-1244');
            emContMap.put('emContLastName','Lauiestame');
        //Test.startTest();
        ApplicationController.emContInfo(emContMap);
               
        //Test.StopTest();
    }
     @isTest
    public static void referTest2(){
        ApplicationController application = new ApplicationController();
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;
        
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        User adminUser4 = new User(
            Email = 'testAdmin@mail.com',
            FirstName = 'Sally',
            LastName = 'Sallerson',
            Alias = 'ssall', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = c.Id, 
            Phone = '555-155-1234',
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='testAdmin@mail.com'
        );
        insert adminUser4;
        Account testAccount4 = new Account(
            Name = 'testAccount',
            OwnerId = adminUser4.Id
        );
        insert testAccount4;
        Contact refer = new Contact(
            LastName = 'Joeenesqw',
            FirstName = 'Jacker',
            Email = 'testrefer5@mail.com'
        );
        insert refer;
        string referId = string.valueOf(refer.Id);
         Map<string, string> referMap = new Map<string, string>();
         	referMap.put('studentId', studentId);
            referMap.put('applicationId', appId);
            referMap.put('referFriendQuestion', 'Yes');
            referMap.put('friendLastName', 'asdf');
            referMap.put('friendFirstName', 'appId');
            referMap.put('friendPhone', 'asdf');
            referMap.put('friendEmail', 'fasd@mail.com');
            referMap.put('friendOther', 'asdfsad');
            referMap.put('referralId', null);
        	referMap.put('householdId', testAccount4.Id);
        
        //Test.startTest();
        ApplicationController.referFriendInfo(referMap);
        //Test.stoptest(); 
            referMap.put('friendEmail', 'fasd@mairl.com');
            referMap.put('friendFirstName', 'apaaapId');
            referMap.put('friendLastName', null);
		//Test.startTest();
       ApplicationController.referFriendInfo(referMap);
		//Test.stopTest();
            referMap.put('friendLastName', 'asaaadsfdf');
            referMap.put('friendFirstName', 'apsdfsfpId');
            referMap.put('friendEmail', null);
 
       //Test.startTest();
       ApplicationController.referFriendInfo(referMap);
	   //Test.stoptest();
            referMap.put('friendLastName', 'asd211f');
            referMap.put('friendEmail', 'fasdesd@mairl.com');
            referMap.put('friendFirstName', null);

       //Test.startTest();
       ApplicationController.referFriendInfo(referMap);
	   //Test.stopTest();
            referMap.put('friendLastName', 'asaasdffdf');
            referMap.put('friendFirstName', 'aaaappId');
            referMap.put('friendEmail', 'fasdesd@maiaserl.com');
            referMap.put('friendPhone', null);

       //Test.startTest();
       ApplicationController.referFriendInfo(referMap);
       //Test.stopTest();
    }
    @isTest
    public static void referTest(){
        
        ApplicationController application = new ApplicationController();
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;
        
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        
        User adminUser3 = new User(
            Email = 'testAdmin@mail.com',
            FirstName = 'Sally',
            LastName = 'Sallerson',
            Alias = 'ssall', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = c.Id, 
            Phone = '555-155-1234',
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='testAdmin@mail.com'
        );
        insert adminUser3;
        Account testAccount3 = new Account(
            Name = 'testAccount',
            OwnerId = adminUser3.Id
        );
        insert testAccount3;
        
        
        Contact refer = new Contact(
            LastName = 'Jonesqw',
            FirstName = 'Jacker',
            Email = 'refertest4@mail.com'
        );
        insert refer;
        string referId = string.valueOf(refer.Id);
        //Test.StartTest();
            ApplicationController.getReferralInfo(referId);
   		//Test.StopTest();
        Map<string, string> referMap = new Map<string, string>();
            referMap.put('applicationId', appId);
            referMap.put('referFriendQuestion', 'Yes');
            referMap.put('friendLastName', 'asdf');
            referMap.put('friendFirstName', 'appId');
            referMap.put('friendPhone', 'asdf');
            referMap.put('friendEmail', 'fasd@mail.com');
            referMap.put('friendOther', 'asdfsad');
            referMap.put('referralId', null);
        	referMap.put('householdId', testAccount3.Id);
  
       //Test.startTest();
       ApplicationController.referFriendInfo(referMap); 
		//Test.StopTest();
            referMap.put('friendLastName', 'areesdf');
            referMap.put('friendFirstName', 'apperId');
            referMap.put('referFriendQuestion', 'No');
 
       
       //Test.startTest();
       ApplicationController.referFriendInfo(referMap);
		//Test.StopTest();
            referMap.put('friendLastName', 'asasdfdf');
            referMap.put('friendFirstName', 'ap2322pId');
            referMap.put('friendEmail', 'fasdfsd@mail.com');
            referMap.put('referFriendQuestion', 'Yes');
            referMap.put('referralId', referId);

       //Test.startTest();
       ApplicationController.referFriendInfo(referMap);

            referMap.put('friendLastName', 'asaddsdf');
            referMap.put('friendFirstName', 'apaaapId');
            referMap.put('friendOther', null);
 		//Test.startTest();
       ApplicationController.referFriendInfo(referMap);

       //Test.StopTest();
    }
    
    @isTest
    public static void test3() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;
        Contact emCont = new Contact(
            LastName = 'Jonrtyes',
            FirstName = 'Jatryeck',
            Email = 'asdfw@ioj.com'
        );
        insert emCont;
        string emContId = string.valueOf(emCont.Id);       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string,string>appMap = new Map<string,string>();
            appMap.put('applicationId', appId);
            appMap.put('studentId', studentId);
            appMap.put('emContId', emContId);
       //Test.StartTest();
            //ApplicationController.savePdf(appMap);

            
       //Test.StopTest();
    }
    @isTest
    public static void testEducation() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string, string> educationMap = new Map<string, string>();
            educationMap.put('highSchoolName', 'none');
            educationMap.put('graduationDate' , '1976-01-11');
            educationMap.put('degreeReceived', 'none');
            educationMap.put('highSchoolAddress', 'none');
            educationMap.put('highSchoolZip', 'none');
            educationMap.put('highSchoolCounty', 'none');
            educationMap.put('applicationId', appId);
        //Test.StartTest();
            ApplicationController.educationInfo(educationMap);
            //Test.StopTest();
            //Test.startTest();
            educationMap.put('highSchoolSelectedUsState', 'asdfs');
            ApplicationController.educationInfo(educationMap);
        //Test.StopTest();
    }
    @isTest
    public static void testCollege() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string, string> collegeMap = new Map<string, string>();
            collegeMap.put('college1Name', 'none');
            collegeMap.put('college1GraduationDate', '1976-01-11');
            collegeMap.put('college2GraduationDate', '1976-01-11');
            collegeMap.put('college1DegreeReceived', 'none');
            collegeMap.put('college2Name', 'none');
            collegeMap.put('college2DegreeReceived', 'none');
            collegeMap.put('collegeNotes', 'kjlkjl');
            collegeMap.put('applicationId', appId);
        //Test.StartTest();
        ApplicationController.collegeInfo(collegeMap);
        //Test.StopTest();
    }
    @isTest
    public static void testCitizen() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string, string>citizenMap = new Map<string, string>();
            citizenMap.put('residentialStatus', 'I am a citizen of the United States');
            citizenMap.put('studentId', studentId);
            citizenMap.put('ssNumber', '555');
            citizenMap.put('alienNumber' , '565');
            citizenMap.put('applicationId', appId);
            citizenMap.put('countryOfCitizenship', 'none');
            citizenMap.put('visaType', 'none');
            citizenMap.put('visaSchoolName', 'none');
            citizenMap.put('visaSchoolAddress', 'none');
            citizenMap.put('visaSchoolCity', 'none');
            citizenMap.put('visaSchoolState', 'none');
            citizenMap.put('visaSchoolCountry', 'none');
            citizenMap.put('visaExpirationDate', '1968-01-01') ;       
        //Test.StartTest();
            ApplicationController.citizenInfo(citizenMap);
            //Test.StopTest();
            citizenMap.put('residentialStatus', 'I am an international student');           
            
            //Test.StartTest();
            ApplicationController.citizenInfo(citizenMap);
            //Test.StopTest();
            citizenMap.put('residentialStatus', 'I am a legal resident of the United States');
            
            //Test.StartTest();
            ApplicationController.citizenInfo(citizenMap);
        //Test.StopTest();
    }
    @isTest
    public static void testMilitary() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string, string>militaryMap = new Map<string, string>();
            militaryMap.put('studentId', studentId);
            militaryMap.put('applicationId', appId);
            militaryMap.put('militaryStartDate', '1976-01-01');
            militaryMap.put('militaryEndDate', '1976-01-01');
            militaryMap.put('authorizeTranscript', 'Yes');
            militaryMap.put('qualifyForBenefits', 'Yes');
            militaryMap.put('branchOfService', 'Navy');
            militaryMap.put('currentCertificate', 'Yes');
        //Test.StartTest();
            ApplicationController.militaryInfo(militaryMap);
           //Test.StopTest();
            militaryMap.put('authorizeTranscript', 'No');
            militaryMap.put('currentCertificate', 'No');
            //Test.StartTest();
            ApplicationController.militaryInfo(militaryMap); 
            //Test.StopTest();
            militaryMap.put('qualifyForBenefits', 'No');
            //Test.StartTest();
            ApplicationController.militaryInfo(militaryMap);
            //Test.StopTest();
        Map<string, string> essayMap = new Map<string, string>();
            essayMap.put('applicationId', appId);
            essayMap.put('shortEssay', 'lkjflkjlk');
            //Test.StartTest();
            ApplicationController.shortEssayInfo(essayMap);
        //Test.StopTest();
    }
    @isTest
    public static void testBackground() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string, string> historyMap = new Map<string, string>();
            historyMap.put('applicationId', appId);
            historyMap.put('criminalHistoryQuestion' , 'Yes');
            historyMap.put('criminalHistoryExplain', 'ashdf');
            historyMap.put('educationHistoryQuestion', 'Yes');
            historyMap.put('educationHistoryExplain', 'asdfas');
        //Test.startTest();
        ApplicationController.previousHistoryInfo(historyMap);
        //Test.StopTest();
            historyMap.put('criminalHistoryQuestion' , 'No');
            historyMap.put('educationHistoryQuestion', 'No');
        //Test.startTest();
        ApplicationController.previousHistoryInfo(historyMap); 
        //Test.stopTest();
        
    }
    @isTest
    public static void testDisability() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
         Map<string, string> disableMap = new Map<string, string>();
            disableMap.put('applicationId', appId);
            disableMap.put('disabilityServicesQuestion', 'Yes, I will be requesting the use of auxiliary aids and/or services as described above.');        
            disableMap.put('disabilityServicesExplanation', 'asdfads');
        //Test.startTest();
        ApplicationController.disabilityServicesInfo(disableMap); 
            //Test.stopTest();
            disableMap.put('disabilityServicesQuestion', 'No');
        //Test.startTest();
        ApplicationController.disabilityServicesInfo(disableMap);
        //Test.stopTest();
    }
    @isTest
    public static void testStats() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string, string> statMap  = new Map<string, string>();
            statMap.put('applicationId', appId);
            statMap.put('studentId', studentId);
            statMap.put('gender', 'asda');
            statMap.put('ethnicity', 'asdf');
            statMap.put('nationality', 'asdf');
        //Test.startTest();
        ApplicationController.statisticsInfo(statMap);
        //Test.stopTest();
            statMap.put('gender', null);
            statMap.put('ethnicity', null);
            statMap.put('nationality', null);
        //Test.startTest();
        ApplicationController.statisticsInfo(statMap); 
        //Test.stopTest();
    }
    @isTest
    public static void testProgram() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string, string> programMap = new Map<string,string>();
            programMap.put('applicationId', appId);
            programMap.put('prefStartDate', '1976-01-01');
            programMap.put('studentId', studentId);
            programMap.put('programCode', 'asdf');
       Boolean hasNoComputer = true;
       //Test.startTest();
       ApplicationController.programInfo(programMap, hasNoComputer);
       //Test.stopTest();
       hasNoComputer = false;
       //Test.startTest();
       ApplicationController.programInfo(programMap, hasNoComputer);
       //Test.stopTest();
       //Test.startTest();
       ApplicationController.acceptApp(appId);
       //Test.stopTest();
    }
    @isTest
    public static void testRunAs() {
        ApplicationController application = new ApplicationController();            
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

        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );
        insert testApp;
        string appId = string.valueof(testApp.Id);        
        string studentId = string.valueof(testStudent.Id);
        
        User testUser2 = new User(
            Email = 'test@mail.com',
            FirstName = 'Bob',
            LastName = 'Jones',
            Alias = 'bjones', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = c.Id, 
            Phone = '123-123-1234',
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='test@mail.com',
            ContactId = testStudent.Id
        );
        //Test.StartTest();
            ApplicationController.getApplicationInfo(studentId);
            User us1=[select id from user where isActive=true limit 1];
            ApplicationController.repInfo(us1.id);
        //Test.stopTest();
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
        boolean isUnder24 = true;  
        //Test.startTest();
        	Account as1 = new Account(name='Application Community');
        	insert as1;
            ApplicationController.studentInfo(studentMap, isUnder24);
        //Test.StopTest();       
        studentMap.put('studentSelectedUsState', 'asdf');       
        //Test.startTest();
            ApplicationController.studentInfo(studentMap, isUnder24);       
        //Test.StopTest();
        isUnder24 = false;       
        //Test.startTest();
            ApplicationController.studentInfo(studentMap, isUnder24);      
        //Test.StopTest();

        studentMap.put('representativeId', repId);           
        //Test.startTest();
            ApplicationController.createApplication(studentMap, isUnder24);
        //Test.StopTest();
        studentMap.put('studentId', null);
        studentMap.put('representativeId', null);
        //Test.startTest();
            //ApplicationController.createApplication(studentMap, isUnder24);
        //Test.StopTest();
        studentMap.put('studentId', studentId);
        studentMap.put('applicationId', null);
        //Test.startTest();
            //ApplicationController.createApplication(studentMap, isUnder24);
        //Test.StopTest();  
    }
    @isTest
    public static void testStat() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string, string> statMap  = new Map<string, string>();
            statMap.put('applicationId', appId);
            statMap.put('studentId', studentId);
            statMap.put('gender', 'asda');
            statMap.put('ethnicity', 'asdf');
            statMap.put('nationality', 'asdf');
        //Test.startTest();
        ApplicationController.statisticsInfo(statMap);
        //Test.StopTest();
            statMap.put('gender', null);
            statMap.put('ethnicity', null);
            statMap.put('nationality', null);
        //Test.startTest();
        ApplicationController.statisticsInfo(statMap);
        //Test.StopTest();
    }
    @isTest
    public static void testProgram2() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string, string> programMap = new Map<string,string>();
            programMap.put('applicationId', appId);
            programMap.put('prefStartDate', '1976-01-01');
            programMap.put('studentId', studentId);
            programMap.put('programCode', 'asdf');
       Boolean hasNoComputer = true;
       //Test.startTest();
           ApplicationController.programInfo(programMap, hasNoComputer);
       //Test.stopTest();
       //Test.startTest();
       ApplicationController.acceptApp(appId);
       //Test.stopTest();
    }
    @isTest
    public static void testDisable() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        Map<string, string> disableMap = new Map<string, string>();
            disableMap.put('applicationId', appId);
            disableMap.put('disabilityServicesQuestion', 'Yes, I will be requesting the use of auxiliary aids and/or services as described above.');        
            disableMap.put('disabilityServicesExplanation', 'asdfads');
        //Test.startTest();
            ApplicationController.disabilityServicesInfo(disableMap);
            //Test.stopTest(); 
                disableMap.put('disabilityServicesQuestion', 'No');
           //Test.startTest();
            ApplicationController.disabilityServicesInfo(disableMap);
        //Test.stopTest();
    }
    @isTest
    public static void testRunAs2() {
        ApplicationController application = new ApplicationController();            
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

        insert testStudent;
        
        User testUser2 = new User(
            Email = 'test@mail.com',
            FirstName = 'Bob',
            LastName = 'Jones',
            Alias = 'bjones', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = c.Id, 
            Phone = '123-123-1234',
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='test@mail.com',
            ContactId = testStudent.Id
        );
        
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;
        string appId = string.valueof(testApp.Id);        
        string studentId = string.valueof(testStudent.Id); 
        User adminUser8 = new User(
            Email = 'testAdmin@mail.com',
            FirstName = 'Sally',
            LastName = 'Sallerson',
            Alias = 'ssall', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = c.Id, 
            Phone = '555-155-1234',
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='testAdmin@mail.com'
        );
        insert adminUser8;
        Account testAccount8 = new Account(
            Name = 'testAccount',
            OwnerId = adminUser8.Id
        );
        insert testAccount8;
        Contact refer = new Contact(
            LastName = 'Joeenesqw',
            FirstName = 'Jacker',
            Email = 'testrefer8@mail.com'
        );
        /*Contact refer = new Contact(
            LastName = 'Jonesqw',
            FirstName = 'Jacker'
        );*/
        insert refer;
        string referId = string.valueOf(refer.Id);
        Map<string, string> referMap = new Map<string, string>();
            referMap.put('applicationId', appId);
            referMap.put('referFriendQuestion', 'Yes');
            referMap.put('friendLastName', 'asdf');
            referMap.put('friendFirstName', 'appId');
            referMap.put('friendPhone', 'asdf');
            referMap.put('friendEmail', 'fasd@mail.com');
            referMap.put('friendOther', 'asdfsad');
            referMap.put('referralId', null);
        	referMap.put('householdId', testAccount8.Id);
       //Test.startTest();
           ApplicationController.referFriendInfo(referMap); 
           //Test.stopTest();
                referMap.put('friendLastName', 'areesdf');
                referMap.put('friendFirstName', 'apperId');
                referMap.put('referFriendQuestion', 'No');
           //Test.startTest();
           ApplicationController.referFriendInfo(referMap);
           //Test.stopTest();
                referMap.put('friendLastName', 'asasdfdf');
                referMap.put('friendFirstName', 'ap2322pId');
                referMap.put('friendEmail', 'fasdfsd@mail.com');
                referMap.put('referFriendQuestion', 'Yes');
                referMap.put('referralId', referId);
           //Test.startTest();
           ApplicationController.referFriendInfo(referMap);
           //Test.stopTest();
                referMap.put('friendLastName', 'asaddsdf');
                referMap.put('friendFirstName', 'apaaapId');
                referMap.put('friendOther', null);
           //Test.startTest();
           ApplicationController.referFriendInfo(referMap);
           //Test.stopTest(); 
                referMap.put('friendLastName', 'asdaaaf');
                referMap.put('friendFirstName', 'apaaapId');
                referMap.put('friendLastName', null);
           //Test.startTest();
           ApplicationController.referFriendInfo(referMap); 
           //Test.stopTest();
                referMap.put('friendLastName', 'asaaadsfdf');
                referMap.put('friendFirstName', 'apsdfsfpId');
                referMap.put('friendEmail', null);
            //Test.startTest();
            ApplicationController.referFriendInfo(referMap);
            //Test.stopTest();
                referMap.put('friendLastName', 'asd211f');
                referMap.put('friendFirstName', 'appIwsasd');
                referMap.put('friendFirstName', null);
            //Test.startTest();
            ApplicationController.referFriendInfo(referMap);
            //Test.stopTest(); 
                referMap.put('friendLastName', 'asaasdffdf');
                referMap.put('friendFirstName', 'aaaappId');
                referMap.put('friendPhone', null);
            //Test.startTest();
            ApplicationController.referFriendInfo(referMap); 
       //Test.stopTest();
    }
    @isTest
    public static void testDoc() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;
        Contact emCont = new Contact(
            LastName = 'Jyes',
            FirstName = 'Jeck',
            Email = 'ajoedfw@ioj.com'
        );
        insert emCont;
        string appId = string.valueof(testApp.Id);
        string studentId = string.valueof(testStudent.Id);
        string emContId = string.valueOf(emCont.Id);
        Map<string,string>appMap = new Map<string,string>();
            appMap.put('applicationId', appId);
            appMap.put('studentId', studentId);
            appMap.put('emContId', emContId);
       //Test.startTest();
           //ApplicationController.savePdf(appMap);
           //Test.stopTest();
           
           //Test.startTest();
           ApplicationController.updateUploads('I539', appId);
           //Test.stopTest();
           //Test.startTest();
           ApplicationController.updateUploads('College Transcripts', appId);
           //Test.stopTest();
           //Test.startTest();
           ApplicationController.updateUploads('Photo Id', appId);
           //Test.stopTest();
           //Test.startTest();
           ApplicationController.updateUploads('Computer Specs', appId);
           //Test.stopTest();
           //Test.startTest();
           ApplicationController.updateUploads('High School Diploma', appId);
           //Test.stopTest();
           //Test.startTest();
           ApplicationController.updateUploads('CCAF', appId);
           //Test.stopTest();
           //Test.startTest();
           ApplicationController.updateUploads('DD-214', appId);
       //Test.stopTest();
    }
    @isTest
    public static void testDoc2() {
        ApplicationController application = new ApplicationController(); 
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id            
        );    
        insert testApp;       
        string appId = string.valueof(testApp.Id);
        //Test.startTest();
            ApplicationController.updateUploads('TOEFL Scores', appId);
            //Test.stopTest();
            //Test.startTest();
            ApplicationController.updateUploads('Bank Statements', appId);
            //Test.stopTest();
            //Test.startTest();
            ApplicationController.updateUploads('I-94', appId);
            //Test.stopTest();
            //Test.startTest();
            ApplicationController.updateUploads('US Visa', appId);
            //Test.stopTest();           
            //Test.startTest();
            ApplicationController.updateUploads('I-20', appId);
            //Test.stopTest();
            //Test.startTest();
            ApplicationController.updateUploads('Passport', appId);
        //Test.stopTest();
        
    }
}