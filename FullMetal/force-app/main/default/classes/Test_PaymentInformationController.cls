@isTest
public class Test_PaymentInformationController {
     public static testmethod void TestPayment(){
                Account testAccount = new Account(
            Name ='acctest'
        );
        insert testAccount;
        
        Contact testContact= new Contact(
            
            FirstName ='aila',
            LastName ='gayu',
            Phone ='987654345',
            AccountId = testAccount.Id,
            Email ='gayathri.aila@criticalriver.com',
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
         //testApplication.Application_Number__c='';
         insert testApplication;
         
         applist.add(testApplication);
         
         Test.startTest();
         PaymentInformationController controller=new PaymentInformationController();
         
         //String ApplicationId ='sample';
         PaymentInformationController.payinfoupdate(testApplication.id);
         
         //String selectedApplicationId ='test';
        PaymentInformationController.getPaymentLink(testApplication.id);
         //String payLink='';
         Test.stopTest();
    }
    public static testmethod void TestPayment1(){
         Account testAccount = new Account(
            Name ='acctest'
        );
        insert testAccount;
        
        Contact testContact= new Contact(
            
            FirstName ='aila',
            LastName ='gayu',
            Phone ='987654345',
            AccountId = testAccount.Id,
            Email ='gayathri.aila@criticalriver.com',
            MailingCountry='United States',
            MailingPostalCode='4567',
            MailingStreet='sdfgh',
            MailingCity='hyd',
            MailingState='iuytr'
            );
        insert testContact;
         
         
         Application__c testApplication=New Application__c();
        testApplication.Student__c=testContact.id;
        testApplication.Program_Code__c='ASMP';
        testApplication.Pay_Later__c=true;
        Test.startTest();
         PaymentInformationController controller=new PaymentInformationController();
         
         //String ApplicationId ='sample';
         PaymentInformationController.payinfoupdate('');
         
               Test.stopTest();
        
    }
}