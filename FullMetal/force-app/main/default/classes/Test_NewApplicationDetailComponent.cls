@isTest(SeeAllData=false)

private class Test_NewApplicationDetailComponent {
    @isTest  static void ApplicationDetail(){
        
        Account testAccount = new Account( Name ='acctest'
                                         );
        insert testAccount;
        
        Contact testContact= new Contact(FirstName ='Test',
                                         LastName ='User',
                                         Phone ='9389378344',
                                         OtherPhone ='8878777654',
                                         AccountId = testAccount.Id,
                                         Email ='testuserma@gmail.com',
                                         Birthdate=Date.newInstance(2019, 12, 9),
                                         Visa_Expiration_Date__c=Date.newInstance(2029, 10, 9),
                                         Start_Date_of_Service__c=Date.newInstance(2019, 10, 23),
                                         End_Date_of_Service__c=Date.newInstance(2019, 12, 29),
                                         ETS_EAS__c=Date.newInstance(2020, 12, 29),
                                         Ethnicity__c='American Indian or Alaskan Native',
                                         Gender__c='Female',
                                         Country_of_Citizenship__c = 'london',
                                         Program_Consideration__c='ytrtgf',
                                         Nationality__c='Albanian',
                                         MailingState = 'kjhgfd',
                                         MailingCountry='United States',
                                         Referral_First_Name__c='',
                                         Referral_Last_Name__c='',
                                         Referral_Email__c='',
                                         Referral_Phone__c=''
                                         //Program_Code__c='ASMP-O'
                                        );
        insert testContact;
        system.debug('contid:'+testContact.id);
        
        
        Id newprofile = [select id from Profile where name='Application User'].id;
        
        user u= new user(LastName ='test1',
                         FirstName ='test2',
                         Email ='gayathri.aila@gmail.com',
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
        
        //u.IsPortalEnabled=true;
        insert u;
        
        system.debug('user:'+u.Id);
        system.debug('userportal:'+u.IsPortalEnabled);
        
        Application__c testapp=new Application__c(Student__c=testContact.id,
                                                  Program_Code__c='',
                                                  //Program_Version__c='',
                                                  Application_Status__c='Denied',
                                                  //Application_Status__c='Submitted',
                                                  Stage__c=3,
                                                  Short_Essay__c='hello',
                                                  High_School_State__c = '',
                                                  High_School_Country__c='United States',
                                                  //High_School_State__c = 'kjhgfd',
                                                  HS_Graduation_Date__c=Date.newInstance(2019, 12, 11),
                                                  College_1_Graduation_Date__c=Date.newInstance(2019, 11, 25),
                                                  College_2_Graduation_Date__c=Date.newInstance(2019, 10, 28)
                                                 );
        testapp.Program_Version__c='';
        testapp.Application_Finalized__c=true;
        testapp.HS_Diploma_Received__c='Requested';
        testapp.App_Finalized_Date__c=Datetime.Now();
        insert testapp;
        system.debug('stage:'+testapp.Stage__c); 
        system.debug('applid:'+testapp.Student__c);
        
        
        
        Campus_Option__c testcamp=new Campus_Option__c( Name='Online'
                                                      );
        insert testcamp;
        
        Program_Option__c testprogopt=new Program_Option__c( Name = 'Bachelor of Science in Animation Online',
                                                            Campus_Option__c =testcamp.id,
                                                            Program_Code__c = 'ASGP'
                                                           );
        insert testprogopt;
        
        Program_Concentration__c testprogconcen=new Program_Concentration__c(Name = 'Visual Effects',
                                                                             Program_Option__c = testprogopt.id
                                                                            );
        insert testprogconcen;
        
        Test.startTest();
        NewApplicationDetailComponentController appdetcomp = new NewApplicationDetailComponentController();
        
        appdetcomp.isgobacktosummary=true;
        appdetcomp.isCampusCheck=false;
        appdetcomp.selectedVal='done';
        appdetcomp.birthDate='1996/10/9';
        appdetcomp.militaryStartDate='2017/10/22';
        appdetcomp.militaryEndDate='2019/10/19';
        appdetcomp.visaExpDate='2022/12/23';
        appdetcomp.estimationDate='2021/10/9';
        appdetcomp.graduationDate='2022/11/7';
        appdetcomp.collegeGraduationDate1='2022/11/9';
        appdetcomp.collegeGraduationDate2='2022/11/19';
        
        appdetcomp.hiddenPhoneFirst='fgdg';
        appdetcomp.hiddenPhoneAlt='jhgrtg';
        appdetcomp.hiddenPhoneFriend='cvfdf';
        appdetcomp.hiddenPhoneEmrg='rtyhf';
        
        appdetcomp.std=True;
        appdetcomp.statePickList=False;
        appdetcomp.stateInput=False;
        appdetcomp.frdsinfo='No';
        
        appdetcomp.CampusOption=null;
        appdetcomp.checkpgmconsideration=false;
        appdetcomp.prefereddate='werty';
        List<SelectOption> selOpts=appdetcomp.Programoptions;
        List<SelectOption> selOpts1=appdetcomp.Programconsiderations;
        
        PageReference ref = new PageReference('/apex/NewTotalApplications');
        Test.setCurrentPage(ref);
        
        PageReference pageRef = new PageReference('/apex/newApplicationDetail');
        pageRef.getParameters().put('appId',testapp.id);
        Test.setCurrentPage(pageRef);
        NewApplicationDetailComponentController abc =  appdetcomp.getCommonData();
        //NewApplicationDetailComponentController.getCommonData();
        if( appdetcomp.recordContact == NULL ) {
            appdetcomp.recordContact = new Contact();
        }
        if( appdetcomp.recordApplication == NULL ) {
            appdetcomp.recordApplication = new Application__c();
        }
        
        system.debug('rec&appid:'+appdetcomp.recordApplication.id);
        if( appdetcomp.attch == NULL ) {
            appdetcomp.attch = new Attachment();
        }
        
        appdetcomp.initializeComponent();
        
        appdetcomp.changeconsentration();
        
        appdetcomp.checkCampusOptionEnabledOrDisabled();
        appdetcomp.goBackToSumary();
        appdetcomp.updateFrienddetails();
        appdetcomp.countryusUpdate();
        
        
        system.debug('rec&contid:'+appdetcomp.recordContact.id);
        appdetcomp.countryusUpdates();
        
        
        
        appdetcomp.updateContactAndAppsavenfinish();
        
        appdetcomp.updateContactWithApplication();
        
        appdetcomp.updateContactAndApponAcceptandSubmit();
        
        appdetcomp.goNextNoSave();
        appdetcomp.setMessage('page','pageMessage');
        appdetcomp.covertDateFormat();
        
        appdetcomp.redirectToPreviousPage();
        
        //appdetcomp.goBackToSummaryDiplay();
        
        
        NewApplicationDetailComponentController.strToDate('dateString');
        NewApplicationDetailComponentController.doUploadAttachment('appId', 'attachmentBody', 'attachmentName', 'attachmentId');
        
        List<SelectOption> selOpts2=appdetcomp.StartDateOptions;
        Test.StopTest();
        
    }
    @isTest  static void ApplicationDetail1(){
        
        Account testAccount = new Account( Name ='acctest'
                                         );
        insert testAccount;
        
        Contact testContact1= new Contact(FirstName ='Test1',
                                          LastName ='User1',
                                          Phone ='9389378343',
                                          OtherPhone ='8878777653',
                                          AccountId = testAccount.Id,
                                          Email ='testuserma@gmail.com',
                                          Birthdate=Date.newInstance(2019, 12, 9),
                                          Visa_Expiration_Date__c=Date.newInstance(2029, 10, 9),
                                          Start_Date_of_Service__c=Date.newInstance(2019, 10, 23),
                                          End_Date_of_Service__c=Date.newInstance(2019, 12, 29),
                                          ETS_EAS__c=Date.newInstance(2020, 12, 29),
                                          Ethnicity__c='American Indian or Alaskan Native',
                                          Gender__c='Female',
                                          Country_of_Citizenship__c = 'United States',
                                          Program_Consideration__c='ytrtgf',
                                          Nationality__c='Albanian',
                                          MailingState = 'kjhgfd',
                                          MailingCountry='United States',
                                          Referral_First_Name__c='',
                                          Referral_Last_Name__c='',
                                          Referral_Email__c='',
                                          Referral_Phone__c=''
                                          //Program_Code__c='ASMP-O'
                                         );
        insert testContact1;
        
        
        Id newprofile = [select id from Profile where name='Application User'].id;
        
        user u= new user(LastName ='test1',
                         FirstName ='test2',
                         Email ='testuserma@gmail.com',
                         Alias ='tvjd',
                         Username = 'jason@banana.com',
                         CommunityNickname = 'dsfgh',
                         ProfileId = newprofile,
                         ContactId = testContact1.id,
                         TimeZoneSidKey = 'GMT',
                         LanguageLocaleKey = 'en_US',
                         EmailEncodingKey = 'UTF-8',
                         LocaleSidKey = 'en_US'
                         
                        );
        
        //u.IsPortalEnabled=true;
        insert u;
        
        system.debug('user:'+u.Id);
        system.debug('userportal:'+u.IsPortalEnabled);
        system.debug('--testContact1' +testContact1.Email);
        Application__c testapp1=new Application__c(Student__c=testContact1.id,
                                                   Program_Code__c='ASGP',
                                                   Program_Version__c='',
                                                   //Application_Status__c='Denied',
                                                   Application_Status__c='Submitted',
                                                   Stage__c=0,
                                                   Short_Essay__c='hello',
                                                   High_School_Country__c='United States',
                                                   High_School_State__c = 'Alabama',
                                                   HS_Diploma_Received__c ='Received',
                                                   HS_Graduation_Date__c=Date.newInstance(2019, 12, 11),
                                                   College_1_Graduation_Date__c=Date.newInstance(2019, 11, 25),
                                                   College_2_Graduation_Date__c=Date.newInstance(2019, 10, 28)
                                                   
                                                  );
        
        insert testapp1;
        system.debug('--testapp1' +[Select Id,contact_email__c from Application__c limit 1 ].contact_email__c);
        
        Campus_Option__c testcamp1=new Campus_Option__c( Name='On Campus'
                                                       );
        insert testcamp1;
        
        Program_Option__c testprogopt1=new Program_Option__c( Name = 'Bachelor of Science in Animation Online',
                                                             Campus_Option__c =testcamp1.id,
                                                             Program_Code__c = 'ASGP'
                                                            );
        insert testprogopt1;
        
        Program_Concentration__c testprogconcen1=new Program_Concentration__c(Name = 'Visual Effects',
                                                                              Program_Option__c = testprogopt1.id
                                                                             );
        insert testprogconcen1;
        AgreementCountTrigger__c AgreementCountTrig=new AgreementCountTrigger__c(Name='AgreementCountTrigger',
                                                                              Trigger_Enabled__c=true,
                                                                              UpdateAgreementWithAttachmentSent__c=true
                                                                              );
        insert AgreementCountTrig;
        system.debug('--testapp1 before' +testapp1.Contact_Email__c);
        Test.startTest();
        system.runAs(u) {
        NewApplicationDetailComponentController appdetcomp1 = new NewApplicationDetailComponentController();
        
        system.debug('--testapp1 after' +testapp1.Contact_Email__c);
            appdetcomp1.recordContact = testContact1;
        
        
            appdetcomp1.recordApplication = testapp1;
        
        if( appdetcomp1.attch == NULL ) {
            appdetcomp1.attch = new Attachment();
        }
        system.debug('recon1id'+appdetcomp1.recordContact.Email);
        //system.debug('recapp1id'+appdetcomp1.recordApplication.Contact_Email__c);
        
        appdetcomp1.statePickList=true;
        appdetcomp1.checkpgmconsideration=true;
        //appdetcomp1.Program_Type__c='Ground';
         appdetcomp1.CampusOption='On Campus'; 
        appdetcomp1.selectedVal='';
        //appdetcomp1.initializeComponent();
        appdetcomp1.countryusUpdate();
        appdetcomp1.countryusUpdates();
        appdetcomp1.hiddenPhoneAlt='exampl';
        //NewApplicationDetailComponentController.Contact_Email__c='testuserma@gmail.com';
        appdetcomp1.stage=1;
        appdetcomp1.updateContactAndAppsavenfinish();
        appdetcomp1.updateContactAndApponAcceptandSubmit();
        List<SelectOption> selOpts1=appdetcomp1.Programoptions;
        List<SelectOption> selOptss1=appdetcomp1.Programconsiderations;
        appdetcomp1.goBackToSummaryDiplay();
        appdetcomp1.initializeComponent();
        NewApplicationDetailComponentController.doUploadAttachment('appId', 'attachmentBody', 'attachmentName', 'attachmentId');
        appdetcomp1.parseDateFromString('01/22/1999');
        appdetcomp1.getMonthNumber('');
        }
        Test.StopTest();  
    }
    @isTest  static void ApplicationDetail2(){
        
        Account testAccount = new Account( Name ='acctest'
                                         );
        insert testAccount;
        
        Contact testContact2= new Contact(FirstName ='Test1',
                                          LastName ='User1',
                                          Phone ='9389378343',
                                          OtherPhone ='8878777653',
                                          AccountId = testAccount.Id,
                                          Email ='testuserma@gmail.com',
                                          Birthdate=Date.newInstance(2019, 12, 9),
                                          Visa_Expiration_Date__c=Date.newInstance(2029, 10, 9),
                                          Start_Date_of_Service__c=Date.newInstance(2019, 10, 23),
                                          End_Date_of_Service__c=Date.newInstance(2019, 12, 29),
                                          ETS_EAS__c=Date.newInstance(2020, 12, 29),
                                          Ethnicity__c='American Indian or Alaskan Native',
                                          Gender__c='Female',
                                          Country_of_Citizenship__c = 'london',
                                          Program_Consideration__c='ytrtgf',
                                          Nationality__c='Albanian',
                                          MailingState = 'kjhgfd',
                                          MailingCountry='United States',
                                          Referral_First_Name__c='',
                                          Referral_Last_Name__c='',
                                          Referral_Email__c='',
                                          Referral_Phone__c='3456789876',
                                          Emergency_Contact_Phone__c='5676543456'
                                          //Program_Code__c='ASMP-O'
                                         );
        insert testContact2;
        
        
        Id newprofile = [select id from Profile where name='Application User'].id;
        
        user u= new user(LastName ='test1',
                         FirstName ='test2',
                         Email ='gayathri.aila@gmail.com',
                         Alias ='tvjd',
                         Username = 'jason@banana.com',
                         CommunityNickname = 'dsfgh',
                         ProfileId = newprofile,
                         ContactId = testContact2.id,
                         TimeZoneSidKey = 'GMT',
                         LanguageLocaleKey = 'en_US',
                         EmailEncodingKey = 'UTF-8',
                         LocaleSidKey = 'en_US'
                         
                        );
        
        //u.IsPortalEnabled=true;
        insert u;
        
        system.debug('user:'+u.Id);
        system.debug('userportal:'+u.IsPortalEnabled);
        
        Application__c testapp2=new Application__c(Student__c=testContact2.id,
                                                   Program_Code__c='ASGP',
                                                   Program_Version__c='',
                                                   Application_Status__c='Denied',
                                                   //Application_Status__c='Submitted',
                                                   Stage__c=3,
                                                   Short_Essay__c='',
                                                   High_School_Country__c='India',
                                                   High_School_State__c = 'Telangana',
                                                   HS_Diploma_Received__c ='Received',
                                                   HS_Graduation_Date__c=Date.newInstance(2019, 12, 11),
                                                   College_1_Graduation_Date__c=Date.newInstance(2019, 11, 25),
                                                   College_2_Graduation_Date__c=Date.newInstance(2019, 10, 28),
                                                   Exp_Startdate__c =Date.newInstance(2019, 10, 19)
                                                  );
        
        insert testapp2;
       
        
        Campus_Option__c testcamp2=new Campus_Option__c( Name='Online'
                                                       );
        insert testcamp2;
        
        Program_Option__c testprogopt2=new Program_Option__c( Name = 'Bachelor of Science in Animation Online',
                                                             Campus_Option__c =testcamp2.id,
                                                             Program_Code__c = 'ASGP'
                                                            );
        insert testprogopt2;
        
        Program_Concentration__c testprogconcen2=new Program_Concentration__c(Name = 'Visual Effects',
                                                                              Program_Option__c = testprogopt2.id
                                                                             );
        insert testprogconcen2;
         AgreementCountTrigger__c AgreementCountTrig1=new AgreementCountTrigger__c(Name='AgreementCountTrigger',
                                                                              Trigger_Enabled__c=true,
                                                                              UpdateAgreementWithAttachmentSent__c=true
                                                                              );
        insert AgreementCountTrig1;
        
        Test.startTest();
        
        PageReference pageRef = new PageReference('/apex/newApplicationDetail');
        pageRef.getParameters().put('appId',testapp2.id);
        Test.setCurrentPage(pageRef);
        PageReference ref = new PageReference('/apex/NewTotalApplications');
        Test.setCurrentPage(ref);
        
        NewApplicationDetailComponentController appdetcomp2 = new NewApplicationDetailComponentController();
       //NewApplicationDetailComponentController.sendPDFToContact(appId ,'testApplication','Test1User1','testuserma@gmail.com','ASGP');
        
        if( appdetcomp2.recordContact == NULL ) {
            appdetcomp2.recordContact = testContact2;
        }
        if( appdetcomp2.recordApplication == NULL ) {
            appdetcomp2.recordApplication = testapp2;
        }
       // system.debug('recon1id'+testContact2.id);
        if( appdetcomp2.attch == NULL ) {
            appdetcomp2.attch = new Attachment();
        }
        appdetcomp2.countryusUpdate();
        appdetcomp2.countryusUpdates();
        appdetcomp2.stage=3;
        appdetcomp2.ShortString='exmplee';
        appdetcomp2.updateContactAndAppsavenfinish();
        appdetcomp2.updateContactWithApplication();
        appdetcomp2.frdsinfo='No';
        appdetcomp2.stage=3;
        appdetcomp2.updateContactAndApponAcceptandSubmit();
        List<SelectOption> selOptss2=appdetcomp2.Programconsiderations;
        appdetcomp2.goBackToSummaryDiplay();
        appdetcomp2.getApplication();
        appdetcomp2.hiddenPhoneFriend='notblank';
        appdetcomp2.hiddenPhoneEmrg='noblank';
        appdetcomp2.setSupplementPhoneNumbers();
        NewApplicationDetailComponentController.doUploadAttachment('testapp2.id', 'attachmentBody', 'attachmentName', 'attachmentId');
        NewApplicationDetailComponentController.sendAutomaticAgreements(testapp2.id);
        NewApplicationDetailComponentController.sendPDFToContact(testapp2.id ,'testApplication','Test1User1','testuserma@gmail.com','ASGP');
        appdetcomp2.parseDateFromString('1999-01-22');
        appdetcomp2.setStartDate('October 19, 2019');
        Integer intMonthNumber;
        for(intMonthNumber=1;intMonthNumber<=12;intMonthNumber++){
            appdetcomp2.getMonthNumber('january');
            appdetcomp2.getMonthNumber('february');
            appdetcomp2.getMonthNumber('march');
            appdetcomp2.getMonthNumber('april');
            appdetcomp2.getMonthNumber('may');
            appdetcomp2.getMonthNumber('june');
            appdetcomp2.getMonthNumber('july');
            appdetcomp2.getMonthNumber('august');
            appdetcomp2.getMonthNumber('september');
            appdetcomp2.getMonthNumber('october');
            appdetcomp2.getMonthNumber('november');
            appdetcomp2.getMonthNumber('december');
        }
       
        //appdetcomp2.dateTimeValue=Date.newInstance(2019, 12, 9);
        appdetcomp2.covertDateFormat();
        Test.StopTest();
    }
   
}