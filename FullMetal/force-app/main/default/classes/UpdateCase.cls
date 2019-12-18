global with sharing class UpdateCase {
    webService static String assignToMyQueue(ID caseId)
    {
        Case caseRecord = [Select Id,CaseNumber,SuppliedEmail,ContactId  from Case Where Id =: caseId];
        if(caseRecord.SuppliedEmail!=null){
            Contact ct=[Select Id , Email ,Other_Email__c From Contact Where Email=:caseRecord.SuppliedEmail OR Other_Email__c=:caseRecord.SuppliedEmail];
            if(ct!=null){
                System.debug('Contact Info----'+ct);
                Case cc=New Case();
                cc.id=caseRecord.Id;
                cc.ContactId=ct.id;
                update cc;
                
            }
           
        }
 		return 'Case Id is ' + caseRecord.CaseNumber + 'Is Updated';
    }

}