@isTest(SeeAllData=True)
public class UpdateAgreementWithAttachmentSent_Test {
     static testMethod void UpdateAgreementWithAttachments() {
        test.startTest();
        echosign_dev1__SIGN_Merge_Mapping__c mapping=[Select id from echosign_dev1__SIGN_Merge_Mapping__c Limit 1];
        echosign_dev1__Agreement_Template__c	temp=[Select id From echosign_dev1__Agreement_Template__c	limit 1];
         
        echosign_dev1__SIGN_Agreement__c Agg=[Select Id From echosign_dev1__SIGN_Agreement__c where not( Name like '%Film School Admissions Application%' ) Limit 1];
      String aggid=Agg.id;
         //  Agg.Name='Test';
       // agg.echosign_dev1__Active__c=True;
       // agg.echosign_dev1__Master_Object_Type__c='Application__c';
//insert Agg;
        Attachment at =[Select Id,Name,Parentid From Attachment Where ParentId=:aggid   Limit 1];
        at.Name='Test';
        //at.Body=Blob.valueOf('Test');
       // at.ParentId=Agg.id;
        update at;
        test.stopTest();
    }


}