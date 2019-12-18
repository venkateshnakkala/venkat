public class Postback
{
    public PageReference Action()
    {
        Map<String,String> validIPs = new Map<String,String>();
        
        validIPs.put('207.66.146.132','sandbox');
        validIPs.put('199.189.232.10','official payment');
        validIPs.put('199.189.232.120','official payment');
        validIPs.put('199.189.234.120','official payment');
        
        string ApplicationNumber=NULL;
        string PaymentCode=NULL;
        string ConfermationCode=NULL;
        String IP=NULL;
         
        if(ApexPages.currentPage().getParameters().containsKey('confirmation')){
            PaymentCode=ApexPages.currentPage().getParameters().get('confirmation');
        }
         
        if(ApexPages.currentPage().getParameters().containsKey('uid')){
            ApplicationNumber=ApexPages.currentPage().getParameters().get('uid');
        }
        
        if (String.isBlank(IP) && ApexPages.currentPage().getHeaders().containsKey('True-Client-IP')) {
            IP = ApexPages.currentPage().getHeaders().get('True-Client-IP');
        }
        
        if (String.isBlank(IP) && ApexPages.currentPage().getHeaders().containsKey('X-Salesforce-SIP')) {
            IP = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
        }
        
        if (String.isBlank(IP) && ApexPages.currentPage().getHeaders().containsKey('X-Forwarded-For')) {
            IP = ApexPages.currentPage().getHeaders().get('X-Forwarded-For');
        }
        
        if(String.isBlank(IP) || (!String.isBlank(IP) && !validIPs.containsKey(IP))){
            ConfermationCode='UNAUTHORIZED IP:'+IP+' (#'+PaymentCode+')';
        }
        else{
            ConfermationCode=PaymentCode;
        }
        
        if(ApplicationNumber!=NULL)
        {
            List<Application__c> a = [SELECT Id, Application_Fee_Paid__c FROM Application__c WHERE Application_Number__c=:ApplicationNumber];
            
            if(a.size()>0 && !a[0].Application_Fee_Paid__c)
            {
                a[0].Payment_Confirmation__c=ConfermationCode;
                
                Set<String> PayErrors = new Set<String>();
                PayErrors.add('error');
                PayErrors.add('declined');
                PayErrors.add('referral');
                PayErrors.add('hold');
                PayErrors.add('other');
                
                if(!PayErrors.contains(PaymentCode.toLowerCase()) && !String.isBlank(PaymentCode) && ConfermationCode==PaymentCode){
                    a[0].Application_Fee_Paid__c=true;
                }
                
                update a;
            }
        }
        
        return NULL;
    }
}