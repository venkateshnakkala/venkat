@isTest(SeeAllData=false)
public class AgreementCountTriggerTest {
     static testMethod void test()
    {
        test.startTest();
       //  Contact c = [select id from contact limit 1];//
        contact c=new contact();
        c.lastname='sdsd';
        insert c;
        AgreementCountTrigger__c  settings = new AgreementCountTrigger__c();
        settings.Name='AgreementCountTrigger';
    	settings.Trigger_Enabled__c=True;
        insert settings;
        //AgreementCountTrigger__c  settings = AgreementCountTrigger__c.getInstance('AgreementCountTrigger');


        
        Application__c ap =new Application__c();
        ap.Student__c=c.id;
        insert ap;
        echosign_dev1__SIGN_Agreement__c bc =new echosign_dev1__SIGN_Agreement__c();
        bc.Name='FA Film School Financial Aid Documents';
        bc.Application__c=ap.id;
        bc.echosign_dev1__Status__c='Out For Signature';
        insert bc;
        bc.Name='AM Film School Financial Aid Documents';
        update bc;
        
        bc.Name='ISIR Film School Financial Aid Documents';
        update bc;

       // delete bc;
        
		test.stopTest();
    }

}