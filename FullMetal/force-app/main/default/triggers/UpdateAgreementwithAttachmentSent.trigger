trigger UpdateAgreementwithAttachmentSent on Attachment (After insert,After Update) {
    
    
    AgreementCountTrigger__c  settings = AgreementCountTrigger__c.getInstance('AgreementCountTrigger');
    Boolean  enabled   = settings.UpdateAgreementWithAttachmentSent__c;
    if(enabled){
        
        Map<String,string> attmap=new map<String,String>();
        List<echosign_dev1__SIGN_Agreement__c> updateAggs=new List<echosign_dev1__SIGN_Agreement__c>();
        for (Attachment at : Trigger.new){
            String AttName=at.Name;
            boolean bd=AttName.Contains('Film School');
            if(!bd){
                attmap.put(at.ParentId, at.name);
            }
        }
        if(attmap.size()>0){
            system.debug(attmap.keySet());
            List<echosign_dev1__SIGN_Agreement__c> Agg=[Select id,Name,File_Sent__c From echosign_dev1__SIGN_Agreement__c Where Id IN :attmap.keySet()];
            system.debug(agg);
            if(Agg.size()>0){
                for(echosign_dev1__SIGN_Agreement__c updateAgg:Agg){
                    
                    echosign_dev1__SIGN_Agreement__c Sagg=new echosign_dev1__SIGN_Agreement__c();
                    Sagg.id=updateAgg.id;
                    Sagg.File_Sent__c=+' ' +attmap.get(updateAgg.id);
                    updateAggs.add(Sagg);
                }
                update updateAggs;
            }
            
        }
    }
    
}