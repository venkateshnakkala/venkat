global class AgreementsRequestController {
    public final Application__c applicationobj{get;set;}
    //template Name, list of agreements for that template
    public Map<String, List<echosign_dev1__SIGN_Agreement__c>> allAgreements{get;set;}

    public String templateName{get;set;}
    public String rejectionReason{get;set;}
    public Id agreementId{get;set;}
    public String agreementIdString{get;set;}
    public String searchedText{get;set;}
    public String searchedTextUsed{get;set;}
    public List<String> agreementTemplateNames{get;set;}
    
    public AgreementsRequestController(ApexPages.StandardController stdCont){
        applicationobj = (Application__c)stdCont.getRecord();  
        loadAgreements();
    }

    public void searchAgreements(){
        loadAgreements();
    }
    public void loadAgreements(){
        system.debug('==== loadAgreements');
        allAgreements = new Map<String, List<echosign_dev1__SIGN_Agreement__c>>();
        agreementTemplateNames = new List<String>();
        List<echosign_dev1__Agreement_Template__c> allAgreementTemplates;
        if (!String.isBlank(searchedText) && searchedText.length() > 2){
            searchedTextUsed = '%'+searchedText+'%';
            allAgreementTemplates = [select id, Name from echosign_dev1__Agreement_Template__c where echosign_dev1__Agreement_Type__r.Name = 'app_community' and Name like: searchedTextUsed]; 
        }else{
            allAgreementTemplates = [select id, Name from echosign_dev1__Agreement_Template__c where echosign_dev1__Agreement_Type__r.Name = 'app_community']; 
        }
        
        for (echosign_dev1__Agreement_Template__c at: allAgreementTemplates){
            agreementTemplateNames.add(at.Name);
        }
        system.debug('==== agreementTemplateNames ');
        system.debug(agreementTemplateNames);
        for (echosign_dev1__SIGN_Agreement__c a: [Select id, Name, lastModifiedDate, echosign_dev1__Status__c, echosign_dev1__SignedPDF__c, echosign_dev1__Cancel_Delete_Reason__c  from echosign_dev1__SIGN_Agreement__c where Application__c =: applicationobj.id and  echosign_dev1__Agreement_Type__r.Name= 'app_community' and Name in:agreementTemplateNames order by lastModifiedDate desc]){
           system.debug(a);
           if (allAgreements.containsKey(a.Name)){
                allAgreements.get(a.Name).add(a);
           }else{
                List<echosign_dev1__SIGN_Agreement__c> auxAgreementList = new List<echosign_dev1__SIGN_Agreement__c>();
                echosign_dev1__SIGN_Agreement__c auxAgreement = new echosign_dev1__SIGN_Agreement__c();
                auxAgreement.Name = a.Name;
                auxAgreement.echosign_dev1__Status__c = 'Not Sent';
                auxAgreementList.add(auxAgreement);
                auxAgreementList.add(a);
                allAgreements.put(a.Name, auxAgreementList);
           }
        }
        
        for (echosign_dev1__Agreement_Template__c temp: allAgreementTemplates){
            if (!allAgreements.containsKey(temp.Name)){
                List<echosign_dev1__SIGN_Agreement__c> auxAgreementList = new List<echosign_dev1__SIGN_Agreement__c>();
                
                echosign_dev1__SIGN_Agreement__c auxAgreement = new echosign_dev1__SIGN_Agreement__c();
                auxAgreement.Name = temp.Name;
                auxAgreement.echosign_dev1__Status__c = 'Not Sent';
                auxAgreementList.add(auxAgreement);
                allAgreements.put(temp.Name, auxAgreementList);
            }
        }
        system.debug(allAgreements);
    }
    public void sendReminder(){

        echosign_dev1.EchoSignApiService.sendReminder(agreementId);
        loadAgreements();
        
    }
    public void accept(){

        echosign_dev1__SIGN_Agreement__c a = [select id, echosign_dev1__Status__c from echosign_dev1__SIGN_Agreement__c where id =:agreementId limit 1];
        a.echosign_dev1__Status__c = 'Accepted';
        upsert a;
        loadAgreements();
    }

    public void rejectAgreement(){

        echosign_dev1__SIGN_Agreement__c a = [select id, echosign_dev1__Status__c from echosign_dev1__SIGN_Agreement__c where id =:agreementId limit 1];
        a.echosign_dev1__Status__c = 'Rejected';
        a.echosign_dev1__Cancel_Delete_Reason__c = rejectionReason;
        upsert a;
        loadAgreements();
    }
    public  void sendAgreement(){

        Id templateId = [select id from echosign_dev1__Agreement_Template__c where echosign_dev1__Agreement_Type__r.Name = 'app_community' and Name=:templateName].id; 

        Id agreementId = echosign_dev1.AgreementTemplateService.load(templateId, applicationobj.id);
        echosign_dev1__SIGN_Agreement__c a = [select id, Application__c from echosign_dev1__SIGN_Agreement__c where id =:agreementId limit 1];
        a.Application__c = applicationobj.id;
        upsert a;

        loadAgreements();

    }
    
    
}