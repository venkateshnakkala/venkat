trigger AgreementCountTrigger on echosign_dev1__SIGN_Agreement__c (After insert,after update, After delete, After undelete) 
{
    public class MyException extends Exception {}
    
    try {
        Set<Id> parentIdsSet = new Set<Id>();
        List<Application__c> accountListToUpdate = new List<Application__c>();
        
        AgreementCountTrigger__c  settings = AgreementCountTrigger__c.getInstance('AgreementCountTrigger');
        Boolean enabled = False;
        
        if(settings!=NULL){
            enabled = settings.Trigger_Enabled__c;
        }
        
        if(enabled)
        {
            if(Trigger.IsAfter)
            {
                if(Trigger.IsInsert || Trigger.IsUndelete || Trigger.IsUpdate)
                {
                    for(echosign_dev1__SIGN_Agreement__c c : Trigger.new)
                    {
                        if(c.Application__c!=null){   
                            parentIdsSet.add(c.Application__c); 
                        }
                    }
                }
                if(Trigger.IsDelete)
                {
                    for(echosign_dev1__SIGN_Agreement__c c : Trigger.Old)
                    {
                        if(c.Application__c!=null){   
                            parentIdsSet.add(c.Application__c); 
                        }
                    }
                }
            }
            
            if(parentIdsSet!=null && parentIdsSet.size()>0)
            {
                Map<String,Id> dupsCount= new Map<String,Id>();
                Map<String,Id> dupsSigned= new Map<String,Id>();
                
                Map<Id,Map<String,Docs>> docCount= new Map<Id,Map<String,Docs>>();
                
                List<Application__c> accountList = new List<Application__c>([Select id ,Total_Agreements__c,Name,AM_Docs_Total__c,AM_Docs_Complete__c,FA_Docs_Total__c,FA_Docs_Complete__c,ISIR_Docs_Total__c,ISIR_Docs_Complete__c, (Select id, Name,echosign_dev1__Status__c From Agreements__r Where echosign_dev1__Status__c!='Draft' ORDER BY LastModifiedDate) from Application__c Where id IN :parentIdsSet]);

                if(accountList.size()>0)
                {
                    for(Application__c acc : accountList)
                    {
                        List<echosign_dev1__SIGN_Agreement__c> aggrements = acc.Agreements__r;
                        
                        if(aggrements!=NULL && aggrements.size()>0)
                        {
                            docCount.put(acc.id, new Map<String,Docs>());
                            
                            for(echosign_dev1__SIGN_Agreement__c ag :aggrements)
                            {
                                // document name
                                string docName=ag.name.toUpperCase();
                                
                                // first two letters of the document
                                string tag=(ag.name!=NULL && ag.name.length()>=2)?ag.name.subString(0,2).toUpperCase():ag.name.toUpperCase();
                                
                                // count all unique docs
                                if(docCount.get(acc.id).containsKey(tag) && !dupsCount.containsKey(docName))
                                {
                                    docCount.get(acc.id).get(tag).addTotal();
                                }
                                else if(!dupsCount.containsKey(docName))
                                {
                                    docCount.get(acc.id).put(tag, new Docs());
                                    dupsCount.put(docName, ag.id);
                                }
                                
                                // count signed docs
                                if(ag.echosign_dev1__Status__c=='Signed' && !dupsSigned.containsKey(docName))
                                {
                                    docCount.get(acc.id).get(tag).addSigned();
                                    
                                    dupsSigned.put(docName, ag.id);
                                }
                            }
                        }
                    }
                    
                    
                    for(Id appId :docCount.KeySet())
                    {
                        Application__c a = new Application__c(Id=appId);
 
                        for(String tag :docCount.get(appId).keySet())
                        {
                            // reset all the fields
                            a.AM_Docs_Total__c=0;
                            a.AM_Docs_Complete__c=0;
                            a.FA_Docs_Total__c=0;
                            a.FA_Docs_Complete__c=0;
                            a.ISIR_Docs_Total__c=0;
                            a.ISIR_Docs_Complete__c=0;
                            
                            // add new values
                            if(tag=='AM'){
                                a.AM_Docs_Total__c=docCount.get(appId).get('AM').total;
                                a.AM_Docs_Complete__c =docCount.get(appId).get('AM').signed;
                            }
                            if(tag=='FA'){
                                a.FA_Docs_Total__c =docCount.get(appId).get('FA').total;
                                a.FA_Docs_Complete__c =docCount.get(appId).get('FA').signed;
                            }
                            if(tag=='IS'){
                                a.ISIR_Docs_Total__c =docCount.get(appId).get('IS').total;
                                a.ISIR_Docs_Complete__c =docCount.get(appId).get('IS').signed;
                            }

                        }
                                              
                        accountListToUpdate.add(a);
                    }
                    
                }
                if(accountListToUpdate.size()>0){
                    update accountListToUpdate;
                }
            }
        }
    }
    catch(Exception e){
        throw new myException(e.getMessage()+' @Line #: '+e.getLineNumber());
    }
    
    public class docs
    {
        public Integer total{get;set;}
        public integer signed{get;set;}
        
        public docs(){
            this.total=1;
            this.signed=0;
        }
        
        public void addTotal(){
            this.total+=1;
        }
        
        public void addSigned(){
            this.signed+=1;
        }
    }
}