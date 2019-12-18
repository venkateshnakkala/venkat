public class DocAPI implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful 
{
    public class MyException extends Exception {}

    protected Map<String,Map<String,String>> statusSFtoCV{get;set;}
    private List<Id> AppId{get;set;}
        
    public Map<Integer,Document> sfDocs{get;set;}
    public Map<Integer,Document> cvDocs{get;set;}

    public DocAPI(List<Id> AId)
    {
        this.AppId=AId;
        
        DateTime DT= System.Now();
        String now=DT.Format('yyyy-MM-dd\'T\'HH:mm:ss');
        
        this.statusSFtoCV = new Map<String,Map<String,String>>();
        
        // keep the DocumentStatus at the end of other date fields
        this.statusSFtoCV.put('Out for Signature', New Map<String,String>{'DateSent'=>now, 'DocumentStatus'=>'SENT'});
        this.statusSFtoCV.put('Received', New Map<String,String>{'DateRecieved'=>now, 'DocumentStatus'=>'RECVD'});
        this.statusSFtoCV.put('Signed', New Map<String,String>{'DateApproved'=>now, 'DateSigned'=>now, 'DocumentStatus'=>'OK'});
        this.statusSFtoCV.put('Cancelled / Declined', New Map<String,String>{'DocumentStatus'=>'REJ'});
        
        this.sfDocs = new Map<Integer,Document>();
        this.cvDocs = new Map<Integer,Document>();
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([Select id, Name, echosign_dev1__Status__c, echosign_dev1__DateSent__c, echosign_dev1__DateSigned__c, Application__r.AdEnrollId__c, Application__r.Student__r.SyStudentId__c From echosign_dev1__SIGN_Agreement__c where Application__r.id IN :AppId and echosign_dev1__Status__c in :statusSFtoCV.keySet() and Name like '%[%' and Application__r.AdEnrollId__c!=NULL and Application__r.Student__r.SyStudentId__c!=NULL order by name, id]);
    }
    
    public void execute(Database.BatchableContext bc, List<echosign_dev1__SIGN_Agreement__c> Agreements) 
    {
        for(echosign_dev1__SIGN_Agreement__c a :Agreements)
        {
            String Type=this.getDocType(a.Name);
            
            if(Type!=NULL)
            {
                Document d = new Document(Type, a);
                
                // if duplicate document requested, get the latest document
                if(!(sfDocs.containsKey(d.code) && sfDocs.get(d.code).SfId>d.SfId)){ sfDocs.put(d.Code,d); }
            }
        }
        
        for(Integer c :sfDocs.keySet())
        {
            Document sfd=sfDocs.get(c);
            cvDocs=this.getDocuments(sfd.AdEnrollId);
                
            if(!cvDocs.containsKey(c))
            {
                Boolean result=this.AddDocument(sfd);
            }
            else if(cvDocs.get(c).toUpdate(sfd))
            {
                Boolean result=this.UpdateDocument(cvDocs.get(c).DocId, sfd);
            }
        }
    }
    
    public void finish(Database.BatchableContext bc) {  }
    
    public class Document
    {
        public Integer Code{get; private set;}
        public string Type{get;set;}
        public string Status{get;set;}
        public Id SfId{get;set;}
        public Integer DocId{get;set;}
        public Integer SyStudentId{get;set;}
        public Integer AdEnrollId{get;set;}
        
        public DateTime DateSent{get;set;}
        public DateTime DateSigned{get;set;}
        
        private DocAPI Parent;
        
        public Document(Object T, Object S, Object I, Object AdId)
        {
            // CV Document
            this.parent = new DocApi(NULL);
            
            if(T!=NULL)
            {
                this.Type=String.ValueOf(T).Trim();
                String h;
                h=String.ValueOf(AdId);
                h+='~'+Type.Trim().toLowerCase();
                this.Code=h.hashCode();
            }
            this.Status=(S==NULL)?NULL:String.ValueOf(S).Trim();
            this.DocId=Integer.ValueOf(I);
            this.AdEnrollId=Integer.ValueOf(AdId);
        }
        
        public Document(String T, echosign_dev1__SIGN_Agreement__c a)
        {
            // SF Document
            this.parent = new DocApi(NULL);
            
            String S=a.echosign_dev1__Status__c;
            
            this.DateSent=a.echosign_dev1__DateSent__c;
            this.DateSigned=a.echosign_dev1__DateSigned__c;
            
            if(T!=NULL)
            {     
                this.Type=T.Trim();
                String h;
                h=String.ValueOf(a.Application__r.AdEnrollId__c.intValue());
                h+='~'+Type.Trim().toLowerCase();
                this.Code=h.hashCode();
            }
            
            if(S!=NULL){
                this.Status=(S==NULL)?NULL:String.ValueOf(S).Trim();
            }
            this.SfId=a.Id;
            this.SyStudentId=Integer.ValueOf(a.Application__r.Student__r.SyStudentId__c);
            this.AdEnrollId=Integer.ValueOf(a.Application__r.AdEnrollId__c);
        }

        public boolean toUpdate(Document d)
        {
            boolean rtn=false;
            
            String Status1;
            String Status2;
            
            if(parent.statusSFtoCV.containsKey(d.Status) && parent.statusSFtoCV.get(d.Status).containsKey('DocumentStatus'))
            {
                Status1=String.ValueOf(parent.statusSFtoCV.get(d.Status).get('DocumentStatus'));
                Status2=this.Status;
            }
            else if(parent.statusSFtoCV.containsKey(this.Status) && parent.statusSFtoCV.get(this.Status).containsKey('DocumentStatus'))
            {
                Status1=String.ValueOf(parent.statusSFtoCV.get(this.Status).get('DocumentStatus'));
                Status2=d.Status;
            }
            
            if(Status1!=Status2){
                rtn=true;
            }
            
            return rtn;
        }
    }
    
    public Map<Integer,Document> getDocuments(Integer AdEnrollId)
    {
        Map<Integer,Document> docs = new Map<Integer,Document>();
        
        try{
            Dom.Document xml = new Dom.Document();
            
            if(Test.isRunningTest()){
                Test.setMock(WebServiceMock.class, new CVAPI_Test.CV_Foundation_Impl());
            }
            
            CVAPI token = new CVAPI();
            string myToken=token.getTokenId();
            
            if(Test.isRunningTest()){
                Test.setMock(HttpCalloutMock.class, new DocAPITest.GetDocumentsResponse());
            }
            string msg='<?xml version="1.0" encoding="utf-16"?>'+
                       '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'+
                       '<soap:Body><GetDocuments xmlns="http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd">'+
                       '<request>'+
                       '<TokenId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">'+myToken+'</TokenId>'+
                       '<GetDocumentsInMsgs xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Wcf.Messages.Crm">'+
                       '<GetDocumentsInMsg>'+
                       '<CorrelationId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">0</CorrelationId>'+
                       '<CustomAttributes xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">'+
                       '<CustomAttributeMsg><Name /><Value /></CustomAttributeMsg>'+
                       '</CustomAttributes>'+
                       '<MessageState xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" />'+
                       '<CampusInclusionList>'+
                       '<string xmlns="http://schemas.microsoft.com/2003/10/Serialization/Arrays" />'+
                       '</CampusInclusionList>'+
                       '<DocumentExclusionList>'+
                       '<string xmlns="http://schemas.microsoft.com/2003/10/Serialization/Arrays" />'+
                       '</DocumentExclusionList>'+
                       '<DocumentInclusionList>'+
                       '<string xmlns="http://schemas.microsoft.com/2003/10/Serialization/Arrays" />'+
                       '</DocumentInclusionList>'+
                       '<EnrollmentId>'+AdEnrollId+'</EnrollmentId>'+
                       '<UserExclusionList>'+
                       '<string xmlns="http://schemas.microsoft.com/2003/10/Serialization/Arrays" />'+
                       '</UserExclusionList>'+
                       '</GetDocumentsInMsg>'+
                       '</GetDocumentsInMsgs>'+
                       '</request>'+
                       '</GetDocuments>'+
                       '</soap:Body>'+
                       '</soap:Envelope>';
            xml.load(msg);
            
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setEndpoint('https://campuslink.lafilm.edu/Cmc.Integration.Webservices.Wcf/DocumentsService.svc'); //
            req.setHeader('Content-Type', 'text/xml');
            req.setHeader('SOAPAction','http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd/IDocuments/GetDocuments');
            req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
            req.setBodyDocument(xml);
            
            Http http = new Http();
            
            HttpResponse res = http.send(req);
    
            dom.Document resDoc = res.getBodyDocument();
            dom.xmlNode x=resDoc.getRootElement();
            
            JSONGenerator js = JSON.createGenerator(true);
            js=XMLTOJSON(x, js);
            Map<String, Object> tt =(Map<String, Object>)JSON.deserializeUntyped(js.getAsString());
            
            /**************************************/
            /*
            String reply=resDoc.toXmlString();
            Integer batchsize=300;
            Integer size =(Integer)Math.ceil(reply.length()/(batchsize*1.0));
            
            for(Integer i=0; i<size; i++){
                Integer s=i*batchsize;
                integer e=((i+1)*batchsize);
                e=(e>reply.length())?reply.length():e;
                
                system.debug(reply.substring(s, e));
            }
            */
            /**************************************/
            
            String[] narrower = new String[] {'Envelope','Body','GetDocumentsResponse','GetDocumentsResult','GetDocumentsOutMsgs','GetDocumentsOutMsg','Documents'};
            
            List<Map<String,Object>> rtn = new List<Map<String,Object>>();
            rtn = extractData(tt,narrower);
            
            for(Object s :rtn)
            {
               Map<String,Object> obj = new Map<String, Object>();
               obj.putAll((Map<String, Object>) s);
               
               Map<String,Object> fields= new Map<String, Object>();
               
               if(obj.containsKey('DocumentFields')){
                    fields.putAll((Map<String, Object>) obj.get('DocumentFields'));
               } else {
                   fields.putAll((Map<String, Object>) obj);
               }
               
               Document d = new Document(fields.get('DocumentType'), fields.get('DocumentStatus'), fields.get('DocumentId'), fields.get('EnrollmentId'));
               
               // if duplicate document requested, get the latest document
               if(!(docs.containsKey(d.code) && docs.get(d.code).DocId>d.DocId)){ docs.put(d.Code,d); }
            }
        }
        catch(Exception e){
            throw new MyException(e.getMessage()+' @Line# '+e.getLineNumber());
        }
        return docs;
   }
   
   public boolean UpdateDocument(Integer DocumentId, Document d)
   {
        boolean rtn=false;
        try{   
            Dom.Document xml = new Dom.Document();
            
            if(Test.isRunningTest()){
                Test.setMock(WebServiceMock.class, new CVAPI_Test.CV_Foundation_Impl());
            }
            
            CVAPI token = new CVAPI();
            string myToken=token.getTokenId();
            
            if(Test.isRunningTest()){
                Test.setMock(HttpCalloutMock.class, new DocAPITest.UpdateDocumentResponse());
            }
            
            string msg='<?xml version="1.0" encoding="utf-16"?>'+
                       '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'+
                       '<soap:Body><UpdateDocuments xmlns="http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd">'+
                       '<request><TokenId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">'+myToken+'</TokenId>'+
                       '<UpdateDocumentsInMsgs xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Wcf.Messages.Crm"><UpdateDocumentsInMsg>'+
                       '<CorrelationId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">0</CorrelationId>'+
                       '<CustomAttributes xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">'+
                       '<CustomAttributeMsg><Name /><Value /></CustomAttributeMsg></CustomAttributes>'+
                       '<MessageState xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" />'+
                       '<DocumentId>'+DocumentId+'</DocumentId><DocumentMsgDetail>'+
                       '<AwardYear xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />'+
                       '<Comments xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />';
                       
            if(d.DateSent!=NULL){ msg+='<DateSent xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm">'+d.DateSent+'</DateSent>';}
            if(d.DateSigned!=NULL){ msg+='<DateSigned xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm">'+d.DateSigned+'</DateSigned>';}
            
            if(statusSFtoCV.containsKey(d.Status))
            {
                for(String fieldName :statusSFtoCV.get(d.Status).keySet())
                {
                    String fieldValue=statusSFtoCV.get(d.Status).get(fieldName);
                    
                    if((!(fieldValue=='DateSent' && d.DateSent==NULL) || (fieldValue=='DateSigned' && d.DateSigned==NULL)))
                    {
                        msg+='<'+fieldName+' xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm">'+fieldValue+'</'+fieldName+'>';
                    }
                }
            }
            else{
                throw new MyException('Invalid Status !!! '+d.Status);
            }
            msg+='<DocumentType xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />'+
                '<FileNameWithPath xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />'+
                '<ImagingSystemId xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />'+
                '<WorkflowInstanceId xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />'+
                '</DocumentMsgDetail></UpdateDocumentsInMsg></UpdateDocumentsInMsgs></request>'+
                '</UpdateDocuments></soap:Body></soap:Envelope>';
            xml.load(msg);
            
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setEndpoint('https://campuslink.lafilm.edu/Cmc.Integration.Webservices.Wcf/DocumentsService.svc'); //
            req.setHeader('Content-Type', 'text/xml');
            req.setHeader('SOAPAction','http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd/IDocuments/UpdateDocuments');
            req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
            req.setBodyDocument(xml);
            
            Http http = new Http();
            HttpResponse res = http.send(req);
            dom.Document resDoc = res.getBodyDocument();
            dom.xmlNode x=resDoc.getRootElement();
            
            List<Map<String,Object>> rtnData = new List<Map<String,Object>>();
            
            JSONGenerator js = JSON.createGenerator(true);
            js=XMLTOJSON(x, js);
            Map<String, Object> tt =(Map<String, Object>)JSON.deserializeUntyped(js.getAsString());
            
            /**************************************/
            /*
            system.debug('******************** Input ********************');
            Integer batchsize=300;
            Integer size =(Integer)Math.ceil(msg.length()/(batchsize*1.0));
            
            for(Integer i=0; i<size; i++){
                Integer s=i*batchsize;
                integer e=((i+1)*batchsize);
                e=(e>msg.length())?msg.length():e;
                
                system.debug(msg.substring(s, e));
            }
            system.debug('******************** Output ********************');
            String reply=resDoc.toXmlString();
            size =(Integer)Math.ceil(reply.length()/(batchsize*1.0));
            
            for(Integer i=0; i<size; i++){
                Integer s=i*batchsize;
                integer e=((i+1)*batchsize);
                e=(e>reply.length())?reply.length():e;
                
                system.debug(reply.substring(s, e));
            }
            */
            /**************************************/
            
            String[] narrower = new String[] {'Envelope','Body','UpdateDocumentsResponse','UpdateDocumentsResult'};
            
            rtnData = extractData(tt,narrower);
            if(rtnData.size()>0 && rtnData[0].get('Status')=='OK'){
                rtn=true;
            }
            else
            {
                String[] err= new String[] {'Envelope','Body','UpdateDocumentsResponse','UpdateDocumentsResult','UpdateDocumentsOutMsgs','UpdateDocumentsOutMsg'};
                rtnData = extractData(tt,err);
                
                if(rtnData.size()>0){
                    throw new MyException(String.ValueOf(rtnData[0].get('MessageResult'))+', DocumentId:'+DocumentId+', Status:'+d.Status);
                }
            }
        }
        catch(Exception e){
            throw new MyException(e.getMessage()+' @Line# '+e.getLineNumber());
        }
        return rtn;
   }
   
    public boolean AddDocument(Document d)
    {
        Boolean rtn=false;
        try{      
            Dom.Document xml = new Dom.Document();
            
            if(Test.isRunningTest()){
                Test.setMock(WebServiceMock.class, new CVAPI_Test.CV_Foundation_Impl());
            }
            CVAPI token = new CVAPI();
            string myToken=token.getTokenId();
            
            if(Test.isRunningTest()){
                Test.setMock(HttpCalloutMock.class, new DocAPITest.AddDocumentResponse());
            }
            
            DateTime DT= System.Now();
            String now=DT.Format('yyyy-MM-dd\'T\'HH:mm:ss');
            
            string msg= '<?xml version="1.0" encoding="UTF-8" ?>'+
                        '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'+
                        '<soap:Body><AddDocuments xmlns="http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd">'+
                        '<request><TokenId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">'+myToken+'</TokenId>'+
                        '<AddDocumentsInMsgs xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Wcf.Messages.Crm"><AddDocumentsInMsg>'+
                        '<CorrelationId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">0</CorrelationId>'+
                        '<CustomAttributes xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">'+
                        '<CustomAttributeMsg><Name /><Value /></CustomAttributeMsg></CustomAttributes>'+
                        '<MessageState xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" />'+
                        '<DocumentMsgDetail><AwardYear xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />'+
                        '<Comments xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />'+
                        '<DateRequested xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm">'+now+'</DateRequested>';
                        
            if(d.DateSent!=NULL){ msg+='<DateSent xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm">'+d.DateSent+'</DateSent>';}
            if(d.DateSigned!=NULL){ msg+='<DateSigned xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm">'+d.DateSigned+'</DateSigned>';}
            
            if(statusSFtoCV.containsKey(d.Status))
            {
                for(String fieldName :statusSFtoCV.get(d.Status).keySet())
                {
                    String fieldValue=statusSFtoCV.get(d.Status).get(fieldName);
                    
                    if((!(fieldValue=='DateSent' && d.DateSent==NULL) || (fieldValue=='DateSigned' && d.DateSigned==NULL)))
                    {
                        msg+='<'+fieldName+' xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm">'+fieldValue+'</'+fieldName+'>';
                    }
                }
            }
            msg+='<DocumentType xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm">'+d.Type+'</DocumentType>'+
                 '<EnrollId xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm">'+d.AdEnrollId+'</EnrollId>'+
                 '<StudentId xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm">'+d.SyStudentId+'</StudentId>'+
                 '<FileNameWithPath xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />'+
                 '<ImagingSystemId xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />'+
                 '<WorkflowInstanceId xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Crm" />'+
                 '</DocumentMsgDetail></AddDocumentsInMsg></AddDocumentsInMsgs></request></AddDocuments>'+
                 '</soap:Body></soap:Envelope>';
            xml.load(msg);
            
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setEndpoint('https://campuslink.lafilm.edu/Cmc.Integration.Webservices.Wcf/DocumentsService.svc'); //
            req.setHeader('Content-Type', 'text/xml');
            req.setHeader('SOAPAction','http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd/IDocuments/AddDocuments');
            req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
            req.setBodyDocument(xml);
            
            Http http = new Http();
            HttpResponse res = http.send(req);
            
            dom.Document resDoc = res.getBodyDocument();
            dom.xmlNode x=resDoc.getRootElement();
            
            /**************************************/
            /*
            system.debug('******************** Input ********************');
            Integer batchsize=300;
            Integer size =(Integer)Math.ceil(msg.length()/(batchsize*1.0));
            
            for(Integer i=0; i<size; i++){
                Integer s=i*batchsize;
                integer e=((i+1)*batchsize);
                e=(e>msg.length())?msg.length():e;
                
                system.debug(msg.substring(s, e));
            }
            system.debug('******************** Output ********************');
            String reply=resDoc.toXmlString();
            size =(Integer)Math.ceil(reply.length()/(batchsize*1.0));
            
            for(Integer i=0; i<size; i++){
                Integer s=i*batchsize;
                integer e=((i+1)*batchsize);
                e=(e>reply.length())?reply.length():e;
                
                system.debug(reply.substring(s, e));
            }
            */
            /**************************************/
            
            List<Map<String,Object>> rtnData = new List<Map<String,Object>>();
            JSONGenerator js = JSON.createGenerator(true);
            
            js=XMLTOJSON(x, js);
            
            Map<String, Object> tt =(Map<String, Object>)JSON.deserializeUntyped(js.getAsString());
            
            String[] narrower = new String[] {'Envelope','Body','AddDocumentsResponse','AddDocumentsResult'};
            
            rtnData = extractData(tt,narrower);
            if(rtnData.size()>0 && rtnData[0].get('Status')=='OK'){
                rtn=true;
            }
            else
            {
                String[] err= new String[] {'Envelope','Body','AddDocumentsResponse','AddDocumentsResult','AddDocumentsOutMsgs','AddDocumentsOutMsg'};
                rtnData = extractData(tt,err);
                
                if(rtnData.size()>0){
                    throw new MyException(String.ValueOf(rtnData[0].get('MessageResult'))+', AdEnrollId:'+d.AdEnrollId+', Document:'+d.Code+', Status:'+d.Status);
                }
            }
        }
        catch(Exception e){
            throw new MyException(e.getMessage()+' @Line# '+e.getLineNumber());
        }
        return rtn;
   }
   
   public string getDocType(String name)
   {
        String rtn=NULL;
        Matcher m = Pattern.compile('\\[(.*?)\\]').matcher(name);
        while(m.find()){
            rtn=m.group(1).trim();
        }
        return rtn;
   }
    
   public JSONGenerator XMLTOJSON(dom.xmlNode element, JSONGenerator js)
   {
        List<dom.xmlNode> children = new List<dom.xmlNode>();
        children = element.getChildElements();
        
        if(element.getNodeType()==dom.XmlNodeType.ELEMENT && children.size()==1){
            js.writeStartObject();
            js.writeFieldName(element.getName());
            
            js=XMLTOJSON(children[0], js);
            js.writeEndObject();
        }
        else if(element.getNodeType()==dom.XmlNodeType.ELEMENT && children.size()>1){
            js.writeStartObject();
            js.writeFieldName(element.getName());
            js.writeStartObject();
            
            for(dom.xmlNode child :children){
                if(child.getChildElements().size()>0){
                    Map<String,Integer> lable = new Map<String,Integer>();
                    Integer count=0;
                    Boolean arrayStart=false;
                    
                    for(dom.xmlNode n :child.getChildElements()){
                        if(lable.containsKey(n.getName())){
                            count=lable.get(n.getName());
                        }
                        lable.put(n.getName(),count+1);
                    }
                    
                    count=0;
                    for(String key :lable.keySet()){count+=lable.get(key);}
                    js.writeFieldName(child.getName());
                    
                    if(count/lable.keySet().size()>1){
                        js.writeStartArray();
                        arrayStart=true;
                    }
                    
                    for(dom.xmlNode gc: child.getChildElements()){
                        js=XMLTOJSON(gc, js);
                    }
                    
                    if(arrayStart){
                        arrayStart=false;
                        js.writeEndArray();
                    }
                }
                else
                {
                    js.writeStringField(child.getName(), child.getText());
                }
            }
            js.writeEndObject();
            js.writeEndObject();
        }
        else if(element.getNodeType()==dom.XmlNodeType.ELEMENT && children.size()==0){
            js.writeStartObject();
            js.writeStringField(element.getName(), element.getText());
            js.writeEndObject();
        }
        return js;
    }
    
    public List<Map<String,Object>> extractData(Map<String, Object> js, List<String> narrower)
    {
       List<Map<String,Object>> rtn = new List<Map<String,Object>>();
       try{
           if(narrower.size()==1){
                List<Object> obj= new List<Object>();
                
                if(js.containsKey(narrower[0])){
                    if(js.get(narrower[0]) instanceof List<Object>){
                        obj = (List<Object>)js.get(narrower[0]);
                        for(Object j :obj){
                            Map<String,Object> xx = (Map<String,Object>) j;
                            
                            for(String s1: xx.keyset()){
                                rtn.add((Map<String,Object>)xx.get(s1));
                            }
                        }
                    }
                    else if(js.get(narrower[0]) instanceof Map<String,Object>){
                         rtn.add((Map<String,Object>)js.get(narrower[0]));
                    }
                    else{
                        rtn.add(new Map<String,Object>{narrower[0]=>js.get(narrower[0])});
                    }
                }
                else{
                    rtn=NULL;
                }
           }
           else if(narrower.size()>1){
               if(js.containsKey(narrower[0])){
                   js=(Map<String,Object>)js.get(narrower[0]);
                   narrower.remove(0);
                   rtn=extractData(js,narrower);
               }
               else{
                   rtn=NULL;
               }
           }
       }
       catch(Exception e){
           throw e;
       }
       return rtn;
    }
}