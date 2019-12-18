global Class CVAPI{
    public class newException extends Exception {}

    public String tokenId{get;set;}
    public JSONGenerator js{get;set;}
    
    public Map<String,Map<String,Integer>> settings{get;set;}
    public Map<String,Map<String,Integer>> settings2{get;set;}
    
    public DateTime localTime{get;set;}
    
    private application__c app{get;set;}
    
    class codes{
        public string code{get;set;}
        public integer id{get;set;}
        public string code2{get;set;}
        
        codes(String c, Integer i)
        {
            this.code=c;
            this.id=i;
        }
        
        codes(String c, Integer i, String c2){
            this.code=c;
            this.id=i;
            this.code2=c2;
        }
    }
            
    public CVAPI(){
        this.tokenId=this.getTokenId();
        settings= new Map<String,Map<String,Integer>>();
        settings2= new Map<String,Map<String,Integer>>();
        this.readSettings();
        //system.debug(this.tokenId);
        js = JSON.createGenerator(true);
        
        Datetime now = Datetime.now();
        Integer offset = UserInfo.getTimezone().getOffset(now);

        this.localTime = now.addSeconds(offset/1000);
    }
    
    public string getTokenId(){
        try {
            CV_Foundation.AuthenticationSoap token_service = new CV_Foundation.AuthenticationSoap();
            CV_Message_Definition.TokenRequest token_request = new CV_Message_Definition.TokenRequest();
            CV_Message_Definition.TokenResponse token_response = new CV_Message_Definition.TokenResponse();
            
            String tokenId=NULL;
            
            token_request.UserName='cvapi.salesforce@lafilm.com';
            token_request.Password='Ah-Acc-Inj#30W-';
            token_request.TokenNeverExpires=true;
            token_response = token_service.GetAuthorizationToken(token_request);
            
            if(token_response.Status=='Ok'){
                tokenId=token_response.TokenId;
            }
            else if(token_response.trxResult!=NULL){
                throw new newException(token_response.trxResult);
            }
            return tokenId;
         }
         catch(Exception e){
             throw e;
         }
    }
    
    public CV_Student_Definition.GetStudentOutMsg getStudentInfo(Integer SyStudentId){
        if(Test.isRunningTest()){
            Test.setMock(WebServiceMock.class, new CVAPI_Test.CV_getStudentInfo_Impl());
        }
        List<Integer> ids = new List<Integer>();
        ids.add(SyStudentId);
        List<CV_Student_Definition.GetStudentOutMsg>  l = getStudentInfo(ids);
        
        if(l.size()>0)
            return l[0];
        else
            return null;
    }
    
    public List<CV_Student_Definition.GetStudentOutMsg> getStudentInfo(List<Integer> SyStudentIds){
        CV_Student_Definition.GetStudentInfoResponse response = new CV_Student_Definition.GetStudentInfoResponse();
        CV_Student.StudentWebServiceSoap service = new CV_Student.StudentWebServiceSoap();
        CV_Student_Definition.GetStudentInfoRequest request = new CV_Student_Definition.GetStudentInfoRequest();
        request.tokenId=this.tokenId;
        
        CV_Student_Definition.ArrayOfGetStudentInMsg students = new CV_Student_Definition.ArrayOfGetStudentInMsg();
        students.GetStudentInMsg = new CV_Student_Definition.GetStudentInMsg[]{};
        
        for(Integer s :SyStudentIds){
            CV_Student_Definition.GetStudentInMsg student = new CV_Student_Definition.GetStudentInMsg();
            student.studentId=s;
            students.GetStudentInMsg.add(student);
        }
        request.students=students;
        
        response=service.GetStudentInfo(request);
        
        List<CV_Student_Definition.GetStudentOutMsg> studentsSet = new List<CV_Student_Definition.GetStudentOutMsg>();
        if(response.Status=='Ok'){
            CV_Student_Definition.ArrayOfGetStudentOutMsg studentsArray = new CV_Student_Definition.ArrayOfGetStudentOutMsg();
            studentsArray=response.Students;
            
            for(CV_Student_Definition.GetStudentOutMsg stu :studentsArray.GetStudentOutMsg){
                studentsSet.add(stu);
            }
        }
        
        return studentsSet;
    }
    
    public boolean updateStudentInfo(CV_Student_Definition.UpdateStudentLeadInMsg student){
        try{
            List<CV_Student_Definition.UpdateStudentLeadInMsg> students = new List<CV_Student_Definition.UpdateStudentLeadInMsg>();
            students.add(student);
            return updateStudentInfo(students);
        }
        catch(Exception e){
            throw e;
        }
    }
    
    public boolean updateStudentInfo(List<CV_Student_Definition.UpdateStudentLeadInMsg> stu)
    {
        try{
            
            if(Test.isRunningTest()){
                Test.setMock(WebServiceMock.class, new CVAPI_Test.CV_Student_Impl_3());
            }
            CV_Student.StudentWebServiceSoap service = new CV_Student.StudentWebServiceSoap();
            CV_Student_Definition.PostStudentLeadResponse response = new CV_Student_Definition.PostStudentLeadResponse();
            
            CV_Student_Definition.PostStudentLeadRequest request = new CV_Student_Definition.PostStudentLeadRequest();
            request.tokenId=this.tokenId;
            
            CV_Student_Definition.ArrayOfUpdateStudentLeadInMsg students = new CV_Student_Definition.ArrayOfUpdateStudentLeadInMsg();
            students.UpdateStudentLeadInMsg = new CV_Student_Definition.UpdateStudentLeadInMsg[]{};
            
            for(CV_Student_Definition.UpdateStudentLeadInMsg s :stu)
            {
                students.UpdateStudentLeadInMsg.add(s);
            }
            
            request.UpdateStudentLeads=students;
    
            response = service.PostStudentLead(request);
            Boolean rtn=false;
            
            if(response.status=='OK'){
                rtn=true;
            }
            else if(response.UpdateStudentLeads!=NULL && response.UpdateStudentLeads.UpdateStudentLeadOutMsg[0].MessageResult!=NULL){
                throw new NewException(response.UpdateStudentLeads.UpdateStudentLeadOutMsg[0].MessageResult);
            }
                
            return rtn;
        }
        catch(Exception e){
            throw e;
        }
    }
    
    private integer getGender(String gender){
        integer rtn=7;
        Map<String,Integer> allGender = new Map<String,Integer>();
        allGender.put('male',6);
        allGender.put('m',6);
        allGender.put('female',5);
        allGender.put('f',5);
        
        if(gender!=NULL && allGender.containsKey(gender.toLowerCase())){
            rtn=allGender.get(gender.toLowerCase());
        }
        return rtn;
    }

    public Map<Id,Integer> InsertNewStudent(Id studentIds, Application__c app)
    {
        List<Contact> con = [select id, owner.email, firstname, lastname, email, phone, ssn__c, Birthdate, expected_start_date__c, mailingaddress, gender__c, lead_source_code__c, 
                            nationality__c, citizenship_status__c, affiliation_code__c, Alien_Registration_Number__c, Previous_Education_Codes__c, Ethnicity__c from contact where id=:studentIds];
                            
        
        Map<Integer,Id> contactId = new Map<Integer,Id>();
        List<CV_Lead_Definition.LeadInMsg> students = new List<CV_Lead_Definition.LeadInMsg>();
        
        for(Contact c :con)
        {
            contactId.put(hash(c.firstname+' '+c.lastname),c.id);
            
            CV_Lead_Definition.LeadInMsg student = new CV_Lead_Definition.LeadInMsg();
            student.CorrelationId = 1;
            student.VerifiedLead = true;
            
            student.FirstName=c.firstname;
            student.LastName=c.lastname;
            student.email=c.email;
            student.phone=phone(c.phone);
            student.ssn=ssn(c.ssn__c);
            student.birthdate=c.birthdate;
            student.expectedStartDate=c.expected_start_date__c;
            if(c.mailingAddress!=NULL)
            {
                student.Address=c.mailingAddress.getStreet();
                student.City=c.mailingAddress.getCity();
                student.PostalCode=c.mailingAddress.getPostalCode();
                student.StateId=getStateId(c.mailingAddress.getState(),getCountryId(c.mailingAddress.getCountry()));
                student.CountryId=getCountryId(c.mailingAddress.getCountry());
                
                if(student.CountryId!=1){
                    student.SkipSemanticValidation=true;
                }
            }
            student.SchoolStatusId=1;
            student.CampusId = 5;
            student.GenderId=getGender(c.gender__c);
            student.NationalityId=this.getNationality(c.nationality__c); 
            student.CitizenshipId=this.getCitizenship(c.citizenship_status__c);
            
            Integer rep=this.getAdminRep(c.owner.email);
            student.AdmissionsOfficerId=rep;
            
            student.LeadDate=localTime;
            student.LeadSourceId=this.getLeadSource(c.lead_source_code__c);
            
            
            student.LeadTypeId=42; // Submitted Application
            student.AlienRegistrationNumber=c.Alien_Registration_Number__c;
            student.PreviousEducationId=this.getPrevEducId(c.Previous_Education_Codes__c, app); //Prev Education
            student.RaceIds=this.getRaceId(c.Ethnicity__c);   
            Integer AgencyId=this.getAffiliationId(c.affiliation_code__c);
            
            if(AgencyId!=NULL && AgencyId!=0){
                student.AgencyId=AgencyId; //Agency/Sponsor
            }
            student.IsVeteran=this.isVeteran(c.affiliation_code__c);
            student.HasDisability=(app.Disability_Accomodations__c==true)?'Yes':'No';
            
            student.CustomAttributes = new CV_Lead_Definition.ArrayOfCustomAttributeMsg();
            student.CustomAttributes.CustomAttributeMsg = new List<CV_Lead_Definition.CustomAttributeMsg>();
                CV_Lead_Definition.CustomAttributeMsg custom = new CV_Lead_Definition.CustomAttributeMsg();
                custom.name='SalesForceID';
                custom.value=c.id;
            student.CustomAttributes.CustomAttributeMsg.add(custom);
            
            students.add(student);
        }
        
        Map<Integer,Integer> stuNum = InsertNewStudent(students);

        Map<Id,Integer> syStudent = new Map<Id,Integer>();
        
        if(stunum!=NULL)
        {
            for(Integer name: stuNum.keySet())
            {
                if(contactId.containsKey(name)){
                    syStudent.put(contactId.get(name), stuNum.get(name));
                }
            }
        }
        return syStudent;
    }
    
    public Integer InsertNewStudent(CV_Lead_Definition.LeadInMsg student){
        List<CV_Lead_Definition.LeadInMsg> Students = new List<CV_Lead_Definition.LeadInMsg>();
        Map<Integer,Integer> result = new Map<Integer,Integer>();
        Students.add(student);
        result = InsertNewStudent(students);
        Set<Integer> x = result.keySet();
        Integer rtn;
        for(Integer s :x){
            rtn = result.get(s);
            break;
        }
        return rtn;
    }
    
    public Map<Integer,Integer> InsertNewStudent(List<CV_Lead_Definition.LeadInMsg> student){
        try {
            if(Test.isRunningTest()){
                Test.setMock(WebServiceMock.class, new CVAPI_test.CV_Lead_Impl_1 ());
            }
            
            CV_Lead.LeadsWebServiceSoap service = new CV_Lead.LeadsWebServiceSoap();
            CV_Lead_Definition.AddNewLeadResponse response = new CV_Lead_Definition.AddNewLeadResponse();
            CV_Lead_Definition.AddNewLeadRequest request = new CV_Lead_Definition.AddNewLeadRequest();
            request.tokenId=TokenId;
            request.IgnoreDuplicates=false;
            request.UseValidationTemplate=true;
            request.ValidationTemplateId=1;
            
            CV_Lead_Definition.ArrayOfLeadInMsg students = new CV_Lead_Definition.ArrayOfLeadInMsg();
            
            students.LeadInMsg = new CV_Lead_Definition.LeadInMsg[]{};

            for(CV_Lead_Definition.LeadInMsg l :student){
                students.LeadInMsg.add(l);
            }
            request.Leads=students;
            
            response = service.AddNewLead(request);
            //system.debug(response);
            
            Map<Integer,Integer> rtn = new Map<Integer,Integer>();
            
            if(response.status=='OK' && response.leads.LeadOutMsg!=NULL && response.leads.LeadOutMsg[0].VerifiedLead!=false) // data entered into SyStudent table
            {
                for(CV_Lead_Definition.LeadOutMsg m :response.leads.LeadOutMsg){
                    rtn.put(hash(m.firstname+' '+m.lastname),m.LeadId);
                }
            }
            else if(response.status=='OK' && response.leads.LeadOutMsg!=NULL && response.leads.LeadOutMsg[0].VerifiedLead==false) // data entered into AmElectronicLeads table
            {
                throw new newException('System found an error while migrating data for this record! Please make sure there are any duplicates in CampusNexus');
            }
            else if(response.leads!=NULL && response.leads.LeadOutMsg!=NULL) // there is an error
            {
                throw new newException((String)response.leads.LeadOutMsg[0].MessageResult);
            }
            
            return rtn; 
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<integer> addNewEnrollment(List<CV_Enroll_Definition.EnrollmentInMsg> enroll){
        List<integer> rtn = new List<integer>();
        try{
            if(Test.isRunningTest()){
                Test.setMock(WebServiceMock.class, new CVAPI_test.CV_Enroll_Impl_2 ());
            }
            CV_Enroll.EnrollmentWebServiceSoap service = new CV_Enroll.EnrollmentWebServiceSoap();
            CV_Enroll_Definition.AddNewEnrollmentResponse response = new CV_Enroll_Definition.AddNewEnrollmentResponse();
            CV_Enroll_Definition.AddNewEnrollmentRequest request = new CV_Enroll_Definition.AddNewEnrollmentRequest();
            request.tokenId=this.TokenId;
            
            request.Enrollments = new CV_Enroll_Definition.ArrayOfEnrollmentInMsg();
            request.Enrollments.EnrollmentInMsg = new CV_Enroll_Definition.EnrollmentInMsg[]{};
            
            for(CV_Enroll_Definition.EnrollmentInMsg en :enroll){
                request.Enrollments.EnrollmentInMsg.add(en);
            }
            
            response = service.AddNewEnrollment(request);
            
            
            if(response.status=='OK' && response.Enrollments.EnrollmentOutMsg!=NULL)
            {
                for(CV_Enroll_Definition.EnrollmentOutMsg e: response.Enrollments.EnrollmentOutMsg)
                {
                    rtn.add(e.EnrollmentId);
                }
            }
            else if(response.status!='OK'){
                if(response.Enrollments!=NULL && response.Enrollments.EnrollmentOutMsg!=NULL && response.Enrollments.EnrollmentOutMsg.size()>0){
                    throw new NewException(response.Enrollments.EnrollmentOutMsg[0].MessageResult);
                }
            }
        }
        catch(Exception e){
            throw e;
        }
        return rtn;
    }
    
    public List<Map<String,Object>> viewEnrollment(Integer syStudentId){
    List<Map<String,Object>> rtn = new List<Map<String,Object>>();
    try{
        Dom.Document xml = new Dom.Document();
        String msg ='<?xml version="1.0" encoding="utf-8"?>'+
                    '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'+
                    '<soap:Body><GetEnrollment xmlns="http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd"><request>'+
                    '<TokenId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">'+this.tokenId+'</TokenId>'+
                    '<GetEnrollmentInMessages xmlns="http://schemas.datacontract.org/2004/07/Cmc.Integration.Wcf.Messages.Academics">'+
                    '<GetEnrollmentInMsg><CorrelationId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">0</CorrelationId>'+
                    '<CustomAttributes xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common"><CustomAttributeMsg><Name /><Value /></CustomAttributeMsg>'+
                    '</CustomAttributes><MessageState xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" /><ApplicationDetail>false</ApplicationDetail>'+
                    '<CurrentEnrollment>NotSpecified</CurrentEnrollment><DocumentDetail>false</DocumentDetail><EnrollmentDetail>false</EnrollmentDetail>'+
                    '<EnrollmentType>ApplicantAndEnrollment</EnrollmentType><IncludeDocumentStatus /><ExDocumentStatus /><ExDocumentType />'+
                    '<StudentId>'+syStudentId+'</StudentId><StudentNumber /></GetEnrollmentInMsg></GetEnrollmentInMessages></request></GetEnrollment></soap:Body></soap:Envelope>';
        xml.load(msg);
        Dom.XmlNode[] childrens = xml.getRootElement().getChildElements();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');

        req.setEndpoint('https://campuslink.lafilm.edu/Cmc.Integration.Webservices.Wcf/GetEnrollment.svc?singleWsdl'); //
        req.setHeader('Content-Type', 'text/xml');
        req.setHeader('SOAPAction','http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd/IGetEnrollment/GetEnrollment');
        req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
        req.setBodyDocument(xml);
        Http http = new Http();
        HttpResponse res = http.send(req);

        dom.Document resDoc = res.getBodyDocument();
        
        dom.xmlNode x=resDoc.getRootElement();
        XMLTOJSON(x);
        
        Map<String, Object> tt =(Map<String, Object>)JSON.deserializeUntyped(js.getAsString());
        String[] narrower = new String[] {'Envelope','Body','Fault'};
        
        rtn = extractData(tt,narrower);
        
        if(rtn!=NULL && rtn[0].containsKey('faultstring')){
            throw new newException((String)rtn[0].get('faultstring'));
        }
        else
        {
            narrower = new String[] {'Envelope','Body','GetEnrollmentResponse','GetEnrollmentResult','GetEnrollmentOutMessages','GetEnrollmentOutMsg','EnrollmentInfo'};
            rtn = extractData(tt,narrower);
        }
      }
      catch(Exception e){
         throw e;
      }
      return rtn;
   }
   
    public void UpdateEnrollment(Integer syStudentId, Integer AdEnrollId, Integer SySchoolStatusId){
        try{
            Dom.Document xml = new Dom.Document();
                        
            String msg ='<?xml version="1.0" encoding="utf-8" ?>'+
                        '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'+
                        '<soap:Body><PostStudentStatus xmlns="http://www.campusmgmt.com/Soa/Foundation/"><PostStudentStatusRequest xmlns="http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd">'+
                        '<TokenId>'+this.tokenId+'</TokenId><PostStudentStatuss><PostStudentStatusInMsg><CustomAttributes><CustomAttributeMsg><Name /><Value /></CustomAttributeMsg></CustomAttributes>'+
                        '<MessageState /><StudentId>'+syStudentId+'</StudentId><AdEnrollId>'+AdEnrollId+'</AdEnrollId><NewSySchoolStatusId>'+SySchoolStatusId+'</NewSySchoolStatusId>'+
                        '<EffectiveDate>'+this.LocalTime.format('Y-MM-dd\'T\'HH:mm:ss')+'</EffectiveDate></PostStudentStatusInMsg></PostStudentStatuss></PostStudentStatusRequest></PostStudentStatus></soap:Body></soap:Envelope>';
                        
                        
            xml.load(msg);
            Dom.XmlNode[] childrens = xml.getRootElement().getChildElements();
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
    
            req.setEndpoint('https://campuslink.lafilm.edu/Cmc.Integration.Webservices/PostStudentStatusService.asmx');
            req.setHeader('Content-Type', 'text/xml');
            req.setHeader('SOAPAction','http://www.campusmgmt.com/Soa/Foundation/PostStudentStatus');
            req.setBodyDocument(xml);
            Http http = new Http();
            HttpResponse res = http.send(req);

          }
          catch(Exception e){
             throw e;
          }
   }
   
   public List<Map<String,Object>> extractData(Map<String, Object> js, List<String> narrower){
       
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
   
    public void XMLTOJSON(dom.xmlNode element){
        List<dom.xmlNode> children = new List<dom.xmlNode>();
        children = element.getChildElements();
        
        if(element.getNodeType()==dom.XmlNodeType.ELEMENT && children.size()==1){
            js.writeStartObject();
            js.writeFieldName(element.getName());
            
            XMLTOJSON(children[0]);
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
                        XMLTOJSON(gc);
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
    }
    
    private integer hash(String text){
        text=text.tolowerCase();
        return text.hashcode();
    }
    
    private string ssn(string text){
        string rtn=null;
        try{
            if(text!=NULL){
                text=text.replaceAll('[^0-9]+', '');
            
                if(text.length() == 9)
                    rtn=text.substring(0, 3)+'-'+text.substring(3, 5)+'-'+text.substring(5, 9); 
                else{
                    throw new newException('Invalid SSN!');
                }
            }
        }
        catch(Exception e){
            throw e;
        }
        return rtn;
    }
    
    private String getStateCode(String State, Integer CountryId)
    {
        String rtn=NULL;
        
        if(State==NULL){
            return rtn;
        }

        if(CountryId==1)
        {
            Map<String,String> codes = new Map<String,String>();
            codes.put('al','AL');
            codes.put('ak','AK');
            codes.put('az','AZ');
            codes.put('ar','AR');
            codes.put('ca','CA');
            codes.put('co','CO');
            codes.put('ct','CT');
            codes.put('de','DE');
            codes.put('fl','FL');
            codes.put('ga','GA');
            codes.put('hi','HI');
            codes.put('id','ID');
            codes.put('il','IL');
            codes.put('in','IN');
            codes.put('ia','IA');
            codes.put('ks','KS');
            codes.put('ky','KY');
            codes.put('la','LA');
            codes.put('me','ME');
            codes.put('md','MD');
            codes.put('ma','MA');
            codes.put('mi','MI');
            codes.put('mn','MN');
            codes.put('ms','MS');
            codes.put('mo','MO');
            codes.put('mt','MT');
            codes.put('ne','NE');
            codes.put('nv','NV');
            codes.put('nh','NH');
            codes.put('nj','NJ');
            codes.put('nm','NM');
            codes.put('ny','NY');
            codes.put('nc','NC');
            codes.put('nd','ND');
            codes.put('oh','OH');
            codes.put('ok','OK');
            codes.put('or','OR');
            codes.put('pa','PA');
            codes.put('ri','RI');
            codes.put('sc','SC');
            codes.put('sd','SD');
            codes.put('tn','TN');
            codes.put('tx','TX');
            codes.put('ut','UT');
            codes.put('vt','VT');
            codes.put('va','VA');
            codes.put('wa','WA');
            codes.put('wv','WV');
            codes.put('wi','WI');
            codes.put('wy','WY');
            codes.put('alabama','AL');
            codes.put('alaska','AK');
            codes.put('arizona','AZ');
            codes.put('arkansas','AR');
            codes.put('california','CA');
            codes.put('colorado','CO');
            codes.put('connecticut','CT');
            codes.put('delaware','DE');
            codes.put('florida','FL');
            codes.put('georgia','GA');
            codes.put('hawaii','HI');
            codes.put('idaho','ID');
            codes.put('illinois','IL');
            codes.put('indiana','IN');
            codes.put('iowa','IA');
            codes.put('kansas','KS');
            codes.put('kentucky','KY');
            codes.put('louisiana','LA');
            codes.put('maine','ME');
            codes.put('maryland','MD');
            codes.put('massachusetts','MA');
            codes.put('michigan','MI');
            codes.put('minnesota','MN');
            codes.put('mississippi','MS');
            codes.put('missouri','MO');
            codes.put('montana','MT');
            codes.put('nebraska','NE');
            codes.put('nevada','NV');
            codes.put('new hampshire','NH');
            codes.put('new jersey','NJ');
            codes.put('new mexico','NM');
            codes.put('new york','NY');
            codes.put('north carolina','NC');
            codes.put('north dakota','ND');
            codes.put('ohio','OH');
            codes.put('oklahoma','OK');
            codes.put('oregon','OR');
            codes.put('pennsylvania','PA');
            codes.put('rhode island','RI');
            codes.put('south carolina','SC');
            codes.put('south dakota','SD');
            codes.put('tennessee','TN');
            codes.put('texas','TX');
            codes.put('utah','UT');
            codes.put('vermont','VT');
            codes.put('virginia','VA');
            codes.put('washington','WA');
            codes.put('west virginia','WV');
            codes.put('wisconsin','WI');
            codes.put('wyoming','WY');
        
            if(codes.containsKey(State.trim().toLowerCase())){
                rtn=codes.get(State.trim().toLowerCase());
            }
            else{
                throw new newException('Invalid mailing state :'+State);
            }
        }
            
        return rtn;
    }
    private integer getStateId(String code, Integer CountryId){
        Integer rtn=75;
        
        if(CountryId==1)
        {
            Map<String,Integer> states = new Map<String,Integer>();
    
            states.put('ab',73);
            states.put('ak',53);
            states.put('al',61);
            states.put('alabama',61);
            states.put('alaska',53);
            states.put('alberta',73);
            states.put('american samoa',69);
            states.put('ar',26);
            states.put('arizona',43);
            states.put('arkansas',26);
            states.put('as',69);
            states.put('az',43);
            states.put('bc',74);
            states.put('british columba',74);
            states.put('ca',9);
            states.put('california',9);
            states.put('co',45);
            states.put('colorado',45);
            states.put('connecticut',16);
            states.put('ct',16);
            states.put('dc',51);
            states.put('de',18);
            states.put('delaware',18);
            states.put('district of columbia',51);
            states.put('fc',64);
            states.put('fl',1);
            states.put('florida',1);
            states.put('foreign country',64);
            states.put('ga',2);
            states.put('georgia',2);
            states.put('gu',63);
            states.put('guam, us territory',63);
            states.put('hawaii',54);
            states.put('hi',54);
            states.put('ia',58);
            states.put('id',59);
            states.put('idaho',59);
            states.put('il',32);
            states.put('illinois',32);
            states.put('in',31);
            states.put('indiana',31);
            states.put('iowa',58);
            states.put('kansas',39);
            states.put('kentucky',28);
            states.put('ks',39);
            states.put('ky',28);
            states.put('la',25);
            states.put('louisiana',25);
            states.put('ma',15);
            states.put('maine',11);
            states.put('marshall islands',68);
            states.put('maryland',19);
            states.put('massachusettes',15);
            states.put('md',19);
            states.put('me',11);
            states.put('mh',68);
            states.put('mi',33);
            states.put('michigan',33);
            states.put('minnesota',35);
            states.put('mississippi',24);
            states.put('missouri',55);
            states.put('mn',35);
            states.put('mo',55);
            states.put('montana',48);
            states.put('ms',24);
            states.put('mt',48);
            states.put('nc',6);
            states.put('nd',36);
            states.put('ne',38);
            states.put('nebraska',38);
            states.put('nevada',60);
            states.put('new hampshire',13);
            states.put('new jersey',5);
            states.put('new mexico',42);
            states.put('new york',4);
            states.put('nh',13);
            states.put('nj',5);
            states.put('nm',42);
            states.put('north carolina',6);
            states.put('north dakota',36);
            states.put('nv',60);
            states.put('ny',4);
            states.put('oh',30);
            states.put('ohio',30);
            states.put('ok',40);
            states.put('oklahoma',40);
            states.put('on',71);
            states.put('ontario',71);
            states.put('or',52);
            states.put('oregon',52);
            states.put('out of usa - temp',75);
            states.put('pa',17);
            states.put('pennsylvania',17);
            states.put('pr',10);
            states.put('puerto rico',10);
            states.put('qc',72);
            states.put('quebec',72);
            states.put('rhode island',14);
            states.put('ri',14);
            states.put('sc',23);
            states.put('sd',7);
            states.put('south carolina',23);
            states.put('south dakota',7);
            states.put('tennesee',27);
            states.put('texas',8);
            states.put('tn',27);
            states.put('tx',8);
            states.put('ut',46);
            states.put('utah',46);
            states.put('va',20);
            states.put('vermont',12);
            states.put('vi',57);
            states.put('virgin islands',57);
            states.put('virginia',20);
            states.put('vt',12);
            states.put('wa',50);
            states.put('washington',50);
            states.put('west virginia',21);
            states.put('wi',34);
            states.put('wisconsin',34);
            states.put('wv',21);
            states.put('wy',49);
            states.put('wyoming',49);
            
            if(code!=NULL && states.containsKey(code.toLowerCase())){
                rtn=states.get(code.toLowerCase());
            }
        }
        return rtn;
    }
    public integer getCountryId(String country){
        Integer rtn=1;
        
        Map<String,Integer> Countries = new Map<String,Integer>();
        Countries.put('ad',54);
        Countries.put('ae',145);
        Countries.put('af',51);
        Countries.put('afghanistan',51);
        Countries.put('ag',58);
        Countries.put('ai',56);
        Countries.put('al',49);
        Countries.put('albania',49);
        Countries.put('algeria',52);
        Countries.put('am',59);
        Countries.put('american samoa',53);
        Countries.put('an',48);
        Countries.put('andorra',54);
        Countries.put('angola',55);
        Countries.put('anguilla',56);
        Countries.put('antarctica',57);
        Countries.put('antigua/barbuda',58);
        Countries.put('ao',55);
        Countries.put('aq',57);
        Countries.put('ar',3);
        Countries.put('argentina',3);
        Countries.put('armenia',59);
        Countries.put('aruba',60);
        Countries.put('as',53);
        Countries.put('at',5);
        Countries.put('au',4);
        Countries.put('australia',4);
        Countries.put('austria',5);
        Countries.put('aw',60);
        Countries.put('az',61);
        Countries.put('azerbaijan',61);
        Countries.put('ba',70);
        Countries.put('bahamas',46);
        Countries.put('bahrain',62);
        Countries.put('bangladesh',63);
        Countries.put('barbados',64);
        Countries.put('bb',64);
        Countries.put('bd',63);
        Countries.put('be',6);
        Countries.put('belarus',65);
        Countries.put('belgium',6);
        Countries.put('belize',50);
        Countries.put('benin',66);
        Countries.put('bermuda',67);
        Countries.put('bf',173);
        Countries.put('bg',74);
        Countries.put('bh',62);
        Countries.put('bhutan',69);
        Countries.put('bi',174);
        Countries.put('bj',66);
        Countries.put('bm',67);
        Countries.put('bn',172);
        Countries.put('bo',45);
        Countries.put('bolivia',45);
        Countries.put('bosnia / herzegovina',70);
        Countries.put('botswana',71);
        Countries.put('bouvet island',72);
        Countries.put('br',7);
        Countries.put('brazil',7);
        Countries.put('british indian ocean territory',73);
        Countries.put('brunei darussalam',172);
        Countries.put('bs',46);
        Countries.put('bt',69);
        Countries.put('bulgaria',74);
        Countries.put('burkina faso',173);
        Countries.put('burundi',174);
        Countries.put('bv',72);
        Countries.put('bw',71);
        Countries.put('by',65);
        Countries.put('bz',50);
        Countries.put('cambodia',75);
        Countries.put('cameroon',76);
        Countries.put('can',8);
        Countries.put('canada',8);
        Countries.put('cape verde',175);
        Countries.put('cayman islands',77);
        Countries.put('cc',178);
        Countries.put('cd',180);
        Countries.put('central african republic',176);
        Countries.put('cf',176);
        Countries.put('cg',80);
        Countries.put('ch',37);
        Countries.put('chad',78);
        Countries.put('chile',9);
        Countries.put('china',10);
        Countries.put('christmas island',177);
        Countries.put('ci',164);
        Countries.put('ck',81);
        Countries.put('cl',9);
        Countries.put('cm',76);
        Countries.put('cn',10);
        Countries.put('co',79);
        Countries.put('cocos (keeling) islands',178);
        Countries.put('colombia',79);
        Countries.put('comoros',179);
        Countries.put('congo',80);
        Countries.put('congo, democratic republic',180);
        Countries.put('cook islands',81);
        Countries.put('costa rica',11);
        Countries.put('ivory coast',164);
        Countries.put('cr',11);
        Countries.put('croatia',82);
        Countries.put('cs',181);
        Countries.put('cu',83);
        Countries.put('cuba',83);
        Countries.put('cv',175);
        Countries.put('cx',177);
        Countries.put('cy',84);
        Countries.put('cyprus',84);
        Countries.put('cz',85);
        Countries.put('czech republic',85);
        Countries.put('czechoslovakia (former)',181);
        Countries.put('de',17);
        Countries.put('denmark',12);
        Countries.put('dj',182);
        Countries.put('djibouti',182);
        Countries.put('dk',12);
        Countries.put('dm',183);
        Countries.put('do',13);
        Countries.put('dominica',183);
        Countries.put('dominican republic',13);
        Countries.put('dz',52);
        Countries.put('east timor',184);
        Countries.put('ec',86);
        Countries.put('ecuador',86);
        Countries.put('ee',87);
        Countries.put('eg',14);
        Countries.put('egypt',14);
        Countries.put('eh',250);
        Countries.put('el salvador',44);
        Countries.put('equatorial guinea',185);
        Countries.put('er',186);
        Countries.put('eritrea',186);
        Countries.put('es',34);
        Countries.put('estonia',87);
        Countries.put('et',88);
        Countries.put('ethiopia',88);
        Countries.put('f.y.r.o.m. (macedonia)',120);
        Countries.put('falkland islands',89);
        Countries.put('faroe islands',188);
        Countries.put('fi',91);
        Countries.put('fiji',90);
        Countries.put('finland',91);
        Countries.put('fj',90);
        Countries.put('fk',89);
        Countries.put('fm',100253);
        Countries.put('fo',188);
        Countries.put('fr',16);
        Countries.put('france',16);
        Countries.put('france, metropolitan',189);
        Countries.put('french guiana',92);
        Countries.put('french polynesia',93);
        Countries.put('french southern territories',190);
        Countries.put('fx',189);
        Countries.put('ga',191);
        Countries.put('gabon',191);
        Countries.put('gambia',94);
        Countries.put('gb',192);
        Countries.put('gd',99);
        Countries.put('ge',155);
        Countries.put('georgia (soviet)',155);
        Countries.put('germany',17);
        Countries.put('gf',92);
        Countries.put('gh',95);
        Countries.put('ghana',95);
        Countries.put('gi',96);
        Countries.put('gibraltar',96);
        Countries.put('gl',98);
        Countries.put('gm',94);
        Countries.put('gn',102);
        Countries.put('gp',100);
        Countries.put('gq',185);
        Countries.put('gr',97);
        Countries.put('great britain (uk)',192);
        Countries.put('greece',97);
        Countries.put('greenland',98);
        Countries.put('grenada',99);
        Countries.put('gs',225);
        Countries.put('gt',18);
        Countries.put('gu',101);
        Countries.put('guadeloupe',100);
        Countries.put('guam',101);
        Countries.put('guatemala',18);
        Countries.put('guinea',102);
        Countries.put('guinea-bissau',193);
        Countries.put('guyana',194);
        Countries.put('gw',193);
        Countries.put('gy',194);
        Countries.put('haiti',103);
        Countries.put('heard and mcdonald islands',195);
        Countries.put('hk',105);
        Countries.put('hm',195);
        Countries.put('hn',104);
        Countries.put('honduras',104);
        Countries.put('hong kong',105);
        Countries.put('hr',82);
        Countries.put('ht',103);
        Countries.put('hu',106);
        Countries.put('hungary',106);
        Countries.put('iceland',107);
        Countries.put('id',20);
        Countries.put('ie',43);
        Countries.put('il',21);
        Countries.put('in',19);
        Countries.put('india',19);
        Countries.put('indonesia',20);
        Countries.put('io',73);
        Countries.put('iq',109);
        Countries.put('ir',108);
        Countries.put('iran',108);
        Countries.put('iraq',109);
        Countries.put('ireland',43);
        Countries.put('is',107);
        Countries.put('israel',21);
        Countries.put('it',22);
        Countries.put('italy',22);
        Countries.put('jamaica',110);
        Countries.put('japan',23);
        Countries.put('jm',110);
        Countries.put('jo',111);
        Countries.put('jordan',111);
        Countries.put('jp',23);
        Countries.put('kazakhstan',112);
        Countries.put('ke',113);
        Countries.put('kenya',113);
        Countries.put('kg',197);
        Countries.put('kh',75);
        Countries.put('ki',196);
        Countries.put('kiribati',196);
        Countries.put('km',179);
        Countries.put('kn',226);
        Countries.put('korea (north)',24);
        Countries.put('korea (south)',47);
        Countries.put('kp',24);
        Countries.put('kr',47);
        Countries.put('kuwait',114);
        Countries.put('kw',114);
        Countries.put('ky',77);
        Countries.put('kyrgzstan',197);
        Countries.put('kz',112);
        Countries.put('la',154);
        Countries.put('laos',154);
        Countries.put('latvia',115);
        Countries.put('lb',116);
        Countries.put('lc',227);
        Countries.put('lebanon',116);
        Countries.put('lesotho',198);
        Countries.put('li',199);
        Countries.put('liberia',117);
        Countries.put('libya',118);
        Countries.put('liechtenstein',199);
        Countries.put('lithuania',119);
        Countries.put('lk',35);
        Countries.put('lr',117);
        Countries.put('ls',198);
        Countries.put('lt',119);
        Countries.put('lu',157);
        Countries.put('luxembourg',157);
        Countries.put('lv',115);
        Countries.put('ly',118);
        Countries.put('ma',169);
        Countries.put('macau',253);
        Countries.put('madagascar',200);
        Countries.put('malawi',201);
        Countries.put('malaysia',25);
        Countries.put('maldives',202);
        Countries.put('mali',203);
        Countries.put('malta',121);
        Countries.put('marshall islands',204);
        Countries.put('martinique',205);
        Countries.put('mauritania',206);
        Countries.put('mauritius',207);
        Countries.put('mayotte',208);
        Countries.put('mc',211);
        Countries.put('md',209);
        Countries.put('mexico',26);
        Countries.put('mg',200);
        Countries.put('mh',204);
        Countries.put('micronesia',100253);
        Countries.put('mk',120);
        Countries.put('ml',203);
        Countries.put('mm',161);
        Countries.put('mn',171);
        Countries.put('mo',253);
        Countries.put('moldova',209);
        Countries.put('monaco',211);
        Countries.put('mongolia',171);
        Countries.put('montserrat',212);
        Countries.put('morocco',169);
        Countries.put('mozambique',213);
        Countries.put('mp',210);
        Countries.put('mq',205);
        Countries.put('mr',206);
        Countries.put('ms',212);
        Countries.put('mt',121);
        Countries.put('mu',207);
        Countries.put('mv',202);
        Countries.put('mw',201);
        Countries.put('mx',26);
        Countries.put('my',25);
        Countries.put('myanmar',161);
        Countries.put('mz',213);
        Countries.put('na',158);
        Countries.put('namibia',158);
        Countries.put('nauru',214);
        Countries.put('nc',216);
        Countries.put('ne',123);
        Countries.put('nepal',27);
        Countries.put('netherlands antilles',48);
        Countries.put('netherlands',28);
        Countries.put('neutral zone',215);
        Countries.put('new caledonia',216);
        Countries.put('new zealand',122);
        Countries.put('nf',218);
        Countries.put('ng',29);
        Countries.put('ni',125);
        Countries.put('nicaragua',125);
        Countries.put('niger',123);
        Countries.put('nigeria',29);
        Countries.put('niue',217);
        Countries.put('nl',28);
        Countries.put('no',126);
        Countries.put('norfolk island',218);
        Countries.put('northern mariana islands',210);
        Countries.put('norway',126);
        Countries.put('np',27);
        Countries.put('nr',214);
        Countries.put('nt',215);
        Countries.put('nu',217);
        Countries.put('nz',122);
        Countries.put('om',219);
        Countries.put('oman',219);
        Countries.put('pa',127);
        Countries.put('pakistan',156);
        Countries.put('panama',127);
        Countries.put('papua new guinea',220);
        Countries.put('paraguay',221);
        Countries.put('pe',128);
        Countries.put('peru',128);
        Countries.put('pf',93);
        Countries.put('pg',220);
        Countries.put('ph',30);
        Countries.put('philippines',30);
        Countries.put('pitcairn',222);
        Countries.put('pk',156);
        Countries.put('pl',31);
        Countries.put('pm',237);
        Countries.put('pn',222);
        Countries.put('poland',31);
        Countries.put('portugal',32);
        Countries.put('pr',129);
        Countries.put('pt',32);
        Countries.put('puerto rico',129);
        Countries.put('py',221);
        Countries.put('qa',168);
        Countries.put('qatar',168);
        Countries.put('re',223);
        Countries.put('reunion',223);
        Countries.put('ro',130);
        Countries.put('romania',130);
        Countries.put('ru',163);
        Countries.put('russia',163);
        Countries.put('rw',224);
        Countries.put('rwanda',224);
        Countries.put('s. georgia and s. sandwich isls.',225);
        Countries.put('sa',131);
        Countries.put('saint kitts and nevis',226);
        Countries.put('saint lucia',227);
        Countries.put('saint vincent & the grenadines',228);
        Countries.put('samoa',229);
        Countries.put('san marino',230);
        Countries.put('sao tome and principe',231);
        Countries.put('saudi arabia',131);
        Countries.put('sc',233);
        Countries.put('sco',159);
        Countries.put('scotland',159);
        Countries.put('sd',238);
        Countries.put('se',36);
        Countries.put('seychelles',233);
        Countries.put('sg',132);
        Countries.put('sh',236);
        Countries.put('si',134);
        Countries.put('sierra leone',234);
        Countries.put('singapore',132);
        Countries.put('sj',235);
        Countries.put('sk',133);
        Countries.put('sl',234);
        Countries.put('slovakia',133);
        Countries.put('slovenia',134);
        Countries.put('sm',230);
        Countries.put('sn',167);
        Countries.put('so',135);
        Countries.put('somalia',135);
        Countries.put('south africa',33);
        Countries.put('soviet union (former)',136);
        Countries.put('spain',34);
        Countries.put('sri lanka',35);
        Countries.put('st',231);
        Countries.put('st. helena',236);
        Countries.put('st. pierre and miquelon',237);
        Countries.put('su',136);
        Countries.put('sudan',238);
        Countries.put('suriname',167);
        Countries.put('sv',44);
        Countries.put('svalbard & jan mayen islands',235);
        Countries.put('swaziland',162);
        Countries.put('sweden',36);
        Countries.put('switzerland',37);
        Countries.put('sy',137);
        Countries.put('syria',137);
        Countries.put('sz',162);
        Countries.put('taiwan',68);
        Countries.put('tajikistan',239);
        Countries.put('tanzania',138);
        Countries.put('tc',243);
        Countries.put('td',78);
        Countries.put('tf',190);
        Countries.put('tg',240);
        Countries.put('th',139);
        Countries.put('thailand',139);
        Countries.put('tj',239);
        Countries.put('tk',241);
        Countries.put('tm',242);
        Countries.put('tn',142);
        Countries.put('to',140);
        Countries.put('togo',240);
        Countries.put('tokelau',241);
        Countries.put('tonga',140);
        Countries.put('tp',184);
        Countries.put('tr',38);
        Countries.put('trinidad / tobago',141);
        Countries.put('tt',141);
        Countries.put('tunisia',142);
        Countries.put('turkey',38);
        Countries.put('turkmenistan',242);
        Countries.put('turks and caicos islands',243);
        Countries.put('tuvalu',244);
        Countries.put('tv',244);
        Countries.put('tw',68);
        Countries.put('tz',138);
        Countries.put('ua',144);
        Countries.put('ug',143);
        Countries.put('uganda',143);
        Countries.put('uk',15);
        Countries.put('ukraine',144);
        Countries.put('um',245);
        Countries.put('united arab emirates',145);
        Countries.put('united kingdom',15);
        Countries.put('united states',1);
        Countries.put('uruguay',146);
        Countries.put('us minor outlying islands',245);
        Countries.put('usa',1);
        Countries.put('uy',146);
        Countries.put('uz',246);
        Countries.put('uzbekistan',246);
        Countries.put('va',248);
        Countries.put('vanuatu',247);
        Countries.put('vatican city state (holy sea)',248);
        Countries.put('vc',228);
        Countries.put('ve',39);
        Countries.put('venezuela',39);
        Countries.put('vg',148);
        Countries.put('vi',149);
        Countries.put('vietnam',147);
        Countries.put('virgin islands (british)',148);
        Countries.put('virgin islands (us)',149);
        Countries.put('vn',147);
        Countries.put('vu',247);
        Countries.put('wallis and futuna islands',249);
        Countries.put('west indies',251);
        Countries.put('western sahara',250);
        Countries.put('wf',249);
        Countries.put('wi',251);
        Countries.put('ws',229);
        Countries.put('ye',150);
        Countries.put('yemen',150);
        Countries.put('yt',208);
        Countries.put('yu',151);
        Countries.put('yugoslavia (serbia)',151);
        Countries.put('za',33);
        Countries.put('zaire',152);
        Countries.put('zambia',153);
        Countries.put('zimbabwe',100254);
        Countries.put('zm',153);
        Countries.put('zr',152);
        Countries.put('zw',100254);
        
        if(Country!=NULL && Countries.containsKey(Country.toLowerCase())){
            rtn=Countries.get(Country.toLowerCase());
        }
        return rtn;
    }
    
    private string phone(string phone){
        String rtn=NULL;
        
        if(phone!=NULL)
        {
            String rowNumber = phone.replaceAll('[^0-9]+', '');
            integer len=rowNumber.length();
            
            if(len>=10){
                rtn=rowNumber.substring(len-10,len);
                rtn=rtn.substring(0, 3)+'-'+rtn.substring(3, 6)+'-'+rtn.substring(6, 10); 
            }
            else{
                rtn=NULL;
            }
        }
        
        return rtn;
    }
    
    Private Boolean isEmpty(String field){
        Boolean rtn=false;
        
        if(field==NULL || field=='' || field=='null' || field.trim()==''){
            rtn=true;
        }
            
        return rtn;
        
    }
    
    Private Boolean isEmpty(Integer field){
        Boolean rtn=false;
        
        if(field==NULL || field==0)
            rtn=true;
            
        return rtn;
    }
    
    private integer getLeadSource(String code){
        integer rtn=NULL;
        
        Map<String,Integer> codes = new Map<String,Integer>();
        
        if(settings.containsKey('amLeadSrc'))
        {
            codes = settings.get('amLeadSrc');
        
            if(code!=NULL && codes.containsKey(code)){
                rtn = codes.get(code);
            }    
        }
        return rtn;
    }
    
    private string isVeteran(string code){
        string rtn='No';
        Map<String,String> codes = new Map<String,String>();
        codes.put('ACT','Active Duty');
        codes.put('ADNV','Active Duty - Navy');
        codes.put('ADAR','Active Duty - Army');
        codes.put('ADAF','Active Duty - Air Force');
        codes.put('ADCG','Active Duty - Coast Guard');
        codes.put('ADMC','Active Duty - Marine Corps');
        codes.put('MILT','Military');
        codes.put('MDNV','Mil Dep using Benefits - Navy');
        codes.put('MDAR','Mil Dep using Benefits - Army');
        codes.put('MDAF','Mil Dep using Benefits - Air Force');
        codes.put('MDCG','Mil Dep using Benefits - Coast Guard');
        codes.put('MDMC','Mil Dep using Benefits - Marine Corps');
        codes.put('RVNGNV','Reservist/National Guard - Navy');
        codes.put('RVNGAR','Reservist/National Guard - Army');
        codes.put('RVNGAF','Reservist/National Guard - Air Force');
        codes.put('RVNGCG','Reservist/National Guard - Coast Guard');
        codes.put('RVNGMC','Reservist/National Guard - Marine Corps');
        codes.put('VET','Veteran');
        codes.put('VETNV','Veteran - Navy');
        codes.put('VETAR','Veteran - Army');
        codes.put('VETAF','Veteran - Air Force');
        codes.put('VETCG','Veteran - Coast Guard');
        codes.put('VETMC','Veteran - Marine Corps');
        codes.put('VETNU','Veteran - Not using benefits');
        codes.put('MDEP','Military Dependant using benefits');
        
        if(codes.containsKey(code)){
            rtn='Yes';
        }
        
        return rtn;
    }
    
    private Integer getAffiliationId(String code){
        Integer rtn=NULL;
        Map<String,Integer> codes = new Map<String,Integer>();
        
        if(settings.containsKey('amAgency'))
        {
            codes = settings.get('amAgency');
        
            if(code!=NULL && codes.containsKey(code)){
                rtn = codes.get(code);
            }    
        }
        return rtn;
    }
    
    public integer getAdminRep(String email){
        Integer rtn=37;
        
        if(email!=NULL)
        {
            String username= email.split('@')[0].toLowerCase();
            
            Map<String,Integer> codes = new Map<String,Integer>();
            
            if(settings.containsKey('amRep'))
            {
                codes = settings.get('amRep');
            
                if(codes.containsKey(username)){
                    rtn=codes.get(username);
                    return rtn;
                }
            }
        }

        return rtn;
    }
    
    private integer getNationality(String code){
        Integer rtn=20;
        Map<String,Integer> codes = new Map<String,Integer>();
        
        if(settings.containsKey('AmNationality'))
        {
            codes = settings.get('AmNationality');
        
            if(code!=NULL && codes.containsKey(code.toLowerCase())){
                rtn=codes.get(code.toLowerCase());
            }
        }

        return rtn;
    }
    

    
    private integer getCitizenship(String code)
    {
        Integer rtn=NULL;
        Map<String,Integer> codes = new Map<String,Integer>();
        
        if(settings.containsKey('amCitizen'))
        {
            codes = settings.get('amCitizen');
        
            if(code!=NULL && codes.containsKey(code.toLowerCase())){
                rtn=codes.get(code.toLowerCase());
            }
        }
        
        if(rtn==NULL && !Test.isRunningTest()){
            throw new newException('Citizenship status is not selected');
        }

        return rtn;
    }
    
    public integer getPrevEducId(String Code, Application__c app){
        Integer rtn=NULL;
        Map<String,Integer> codes = new Map<String,Integer>();
        
        if(settings.containsKey('amPrevEduc'))
        {
            codes = settings.get('amPrevEduc');
        
            if(code!=NULL && codes.containsKey(code)){
                rtn=codes.get(code);
                return rtn;
            }
            else if(app!=NULL)
            {
                if(app.HS_Graduation_Date__c<system.today() && app.HS_Degree_Received__c!=NULL && (app.College_1_Graduation_Date__c!=NULL && app.College_1_Graduation_Date__c<system.today()) || (app.College_2_Graduation_Date__c!=NULL && app.College_2_Graduation_Date__c<system.today())){
                    rtn=codes.get('AA/AS');
                }
                else if((app.College_1_Graduation_Date__c!=NULL && app.College_1_Graduation_Date__c>system.today()) || (app.College_2_Graduation_Date__c!=NULL && app.College_2_Graduation_Date__c>system.today())){
                    rtn=codes.get('COL');
                }
                else if((app.College_1_Name__c!=NULL || app.College_1_Graduation_Date__c!=NULL || app.College_1_Degree__c!=NULL ||
                    app.College_2_Name__c!=NULL || app.College_2_Graduation_Date__c!=NULL || app.College_2_Degree__c!=NULL) && app.HS_Graduation_Date__c<system.today()){
                    rtn=codes.get('SOMECOL');
                }
                else if(app.HS_Graduation_Date__c<system.today() && app.HS_Degree_Received__c!=NULL && app.HS_Degree_Received__c.replaceAll('[^a-z^A-z]','').toLowerCase().IndexOf('ged')!=-1){
                    rtn=codes.get('GED');
                }
                else if(app.HS_Graduation_Date__c<system.today() || app.HS_Degree_Received__c==NULL){
                    rtn=codes.get('HS');
                }
                else if(app.HS_Graduation_Date__c>system.today()){
                    rtn=codes.get('INHS');
                }
            }
        }
        return rtn;
    }
    
    public List<integer> getRaceId(String Code){
        List<integer> rtn= new List<integer>();
        
        if(code!=NULL){
            code=code.toLowerCase();
        }
        
        Map<String,Integer> codes = new Map<String,Integer>();
        
        if(settings.containsKey('amRace')){
            codes = settings.get('amRace');
            
            if(codes.containsKey('not specified')){
                rtn.add(codes.get('not specified'));
            }
        
            for(string value :codes.keySet()){
                if(code!=NULL && (value.indexOf(code)!=-1 || code.indexOf(value)!=-1)){
                    rtn.clear();
                    rtn.add(codes.get(value));
                    return rtn;
                }
            }
        }
        return rtn;
    }
    
    public integer getProgramId(String ProgramCode, String ProgramVersion){
        Integer rtn;
        Map<String,Integer> unique = new Map<String,Integer>();
        Map<String,Integer> words= new Map<String,Integer>();
        
        try
        {
            Map<String,Integer> codes = new Map<String,Integer>();
            
            if(settings2.containsKey(ProgramCode))
            {
                codes = settings2.get(ProgramCode);
                
                for(String version :codes.keySet())
                {
                    if(rtn==NULL){
                        rtn=codes.get(version);
                    }
                    
                    if(codes.size()>1)
                    {
                        for(String s :codes.keySet())
                        {
                            String w='';
                            for(String x :s.split('/|\\\\| '))
                            {
                                
                                if(!(words.containsKey(x.toLowerCase()) && words.get(x.toLowerCase())>1) ){
                                    w=(w=='')?x:w+' '+x;
                                }
                            }
                            if(w==''){ w=s; }
                            unique.put(w,codes.get(s));
                        }
                        
                        if(ProgramVersion!=NULL)
                        {
                            String[] versions=ProgramVersion.split('/|\\\\| ');
                        
                            system.debug(versions);
                            for(String v :versions)
                            {
                                for(String c :unique.keySet())
                                {
                                    if(v!=NULL && c.toLowerCase().IndexOf(v.toLowerCase())!=-1){
                                        rtn=unique.get(c);
                                        return rtn;
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            else
                throw new newException('Program Code "'+ProgramCode+'" cannot be found!');
        }
        catch(Exception e){
            throw e;
        }
        return rtn;
    }
    
    private void readSettings(){
        
        List<codes> dataSet = new List<codes>();
        
        List<CV_Settings__c> c = [select table__c, value__c from cv_settings__c];
        
        for(CV_Settings__c x :c)
        {
            dataSet = (List<codes>)JSON.deserialize(x.value__c, List<codes>.class);
            
            for(codes s :dataSet)
            {
                Map<String,Integer> temp;
                
                if(s.code2==NULL)
                {
                    if(settings.containsKey(x.table__c))
                    {
                        temp=settings.get(x.table__c);
                        temp.put(s.code, s.id);
                    }
                    else
                    {
                        temp = new Map<String,Integer>();
                        temp.put(s.code, s.id);
                        settings.put(x.table__c, temp);
                    }
               }
               else
               {
                    if(settings2.containsKey(s.code2))
                    {
                        temp=settings2.get(s.code2);
                        temp.put(s.code, s.id);
                    }
                    else
                    {
                        temp = new Map<String,Integer>();
                        temp.put(s.code, s.id);
                        settings2.put(s.code2, temp);
                    }
               }
            }
        }
    }
   
    public void UpdateStudents(Integer SyStudentIds, Id ContactId)
    {
        try
        {
            CV_Student_Definition.GetStudentOutMsg student = new CV_Student_Definition.GetStudentOutMsg();
            student = getStudentInfo(SyStudentIds);
            
            if(student!=NULL && (student.SchoolStatusId==56 || student.SchoolStatusId==12)){
                throw new newException('This student has Denied status in Campus!');
            }
            
            if(Test.isRunningTest()){
                student = new CV_Student_Definition.GetStudentOutMsg();
            }
            
            Contact c = [select ssn__c, email, mailingAddress, birthdate, gender__c, nationality__c, citizenship_status__c, owner.email, Affiliation_Code__c from contact where Id=:ContactId];
            
            CV_Student_Definition.UpdateStudentLeadInMsg NewStudent = new CV_Student_Definition.UpdateStudentLeadInMsg();
            
            NewStudent.StudentId=SyStudentIds;
            
            NewStudent.UpdateFields = new List<CV_Student_Definition.UpdateField>();
            
            if(isEmpty(student.SSN))
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('SSN',ssn(c.ssn__c)));
              
            if(isEmpty(student.email))
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('Email',c.Email));
                
            if(isEmpty(student.Address) && c.mailingAddress!=NULL)
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('Address',c.mailingAddress.getStreet()));
                
            if(isEmpty(student.City) && c.mailingAddress!=NULL)
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('City',c.mailingAddress.getCity()));
            
            if(isEmpty(student.StateId) && c.mailingAddress!=NULL)
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('StateId',String.ValueOf(getStateId(c.mailingAddress.getState(),getCountryId(c.mailingAddress.getCountry())))));
                
            if(isEmpty(student.PostalCode) && c.mailingAddress!=NULL)
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('PostalCode',c.mailingAddress.getPostalCode()));
                
            if(c.mailingAddress!=NULL && getCountryId(c.mailingAddress.getCountry())!=1){
                NewStudent.SkipSemanticValidation=true;
            }   
                
            if(isEmpty(student.CountryId) && c.mailingAddress!=NULL)
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('CountryId',String.ValueOf(getCountryId(c.mailingAddress.getCountry()))));
                
            if(student.BirthDate==NULL && c.Birthdate!=NULL)
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('BirthDate',c.Birthdate.format()));
                
            if(isEmpty(student.GenderId))
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('GenderId',String.ValueOf(getGender(c.gender__c))));
            
            if(isEmpty(student.NationalityId)) 
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('NationalityId',String.ValueOf(this.getNationality(c.nationality__c))));
            
            if(isEmpty(student.CitizenshipId) || student.CitizenshipId!=this.getCitizenship(c.citizenship_status__c))
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('CitizenshipId',String.ValueOf(this.getCitizenship(c.citizenship_status__c))));
                
            if(isEmpty(student.AdmissionsOfficerId) || student.AdmissionsOfficerId==NULL || student.AdmissionsOfficerId==471)
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('AdmissionsOfficerId',String.ValueOf(this.getAdminRep(c.owner.email))));
            
            if(isEmpty(student.IsVeteran) || (student.IsVeteran!=this.isVeteran(c.Affiliation_Code__c)))
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('IsVeteran',this.isVeteran(c.Affiliation_Code__c)));
            
            if(this.App!=NULL)
            {
                if(app.Disability_Accomodations__c==true && student.HasDisability!='Yes'){
                    NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('HasDisability','Yes'));
                }
                else if(app.Disability_Accomodations__c==false && student.HasDisability=='Yes'){
                    NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('HasDisability','No'));
                }
            }
            
            if(NewStudent.UpdateFields.size()>0){
                updateStudentInfo(NewStudent);
            }
        }
        catch(Exception e){
            throw e;
        }
    }
    
    public Date getGradDate(Date ExpectedStartDate, Integer ProgramVersionId){
        Date rtn=NULL;
        
        Map<String,Integer> codes = new Map<String,Integer>();
        
        if(settings2.containsKey(String.ValueOf(ProgramVersionId)))
        {
            codes = settings2.get(String.ValueOf(ProgramVersionId));
            
            if(codes.containsKey(String.ValueOf(ExpectedStartDate)))
            {
                rtn = ExpectedStartDate.addDays(codes.get(String.ValueOf(ExpectedStartDate)));
            }
            else
            {
                Integer y,m,d,eY,eM;
                Date newDate = Date.newInstance(1900,1,1);
                
                eY=ExpectedStartDate.Year();
                eM=(ExpectedStartDate.Day()>15)?ExpectedStartDate.Month()+1:ExpectedStartDate.Month();
                
                for(String sDate :codes.keySet())
                {
                    Date StartDate = Date.ValueOf(sDate);
                    y=StartDate.Year();
                    d=StartDate.Day();
                    m=StartDate.Month();
                    
                    if(d>15){
                        m=m+1;
                    }
                    
                    if(y==eY && m==eM)
                    {
                        rtn = StartDate.addDays(codes.get(sDate));
                        return rtn;
                    }
                }
            }
            
            if(rtn==NULL){
                rtn=getGradDateCalc(ExpectedStartDate, ProgramVersionId);
            }
        }
        else if(!Test.isRunningTest()){
            throw new newException('Start Date Setup is not completed for this program version in CampusNexus ('+ProgramVersionId+')');
        }
        
        return rtn;
    }
    
    private date getGradDateCalc(Date ExpectedStartDate, Integer ProgramVersionId){
        Date rtn;
        
        Map<String,Integer> codes = new Map<String,Integer>();
        Integer Months=0;
        
        if(settings.containsKey('adProgramVersion'))
        {
            codes = settings.get('adProgramVersion');
        
            if(ProgramVersionId!=NULL && codes.containsKey(String.valueOf(ProgramVersionId))){
                Months=codes.get(String.valueOf(ProgramVersionId));
            }
        }
        if(months==0){
            months=24;
        }
        Date d = ExpectedStartDate.addMonths(months);

        Date thisSunday = d.toStartOfWeek();
        Date fouthSunday= thisSunday.addDays(-28);
        
        List<Date> sundays = new List<Date>();
        sundays.add(fouthSunday);
        
        while(sundays.size()<=5)
        {
            Date nextDate = sundays[sundays.size()-1].addDays(7);
            
            Date s1 = date.newInstance(nextDate.year(),12,24);
            Date e1 = date.newInstance(nextDate.year()+1,1,7);
            
            Date s2 = date.newInstance(nextDate.year(),11,23);
            Date e2 = date.newInstance(nextDate.year(),11,30);
            
            if(s1<=nextDate && nextDate<=e1){
                sundays.add(nextDate.addDays(+14)); // skip christmas holidays
            }
            else if(s2<=nextDate && nextDate<=e2){
                sundays.add(nextDate.addDays(+7)); // skip thanksgiving holidays
            }
            else{
                sundays.add(nextDate);
            }
        }
        
        for(Integer i=0; i<sundays.size(); i++)
        {
            Date s = sundays[i];
            if(s<=d && ((i<sundays.size()-1 && d<sundays[i+1]) || i==sundays.size()-1)){
                
                rtn=s;
                return rtn;
            }
        }

        
        return rtn;
    }
    
    private Id foundSyStudentId(string SyStudentId, Id myId){
        Id rtn=NULL;
        
        List<list<Contact>> dup = search.query('FIND \''+SyStudentId+'\' IN ALL FIELDS RETURNING Contact (Id, SyStudentId__c)');
        
        for(List<Contact> L :dup)
        {
            for(Contact c :L)
            {
                if(c.Id!=myId && c.SyStudentId__c!=NULL && c.SyStudentId__c==SyStudentId){
                    rtn=c.Id;
                    return rtn;
                }
            }
        }
        
        return rtn;
    }
    
    public void test(){
        getStateCode('California',1);
        Contact c = [select id from contact limit 1];
        foundSyStudentId('12345',c.id);
        List<CV_Settings__c> settings = [select value__c from CV_Settings__c where table__c='adProgramVersion'];
        if(settings.size()>0)
        {
            CV_Settings__c x = settings[0];
            List<Codes> cds =(List<codes>)JSON.deserialize(x.value__c, List<codes>.class);
            getGradDate(Date.newInstance(system.today().Year(),1,1),cds[0].id);
            getGradDateCalc(Date.newInstance(system.today().Year(),1,1),cds[0].id);
            isEmpty('');
            Integer m=NULL;
            isEmpty(m);
        }
    }
    
    public void doMigrate(Id apps)
    {
        Map<Id,Integer> con = new Map<Id,Integer>();
        application__c a = [select id, application_status__c, student__c, student__r.systudentid__c, student__r.name, program_code__c, Program_Version__c, student__r.expected_start_date__c,
                            exp_Startdate__c, student__r.mailingAddress, student__r.Previous_Education_Codes__c, AdEnrollId__c, High_School_Name__c, HS_Graduation_Date__c,HS_Degree_Received__c,
                            High_School_Country__c,High_School_City__c,High_School_State__c, College_1_Name__c,College_1_Graduation_Date__c,College_1_Degree__c,College_2_Name__c,
                            College_2_Graduation_Date__c,College_2_Degree__c, student__r.owner.email, Disability_Accomodations__c  from application__c where id=:apps];
        this.App=a;
        Id InsertIds=a.student__c;
        Integer SyStudentId=NULL;
        
        try {
            if(a.application_status__c!='Approved'){
                throw new newException('Application is required to be approved to perform this action!');
            }
            
            // ******************* call SyStudent web service *******************
            List<CV_Lead_Definition.LeadInMsg> students = new List<CV_Lead_Definition.LeadInMsg>();
            con = InsertNewStudent(InsertIds, a);
            String SyId=String.ValueOf(con.get(InsertIds));
            Id Found = foundSyStudentId(String.ValueOf(con.get(InsertIds)), InsertIds);
            
            if(Found!=NULL)
            {
                throw new newException('This student associates with another StudentMaster object in Salesforce! (Id='+Found+', SyStudentId='+con.get(InsertIds)+')');
            }
            else if(con.get(InsertIds)!=NULL)
            {
                UpdateStudents(con.get(InsertIds), a.Student__c);
                SyStudentId=con.get(InsertIds);
            }
        }
        catch(Exception e){
            throw e;
        }

    
       // ******************* call AdEnroll web service *******************
                                 
       List<CV_Enroll_Definition.EnrollmentInMsg> Enrolls = new List<CV_Enroll_Definition.EnrollmentInMsg>();
       
       Integer AdEnrollId=NULL;
        
       try {
            if(a.student__r.expected_start_date__c==NULL){
                throw new newException('Expected Start Date is required');
            }
            
            AdEnrollId = Integer.ValueOf(a.AdEnrollId__c);  
            
            if(SyStudentId!=NULL)
            {
                Date startDate = (a.exp_startdate__c==NULL)?a.student__r.expected_start_date__c:a.exp_startdate__c;
                
                CV_Enroll_Definition.EnrollmentInMsg enroll = new CV_Enroll_Definition.EnrollmentInMsg();
                enroll.ApplicationReceivedDate = localTime;
                enroll.EnrollDate = localTime;
                enroll.StudentId=SyStudentId;
                enroll.CampusId=5;
                enroll.SchoolStatusId=5;
                enroll.BillingMethodId=65;
                enroll.GradeLevelId=6;
                enroll.ShiftId = 8;
                enroll.AdmissionRepId=this.getAdminRep(a.student__r.owner.email);
                enroll.ProgramVersionId=this.getProgramId(a.program_code__c,a.Program_Version__c);
                enroll.ExpectedStartDate = startDate;
                enroll.MidPointDate = startDate.addYears(1);
                enroll.GraduationDate = this.getGradDate(startDate, enroll.ProgramVersionId);
                enroll.IsApplicant=true;
                if(a.student__r.mailingAddress!=NULL)
                {
                    enroll.IPEDSStateOfResidence=this.getStateCode(a.student__r.mailingAddress.getState(), getCountryId(a.student__r.mailingAddress.getCountry())); 
                }
                enroll.PreviousEducationId=this.getPrevEducId(a.student__r.Previous_Education_Codes__c, a);
                enroll.UpdateOriginalGradDate=false;
                enroll.Comment='SFID:'+a.id;
                
                Enrolls.add(enroll);
            }
            
            List<Integer> aa = this.addNewEnrollment(Enrolls);

            
            // ******************* update contact *******************
            CV_Student_Definition.GetStudentOutMsg info = this.getStudentInfo(SyStudentId);
            
            List<Contact> cnn = new List<Contact>();
            for(Id ContactId :con.keySet()){
                cnn.add(new Contact(Id=ContactId, SyStudentId__c=String.ValueOf(con.get(ContactId)), StuNum__c=info.StudentNumber.trim()));
            }
            update cnn;
            
            
            // update ******************* Application__c *******************
            if(Test.IsRunningTest()){
                a.AdEnrollId__c=123654;
            }
            else{
                a.AdEnrollId__c=aa[0];
            }
            a.StuNum__c=NULL;
            update a;
            
        }
        catch(Exception e){
            // if program already exists in CV but reference # (AdEnrollId__c) is not entered into SF, do it here.
            if(e.getMessage().indexOf('The Student specified in the message is already enrolled for this program version and campus.')!=-1 && AdEnrollId==NULL && !Enrolls.isEmpty())
            {
                e=NULL; // clear the error
                
                Integer EnrollId;
                
                List<Map<String,Object>> enrl = viewEnrollment(syStudentId);
                Map<String,Object> ob = new Map<String,Object>();
                Integer SchoolStatusId=NULL;
                
                for(Map<String,Object> obj :enrl)
                {
                    ob=(Map<String,Object>)obj.get('GetEnrollmentInfo');
                    
                    if(Integer.ValueOf(Enrolls[0].ProgramVersionId)==Integer.ValueOf(ob.get('ProgramVersionId'))){
                        
                        EnrollId=Integer.ValueOf(ob.get('EnrollId'));
                        SchoolStatusId=Integer.ValueOf(ob.get('SchoolStatusId'));
                        break;
                    }
                }
                
                // ******************* update AdEnroll ******************
                if(SchoolStatusId==11){
                    this.UpdateEnrollment(SyStudentId, EnrollId, 5); // if CancelEnrollment, make it Enrolled
                }
                
                CV_Student_Definition.GetStudentOutMsg info = this.getStudentInfo(SyStudentId);
                
                a.AdEnrollId__c=EnrollId;
                update a;
                
                // ******************* update contact *******************
                List<Contact> cnn = new List<Contact>();
                for(Id ContactId :con.keySet()){
                    cnn.add(new Contact(Id=ContactId, SyStudentId__c=String.ValueOf(con.get(ContactId)), StuNum__c=info.StudentNumber.trim()));
                }
                update cnn;
            }
            else
                throw e;
        }
    }
    
    webService static string migrate(Id applicationId){
        string rtn='Migration completed successfully!';
        try {
            cvapi c = new cvapi();
            c.doMigrate(applicationId);
        }
        catch(Exception e){
            rtn=e.getMessage();
            String[] txt=rtn.split('Error:');
            
            if(txt.size()>1){
                rtn='CampusNexus: '+txt[1].trim().replace('\n',', ');
            }
        }
        return rtn;
    }
}