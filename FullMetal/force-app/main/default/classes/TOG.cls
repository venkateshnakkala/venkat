public class TOG implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {

    public class customException extends Exception {}
    
    private Map<String,String> security_keys{get;set;}
    
    private Map<String,String> campaigns{get;set;}

    private Id TOGUser{get;set;}
    
    private Map<Id,Contact> NewData{get;set;}
    private Map<Id,Contact> OldData{get;set;}
    private Map<Id,Contact> AllData {get;set;}
    
    private Map<Id,Id> addIds{get;set;}
    private Map<Id,Id> removeIds{get;set;}
    
    private Map<String,Map<Id,Id>> addContacts{get;set;}
    private Map<String,Map<Id,Id>> removeContacts{get;set;}
    
    private Map<String,List<Contact>> adds{get;set;}
    private Map<String,List<Contact>> dels{get;set;}
    
    private List<Id> addOrRemove{get;set;}
    
    private Boolean custom{get;set;}
    private String query{get;set;}
    
    public TOG(){
        AllData= new Map<Id,Contact>();
        this.custom=false;
        this.construct();
    }
    
    public TOG(String q){
        this.construct();
        this.custom=true;
        this.query=q;
    }
    
    public TOG(Map<Id,Contact> n, Map<Id,Contact> o)
    {
        this.custom=false;
        this.NewData = n;
        this.OldData = o;
        AllData= new Map<Id,Contact>();
        
        if(NewData!=NULL){
            AllData.putAll(NewData);
        }
          
        if(OldData!=NULL){
            AllData.putAll(OldData);
        }
        
        this.construct();
    }
    
    public void construct(){
        
        this.query=NULL;
        
        // test = 130425, online = 130892, oncampus = 130872, fsleads=131786
        campaigns = new Map<String,String>();
        campaigns.put('online','130892');
        campaigns.put('oncampus','130872');
        campaigns.put('fsleads','131786');
        
        security_keys = new Map<String,String>();
        security_keys.put(campaigns.get('online'),'8951eb0ebcc561f6089cff1eaaef65e3');
        security_keys.put(campaigns.get('oncampus'),'0de90e958f56f0feeaf16e481b6a8d98');
        security_keys.put(campaigns.get('fsleads'),'0de90e958f56f0feeaf16e481b6a8d98');
        
        TOGUser='0051a000002tHWnAAM';
        
        this.addOrRemove = new List<Id>();
        
        this.addContacts = new Map<String,Map<Id,Id>>();
        this.addContacts.put(campaigns.get('online'),new Map<Id,Id>());
        this.addContacts.put(campaigns.get('oncampus'),new Map<Id,Id>());
        this.addContacts.put(campaigns.get('fsleads'),new Map<Id,Id>());
        
        this.removeContacts = new Map<String,Map<Id,Id>>();
        this.removeContacts.put(campaigns.get('online'),new Map<Id,Id>());
        this.removeContacts.put(campaigns.get('oncampus'),new Map<Id,Id>());
        this.removeContacts.put(campaigns.get('fsleads'),new Map<Id,Id>());
        
        this.adds = new Map<String,List<Contact>>();
        this.adds.put(campaigns.get('online'),new List<Contact>());
        this.adds.put(campaigns.get('oncampus'),new List<Contact>());
        this.adds.put(campaigns.get('fsleads'),new List<Contact>());
        
        this.dels = new Map<String,List<Contact>>();
        this.dels.put(campaigns.get('online'),new List<Contact>());
        this.dels.put(campaigns.get('oncampus'),new List<Contact>());
        this.dels.put(campaigns.get('fsleads'),new List<Contact>());
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        try {
            if(!this.custom)
            {
                Contact n = New Contact();
                Contact o = New Contact();
                      
                for(Id i :AllData.KeySet())
                {   
                    if(OldData==NULL && NewData!=NULL && NewData.ContainsKey(i) && NewData.get(i).Program_Code__c!=NULL && NewData.get(i).OwnerId==TOGUser 
                        && getPhoneNumber(NewData.get(i).Phone, NewData.get(i).Affiliation_Code__c).get('local')!=NULL && NewData.get(i).DoNotCall!=true){
                        // insert
                        
                        if(NewData.get(i).Program_Code__c.endsWith('-O'))
                        {
                            if(NewData.get(i).Lead_Source_Code__c=='FULLSAILLEAD')
                            {
                                addContacts.get(campaigns.get('fsleads')).put(i,i);
                            }
                            else
                            {
                                addContacts.get(campaigns.get('online')).put(i,i);
                            }
                        }
                        else{
                            addContacts.get(campaigns.get('oncampus')).put(i,i);
                        }
                    }
                    else if(OldData!=NULL && NewData!=NULL && OldData.ContainsKey(i) && NewData.ContainsKey(i) 
                        && NewData.get(i).Program_Code__c!=NULL && getPhoneNumber(NewData.get(i).Phone, NewData.get(i).Affiliation_Code__c).get('local')!=NULL
                        && NewData.get(i).OwnerId==TOGUser && OldData.get(i).OwnerId!=TOGUser){
                        // update + add TOG user
                        
                        if(NewData.get(i).Program_Code__c.endsWith('-O'))
                        {
                            if(NewData.get(i).Lead_Source_Code__c=='FULLSAILLEAD')
                            {
                                addContacts.get(campaigns.get('fsleads')).put(i,i);
                            }
                            else
                            {
                                addContacts.get(campaigns.get('online')).put(i,i);
                            }
                        }
                        else{
                            addContacts.get(campaigns.get('oncampus')).put(i,i);
                        }
                    }
                    else if(OldData!=NULL && NewData!=NULL && OldData.ContainsKey(i) && NewData.ContainsKey(i) && OldData.get(i).Program_Code__c!=NULL
                        && OldData.get(i).OwnerId==TOGUser && NewData.get(i).OwnerId!=TOGUser){
                        // update + remove TOG user
                        
                        if(OldData.get(i).Program_Code__c.endsWith('-O'))
                        {
                            if(OldData.get(i).Lead_Source_Code__c=='FULLSAILLEAD')
                            {
                                removeContacts.get(campaigns.get('fsleads')).put(i,i);
                            }
                            else
                            {
                                removeContacts.get(campaigns.get('online')).put(i,i);
                            }
                        }
                        else{
                            removeContacts.get(campaigns.get('oncampus')).put(i,i);
                        }
                    }
                }
                
                addOrRemove.addAll(addContacts.get(campaigns.get('online')).keySet());
                addOrRemove.addAll(addContacts.get(campaigns.get('oncampus')).keySet());
                addOrRemove.addAll(addContacts.get(campaigns.get('fsleads')).keySet());
                
                addOrRemove.addAll(removeContacts.get(campaigns.get('online')).keySet());
                addOrRemove.addAll(removeContacts.get(campaigns.get('oncampus')).keySet());
                addOrRemove.addAll(removeContacts.get(campaigns.get('fsleads')).keySet());
                
                if(Test.isRunningTest()){
                    return Database.getQueryLocator([select Id,DoNotCall, Phone,School_Status__c,Email,FirstName,High_School_Graduation_Year__c,LastName,Lead_Date__c,Lead_Source__c,Lead_Source_Code__c,MailingPostalCode,Program__c,Affiliation_Code__c,Exclude_TOG__c from contact where phone!=NULL limit 5]);
                }
                else{
                    return Database.getQueryLocator([select Id,DoNotCall, Phone,School_Status__c,Email,FirstName,High_School_Graduation_Year__c,LastName,Lead_Date__c,Lead_Source__c,Lead_Source_Code__c,MailingPostalCode,Program__c,Affiliation_Code__c,Exclude_TOG__c from contact where (Id IN:addOrRemove) and phone!=NULL]);
                }
            }
            else
            {
                return Database.getQueryLocator(this.query);
            }
        }
        catch(Exception e){
            throw new customException(e.getMessage()+' @ Line Number '+e.getLineNumber());
        }
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> con) {
        try{ 
        
            List<Contact> CustomOnLine = new List<Contact>();
            List<Contact> CustomOnCampus = new List<Contact>();
            List<Contact> CustomOnFS = new List<Contact>();
            
            for(Contact c :con)
            {
                if(this.custom)
                {
                    if(c.Program_Code__c!=NULL && getPhoneNumber(c.Phone,c.Affiliation_Code__c).get('local')!=NULL && c.Program_Code__c.endsWith('-0'))
                    {
                        //adds.get(campaigns.get('online')).add(c);
                        if(c.Lead_Source_Code__c=='FULLSAILLEAD'){
                            CustomOnFS.add(c);
                        }
                        else{
                            CustomOnLine.add(c);
                        }
                    }
                    else if(c.Program_Code__c!=NULL && getPhoneNumber(c.Phone,c.Affiliation_Code__c).get('local')!=NULL && !c.Program_Code__c.endsWith('-0'))
                    {
                        //adds.get(campaigns.get('oncampus')).add(c);
                        CustomOnCampus.add(c);
                    }
                    c.ownerId='0051a000002tHWnAAM'; // TOG Queue user
                    c.exclude_tog__c=true;
                }
                else if(this.addContacts.get(campaigns.get('online'))!=NULL && this.addContacts.get(campaigns.get('online')).containsKey(c.id)){
                    adds.get(campaigns.get('online')).add(c);
                }
                else if(this.addContacts.get(campaigns.get('oncampus'))!=NULL && this.addContacts.get(campaigns.get('oncampus')).containsKey(c.id)){
                    adds.get(campaigns.get('oncampus')).add(c);
                }
                else if(this.addContacts.get(campaigns.get('fsleads'))!=NULL && this.addContacts.get(campaigns.get('fsleads')).containsKey(c.id)){
                    adds.get(campaigns.get('fsleads')).add(c);
                }
                else if(this.removeContacts.get(campaigns.get('online'))!=NULL && this.removeContacts.get(campaigns.get('online')).containsKey(c.id)){
                    dels.get(campaigns.get('online')).add(c);
                }
                else if(this.removeContacts.get(campaigns.get('oncampus'))!=NULL && this.removeContacts.get(campaigns.get('oncampus')).containsKey(c.id)){
                    dels.get(campaigns.get('oncampus')).add(c);
                }
                else if(this.removeContacts.get(campaigns.get('fsleads'))!=NULL && this.removeContacts.get(campaigns.get('fsleads')).containsKey(c.id)){
                    dels.get(campaigns.get('fsleads')).add(c);
                }
            }
            
            if(this.custom)
            { 
                if(CustomOnLine.size()>0){
                    this.add(campaigns.get('online'),CustomOnLine);
                }
            
                if(CustomOnCampus.size()>0){
                    this.add(campaigns.get('oncampus'),CustomOnCampus);
                }
                
                if(CustomOnFS.size()>0){
                    this.add(campaigns.get('fsleads'),CustomOnFS);
                }
                
                update con; 
            }
        }
        catch(Exception e){
            throw new customException(e.getMessage()+' @ Line Number '+e.getLineNumber());
        }
    }
    
    public void finish(Database.BatchableContext bc) 
    {
        try
        {
            if(!this.custom)
            {
                if(adds.get(campaigns.get('online')).size()>0){ this.add(campaigns.get('online'),adds.get(campaigns.get('online'))); }
                if(adds.get(campaigns.get('oncampus')).size()>0){ this.add(campaigns.get('oncampus'),adds.get(campaigns.get('oncampus'))); }
                if(adds.get(campaigns.get('fsleads')).size()>0){ this.add(campaigns.get('fsleads'),adds.get(campaigns.get('fsleads'))); }
                
                if(dels.get(campaigns.get('online')).size()>0){ this.remove(campaigns.get('online'),dels.get(campaigns.get('online'))); }
                if(dels.get(campaigns.get('oncampus')).size()>0){ this.remove(campaigns.get('oncampus'),dels.get(campaigns.get('oncampus'))); }
                if(dels.get(campaigns.get('fsleads')).size()>0){ this.remove(campaigns.get('fsleads'),dels.get(campaigns.get('fsleads'))); }
            }
        }
        catch(Exception e){
            throw new customException(e.getMessage()+' @ Line Number '+e.getLineNumber());
        }
    }
    
    public void add(String campaignId, List<Contact> dataSet)
    {
        try
        {
            if(dataSet==NULL || dataSet.size()==0){ return; }
            
            string xml=NULL;
            
            DOM.Document doc = new DOM.Document();
            
            doc.load('<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" '+
                    'xmlns:tns="http://listloader.system.intelliqueue" xmlns:types="http://listloader.system.intelliqueue/encodedTypes" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
                    'xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><tns:leadAdd><strXml xsi:type="xsd:string"></strXml>'+
                    '</tns:leadAdd></soap:Body></soap:Envelope>');
            
            dom.XmlNode strXml = doc.getRootElement().getChildElement('Body','http://schemas.xmlsoap.org/soap/envelope/').getChildElement('leadAdd','http://listloader.system.intelliqueue').getChildElement('strXml',NULL);
            
            DOM.Document data_file = new DOM.Document();
            
            dom.XmlNode lead_add = data_file.createRootElement('lead_add', null, null);
            dom.XmlNode metadata = lead_add.addChildElement('metadata', null, null);
            metadata.addChildElement('security_key', null, null).addTextNode(security_keys.get(campaignId));
            metadata.addChildElement('campaign_id', null, null).addTextNode(campaignId);
            metadata.addChildElement('list_name', null, null);
            metadata.addChildElement('de_dupe', null, null).addTextNode('true');
            
            dom.XmlNode leads = lead_add.addChildElement('leads', null, null);
            
            for(Contact c :dataSet)
            {
                Map<String,String> p = getPhoneNumber(c.phone,c.Affiliation_Code__c);
                
                if(p.get('local')!=NULL)
                {
                    dom.XmlNode lead = leads.addChildElement('lead', null, null);
                    
                    String ExtId = c.id;
                    lead.addChildElement('extern_id', null, null).addTextNode(ExtId.left(15));
                    lead.addChildElement('phone', null, null).addTextNode(p.get('local'));
                    
                    if(c.firstname!=NULL){lead.addChildElement('first_name', null, null).addTextNode(c.firstname);}
                    if(c.lastname!=NULL){lead.addChildElement('last_name', null, null).addTextNode(c.lastname);}
                    if(c.Program__c!=NULL){lead.addChildElement('gate_keeper', null, null).addTextNode(c.Program__c);}
                    if(c.email!=NULL){lead.addChildElement('email', null, null).addTextNode(c.email);}
                    if(c.Lead_Source_Code__c!=NULL){lead.addChildElement('address1', null, null).addTextNode(c.Lead_Source_Code__c);}
                    if(c.Lead_Source__c!=NULL){lead.addChildElement('address2', null, null).addTextNode(c.Lead_Source__c);}
                    if(c.Lead_Date__c!=NULL){lead.addChildElement('city', null, null).addTextNode(c.Lead_Date__c.format('M/d/y H:m:s z'));} // 06/07/2018 14:32:43 PDT
                    if(c.School_Status__c!=NULL){lead.addChildElement('state', null, null).addTextNode(c.School_Status__c);}
                    if(c.MailingPostalCode!=NULL){lead.addChildElement('zip', null, null).addTextNode(c.MailingPostalCode);}
                    if(c.High_School_Graduation_Year__c!=NULL){lead.addChildElement('aux_data3', null, null).addTextNode(String.ValueOf(c.High_School_Graduation_Year__c));}
                }
            }
            
            String list_data=data_file.toXmlString();
            
            strXml.addTextNode(list_data);
            
            xml = doc.toXmlString();
            
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint('http://www.virtualacd.biz/intelliqueue/system/listloader/ListLoader.cfc');
            req.setMethod('POST');
            req.setHeader('Content-Type','text/xml; charset=UTF-8');
            req.setHeader('SOAPAction','');
            req.setBody(xml);

            if(leads.getChildElements().size()>0 || Test.isRunningTest())
            {
                Http http = new Http();
                
                HttpResponse res = http.send(req);
                
                if(res.getStatus()=='OK')
                {
                    
                    DOM.Document rtn_file = new DOM.Document();
                    rtn_file.load(res.getBody());
                    DOM.Document reply = new DOM.Document();
                    
                    String innerMessage = rtn_file.getRootElement().getChildElement('Body','http://schemas.xmlsoap.org/soap/envelope/').getChildElement('leadAddResponse','http://listloader.system.intelliqueue').getChildElement('leadAddReturn',NULL).getText();
                    reply.load(stripCData(innerMessage));
                    
                    if(reply.getRootElement().getChildElement('status',NULL).getText()!='OK')
                    {
                        String status=reply.getRootElement().getChildElement('status',NULL).getText();
                        String message=reply.getRootElement().getChildElement('message',NULL).getText();
                        String detail=reply.getRootElement().getChildElement('detail',NULL).getText();
                        
                        throw new customException(status+' '+message+' '+detail);
                    }
                    
                }
                else{ throw new customException('Error'); }
            }
          }
          catch(Exception e){
             throw new customException(e.getMessage()+' @ Line Number '+e.getLineNumber());
          }
       }
       
       public void remove(String campaignId, List<Contact> dataSet){
        try
        {
            if(dataSet==NULL || dataSet.size()==0){ return; }
            
            
            string xml=NULL;
            
            DOM.Document doc = new DOM.Document();
            
            doc.load('<?xml version="1.0" encoding="utf-16"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" '+
                     'xmlns:tns="http://listloader.system.intelliqueue" xmlns:types="http://listloader.system.intelliqueue/encodedTypes" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
                     'xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><tns:leadRemove><strXml xsi:type="xsd:string"></strXml>'+
                     '</tns:leadRemove></soap:Body></soap:Envelope>');
            
            dom.XmlNode strXml = doc.getRootElement().getChildElement('Body','http://schemas.xmlsoap.org/soap/envelope/').getChildElement('leadRemove','http://listloader.system.intelliqueue').getChildElement('strXml',NULL);
            
            DOM.Document data_file = new DOM.Document();
            
            dom.XmlNode lead_add = data_file.createRootElement('lead_remove', null, null);
            dom.XmlNode metadata = lead_add.addChildElement('metadata', null, null);
            metadata.addChildElement('security_key', null, null).addTextNode(security_keys.get(campaignId));
            metadata.addChildElement('campaign_id', null, null).addTextNode(campaignId);
            
            dom.XmlNode leads = lead_add.addChildElement('leads', null, null);
            
            for(Contact c :dataSet)
            {
                Map<String,String> p = getPhoneNumber(c.phone,c.Affiliation_Code__c);
                
                if(p.get('local')!=NULL)
                {
                    dom.XmlNode lead = leads.addChildElement('lead', null, null);
                    
                    String ExtId = c.id;
                    lead.setAttribute('extern_id', ExtId.left(15));
                    lead.setAttribute('phone', p.get('local'));
                }
            }
            
            String list_data=data_file.toXmlString();
            
            strXml.addTextNode(list_data);
            
            xml = doc.toXmlString();
            
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint('http://www.virtualacd.biz/intelliqueue/system/listloader/ListLoader.cfc');
            req.setMethod('POST');
            req.setHeader('Content-Type','text/xml; charset=UTF-8');
            req.setHeader('SOAPAction','');
            req.setBody(xml);
            
            system.debug(this.stripCdata(xml));
            
            if(leads.getChildElements().size()>0 || Test.isRunningTest())
            {
                Http http = new Http();
                
                HttpResponse res = http.send(req);
                
                if(res.getStatus()=='OK')
                {
                    DOM.Document rtn_file = new DOM.Document();
                    rtn_file.load(res.getBody());
                    DOM.Document reply = new DOM.Document();
                    
                    String innerMessage = rtn_file.getRootElement().getChildElement('Body','http://schemas.xmlsoap.org/soap/envelope/').getChildElement('leadRemoveResponse','http://listloader.system.intelliqueue').getChildElement('leadRemoveReturn',NULL).getText();
                    reply.load(stripCdata(innerMessage));
                    
                    if(reply.getRootElement().getChildElement('status',NULL).getText()!='OK')
                    {
                        String status=reply.getRootElement().getChildElement('status',NULL).getText();
                        String message=reply.getRootElement().getChildElement('message',NULL).getText();
                        String detail=reply.getRootElement().getChildElement('detail',NULL).getText();
                        
                        throw new customException(status+' '+message+' '+detail);
                    }
                }
                else{ throw new customException('Error'); }
              }
          }
          catch(Exception e){
             throw new customException(e.getMessage()+' @ Line Number '+e.getLineNumber());
          }
       }
       public String stripCdata(String str) {
            Pattern p = Pattern.compile('<!\\[CDATA\\[(.*?)\\]\\]>');
            Matcher m = p.matcher(str);
            while(m.find()) {
                str = str.replace(m.group(), m.group(1).escapeXml());
            }
            return str;
       }
       public static boolean isLocal(String code){
           boolean rtn=false;
           if(code==NULL || (code!=NULL && !code.startsWith('INTL'))){
               rtn=true;
           }
           return rtn;
       }
       public static map<string,string> getPhoneNumber(String p, String code)
       {
           map<string,string> phone = new map<string,string>();
           
           if(p!=NULL && p.replaceAll('[^0-9]+', '')!='' && p.replaceAll('[^0-9]+', '').length()<19)
           {
               p=String.ValueOf(Long.ValueOf(p.replaceAll('[^0-9]+', '')));
               
               if(p.length()==10){
                   phone.put('local',p);
               }
               else if(isLocal(code) && p.length()==11 && p.substring(0,1)=='1'){
                   phone.put('local',p.substring(1,11));
               }
               else{ phone.put('international',p); }
           }
           else { phone.put('invalid',p); }
           return phone;
       }
    public void sendEmail(String errorMessage){              
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         String[] toAddresses = new String[] {'jkottahachchige@lafilm.edu'};
         mail.setToAddresses(toAddresses);
         mail.setReplyTo('jkottahachchige@lafilm.edu');  
         mail.setSenderDisplayName('Apex error message');
         mail.setSubject('TOG Errors');
         mail.setPlainTextBody(errorMessage);
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}