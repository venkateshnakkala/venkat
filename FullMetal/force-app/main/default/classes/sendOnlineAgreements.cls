public class sendOnlineAgreements implements Queueable, Database.AllowsCallouts {
    private String templateId;
    private List<Id> templates;
    private Id appId;
    
    public sendOnlineAgreements(Id appId, List<Id> templates){
    	this.appId = appId;
    	this.templates = templates;
    
    	Application__c app = [select Program_Code__c from Application__c where id=: appId];

    	if (templates == null){
    		List<Automatic_Agreement__c> aas = [ SELECT Agreement_Template__c from Automatic_Agreement__c WHERE Program_Code__c includes (:app.Program_Code__c)];
    		this.templates = new List<Id>();
    		for (Automatic_Agreement__c aa: aas){
    			this.templates.add(aa.Agreement_Template__c);
    		}
    	}
    	this.templateId = null;
    	if (this.templates.size()>0){
    		this.templateId = this.templates.get(0);
    		this.templates.remove(0);
    	}
    }
    
    public void execute (QueueableContext context){
    	if (templateId != null){
            Id agreementId = echosign_dev1.AgreementTemplateService.load(templateId, appId);
            echosign_dev1__SIGN_Agreement__c a = [ SELECT id, Application__c FROM echosign_dev1__SIGN_Agreement__c 
                                                   WHERE id =:agreementId limit 1
                                                 ];
            a.Application__c = appId;
            upsert a;
            echosign_dev1.EchoSignApiService.sendDocument(agreementId);
        }
        if (this.templates!= null && this.templates.size()>0){
        	System.enqueueJob(new sendOnlineAgreements(appId, this.templates));
        }
    }
    
}