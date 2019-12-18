public class test_postback{

    public Id page_id{get;private set;}
    public string page_data{get;private set;}
    
    public void test_postback(){
        this.action();
    }
    
    public PageReference action(){
        Map<String,String> param = ApexPages.currentPage().getParameters();
        String heads = ApexPages.currentPage().getHeaders().get('Referer');
        
        String params=JSON.serialize(param);
        //String heads=JSON.serialize(head);
        
        this.page_data=params;
        Application__c a = [select Id, short_essay__c from Application__c where student__r.firstname='test' and student__r.lastname='test' limit 1];
        
        String IP= ApexPages.currentPage().getHeaders().get('True-Client-IP');

        if (IP == '' || IP == null) {
            IP = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
        } // get IP address when no caching (sandbox, dev, secure urls)

        if (IP == '' || IP == null) {
            IP = ApexPages.currentPage().getHeaders().get('X-Forwarded-For');
        } // get IP address from standard header if proxy in use

        
        a.short_essay__c+='\n\n'+'IP:'+IP+'--'+params+'\n'+heads;
        update a;
        this.page_id=a.id;
        return null;
    }
}