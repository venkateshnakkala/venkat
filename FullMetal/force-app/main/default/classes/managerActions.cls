global class managerActions{
  webService static string makeApprove(Id appId) {
        String rtn;
        Application__c a =[select id, application_status__c from Application__c where id=:appId];
        if(a.application_status__c=='Working'){
            rtn='Application is already approved for rep to work on qualifying applicant!';
        }
        else{
            a.application_status__c='Working';
            update a;
            rtn=NULL;
        }
        return rtn;
    }
}