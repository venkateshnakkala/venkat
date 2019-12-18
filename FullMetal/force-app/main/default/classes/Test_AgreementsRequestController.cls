@isTest
public class Test_AgreementsRequestController {
 @isTest  static void AgreementsRequest(){
     Account testAccount = new Account( Name ='acctest'
                                         );
        insert testAccount;
        
        Contact testContact= new Contact(FirstName ='Test',
                                         LastName ='User',
                                         Phone ='9389378344',
                                         OtherPhone ='8878777654',
                                         AccountId = testAccount.Id,
                                         Email ='testuserma@gmail.com',
                                         Birthdate=Date.newInstance(2019, 12, 9)
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
        
        insert u;
        Application__c testapp=new Application__c(Student__c=testContact.id,
                                                  Application_Status__c='Denied',
                                                  Stage__c=3
                                                 );
        insert testapp;
     echosign_dev1__SIGN_Agreement__c testechoagree= new echosign_dev1__SIGN_Agreement__c(Name='testagree',
                                                                                          echosign_dev1__Status__c = 'Accepted'
                                                                                         /* echosign_dev1__Agreement_Type__c='app_community'*/
                                                                                        );
      insert testechoagree;
     echosign_dev1__Agreement_Template__c testagreetempl= new echosign_dev1__Agreement_Template__c(Name='templ'
                                                   /*echosign_dev1__Agreement_Type__c=testechoagree.echosign_dev1__Agreement_Type__c*/
                                                                                                  );
     insert testagreetempl;
     AgreementsRequestController RequestController= new AgreementsRequestController(new ApexPages.StandardController(testapp));
     RequestController.agreementId=testechoagree.id;
     RequestController.templateName=testagreetempl.Name;
     RequestController.rejectionReason='testfail';
     RequestController.agreementIdString='testagreed';
     RequestController.searchedText='testsearch';
     RequestController.searchedTextUsed='testsearchused';
     
     RequestController.searchAgreements();
     RequestController.loadAgreements();
     RequestController.sendReminder();
     RequestController.accept();
     RequestController.rejectAgreement();
     //RequestController.sendAgreement();
     
 }
     @isTest  static void AgreementsRequest1(){
     Account testAccount1 = new Account( Name ='acctest'
                                         );
        insert testAccount1;
        
        Contact testContact1= new Contact(FirstName ='Test',
                                         LastName ='User',
                                         Phone ='9389378344',
                                         OtherPhone ='8878777654',
                                         AccountId = testAccount1.Id,
                                         Email ='testuserma@gmail.com',
                                         Birthdate=Date.newInstance(2019, 12, 9)
                                        );
        insert testContact1;
        system.debug('contid:'+testContact1.id);
        
        
        Id newprofile = [select id from Profile where name='Application User'].id;
        
        user u= new user(LastName ='test1',
                         FirstName ='test2',
                         Email ='gayathri.aila@gmail.com',
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
        
        insert u;
        Application__c testapp1=new Application__c(Student__c=testContact1.id,
                                                  Application_Status__c='Submitted',
                                                  Stage__c=3
                                                 );
        insert testapp1;
     echosign_dev1__SIGN_Agreement__c testechoagree1= new echosign_dev1__SIGN_Agreement__c(Name='testagree',
                                                                                          echosign_dev1__Status__c = 'Not Sent'
                                                                                         /* echosign_dev1__Agreement_Type__c='app_community'*/
                                                                                        );
      insert testechoagree1;
     echosign_dev1__Agreement_Template__c testagreetempl1= new echosign_dev1__Agreement_Template__c(Name='templ'
                                                   /*echosign_dev1__Agreement_Type__c=testechoagree.echosign_dev1__Agreement_Type__c*/
                                                                                                  );
     insert testagreetempl1;
     AgreementsRequestController RequestController1= new AgreementsRequestController(new ApexPages.StandardController(testapp1));
     RequestController1.agreementId=testechoagree1.id;
     RequestController1.templateName=testagreetempl1.Name;
     RequestController1.rejectionReason='testfail';
     RequestController1.agreementIdString='testagreed';
     RequestController1.searchedText='testsearch';
     RequestController1.searchedTextUsed='testsearchused';
     
     RequestController1.searchAgreements();
     RequestController1.loadAgreements();
     RequestController1.sendReminder();
     RequestController1.accept();
     RequestController1.rejectAgreement();
     //RequestController1.sendAgreement();
     
 }
}