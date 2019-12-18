@isTest(SeeAllData=true)
public class CVAPI_Test
{
    Static CVAPI api{get;set;}
    
    static{
        Test.setMock(WebServiceMock.class, new CVAPI_Test.CV_Foundation_Impl ());
        api = new CVAPI();
    }
    
    Static testMethod void test1()
    {
        Contact con = [select id, SyStudentId__c from contact where SyStudentId__c!=NULL limit 1];
        
        Test.setMock(WebServiceMock.class, new CVAPI_Test.CV_getStudentInfo_Impl());
        
        api.getStudentInfo(Integer.ValueOf(con.SyStudentId__c));
        api.getStudentInfo(new List<Integer>{Integer.ValueOf(con.SyStudentId__c)});
    }
    
    Static testMethod void test2() 
    {
        Test.setMock(WebServiceMock.class, new CVAPI_Test.CV_Student_Impl_3());
        
        Contact con = [select id, SyStudentId__c from contact where SyStudentId__c!=NULL limit 1];
        
        CV_Student_Definition.UpdateStudentLeadInMsg upd = new CV_Student_Definition.UpdateStudentLeadInMsg();
        upd.StudentId = Integer.ValueOf(con.SyStudentId__c);
        upd.UpdateFields = new List<CV_Student_Definition.UpdateField>();
        upd.UpdateFields.add(new CV_Student_Definition.UpdateField('FirstName','test'));
        
        api.updateStudentInfo(upd);
        
    }
    
    Static testMethod void test3()
    { 
        Test.setMock(WebServiceMock.class, new CVAPI_test.CV_Lead_Impl_1 ());
        application__c a = [select application_status__c, student__c, student__r.systudentid__c, id, student__r.name, program_code__c, Program_Version__c, student__r.expected_start_date__c,
                            student__r.mailingAddress, student__r.Previous_Education_Codes__c, AdEnrollId__c, High_School_Name__c, HS_Graduation_Date__c,HS_Degree_Received__c,
                            High_School_Country__c,High_School_City__c,High_School_State__c, College_1_Name__c,College_1_Graduation_Date__c,College_1_Degree__c,College_2_Name__c,
                            College_2_Graduation_Date__c,College_2_Degree__c, Disability_Accomodations__c from application__c where student__r.systudentid__c=NULL limit 1];
        Contact c = [select id from contact where id=:a.student__c limit 1];
        api.InsertNewStudent(c.id,a);
        api.InsertNewStudent(new CV_Lead_Definition.LeadInMsg());
    }
    
    Static testMethod void test4()
    {
        Test.setMock(WebServiceMock.class, new CVAPI_test.CV_Enroll_Impl_2 ());
        Contact c = [select id, SyStudentId__c from contact where syStudentId__c!=NULL limit 1];
        CV_Enroll_Definition.EnrollmentInMsg enroll = new CV_Enroll_Definition.EnrollmentInMsg();
        enroll.ApplicationReceivedDate = system.now();
        enroll.EnrollDate = system.now();
        enroll.StudentId=Integer.ValueOf(c.SyStudentId__c);
        enroll.CampusId=5;
        enroll.SchoolStatusId=112; 
        enroll.ProgramVersionId=3753; 
        enroll.BillingMethodId=65;
        enroll.GradeLevelId=6;
        enroll.ShiftId = 8; 
        enroll.ExpectedStartDate = system.now();
        enroll.MidPointDate = system.now();
        enroll.GraduationDate = system.now();
        enroll.IsApplicant=true;
        enroll.AcademicAdvisorId=16111; 
        enroll.ProgramVersionDescription='Recording Arts Version 8';
        enroll.UpdateOriginalGradDate=false;
        
        api.addNewEnrollment(new List<CV_Enroll_Definition.EnrollmentInMsg>{enroll});
    }
    
    Static testMethod void test5(){
        Test.setMock(HttpCalloutMock.class, new RestMock2());
        api.UpdateEnrollment(123, 123, 5);
    }
    
    Static testMethod void test6(){
        Test.setMock(HttpCalloutMock.class, new AllMock());
        Application__c a=[select id from application__c where application_status__c='approved' limit 1];
        api.doMigrate(a.id);
    }
    
    Static testMethod void test7(){
        Contact c = [select id, systudentid__c from contact where systudentid__c!=null limit 1];
        api.UpdateStudents(integer.valueof(c.systudentid__c), c.id);
    }
    
    Static testMethod void test(){
        api.test();
        Map<String, Object> js = new Map<String, Object>();
        js.put('test','fdfdsfs');
        List<String> narrower = new List<String>();
        narrower.add('test');
        api.ExtractData(js, narrower);
        
        Test.setMock(HttpCalloutMock.class, new RestMock());
        api.viewEnrollment(12345);
    }
    
    public class CV_Foundation_Impl implements WebServiceMock {
        public void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
               CV_Message_Definition.TokenResponse respond = new CV_Message_Definition.TokenResponse();
               CV_Foundation.GetAuthorizationTokenResponse_element element = new CV_Foundation.GetAuthorizationTokenResponse_element();
               element.TokenResponse = respond;
               response.put('response_x', element);
           }
    }
    
    public class CV_getStudentInfo_Impl implements WebServiceMock {
        public void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
               CV_Student_Definition.GetStudentInfoResponse respond = new CV_Student_Definition.GetStudentInfoResponse();
               CV_Student.GetStudentInfoResponse_element element = new CV_Student.GetStudentInfoResponse_element();
               element.GetStudentInfoResponse = respond;
               response.put('response_x', element);
           }
    }
    
    public class CV_Student_Impl_3 implements WebServiceMock {
        public void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
               CV_Student_Definition.PostStudentLeadResponse respond = new CV_Student_Definition.PostStudentLeadResponse();
               CV_Student.PostStudentLeadResponse_element element = new CV_Student.PostStudentLeadResponse_element();
               element.PostStudentLeadResponse = respond;
               response.put('response_x', element);
           }
    }
    
    public class CV_Lead_Impl_1 implements WebServiceMock {
        public void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
               CV_Lead_Definition.AddNewLeadResponse respond = new CV_Lead_Definition.AddNewLeadResponse();
               CV_Lead.AddNewLeadResponse_element element = new CV_Lead.AddNewLeadResponse_element();
               element.AddNewLeadResponse = respond;
               response.put('response_x', element);
           }
    }
    
    public class CV_Enroll_Impl_2 implements WebServiceMock {

        public void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
               CV_Enroll_Definition.AddNewEnrollmentResponse respond = new CV_Enroll_Definition.AddNewEnrollmentResponse();
               CV_Enroll.AddNewEnrollmentResponse_element element = new CV_Enroll.AddNewEnrollmentResponse_element();
               element.AddNewEnrollmentResponse = respond;
               response.put('response_x', element);
           }  
    }
    
    class RestMock implements HttpCalloutMock {
        // Implement this interface method
        Public HTTPResponse respond(HTTPRequest req) {
            // Optionally, only send a mock response for a specific endpoint
            // and method.
            System.assertEquals('https://campuslink.lafilm.edu/Cmc.Integration.Webservices.Wcf/GetEnrollment.svc?singleWsdl', req.getEndpoint());
            System.assertEquals('POST', req.getMethod());
    
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/xml');
            res.setBody('<?xml version="1.0" encoding="UTF-8"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Body><GetEnrollmentResponse xmlns="http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd"><GetEnrollmentResult xmlns:a="http://schemas.datacontract.org/2004/07/Cmc.Integration.Wcf.Messages.Academics" xmlns:i="http://www.w3.org/2001/XMLSchema-instance"><ProcessedRequest i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><Status xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">OK</Status><TokenId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">aG/oxhWOeV3OdX3Zaa743Kb/ZpRkCG5cR+A5T1xfXo1GumOi89M6NyepAAbXVViml90MPGXu9NI6l9b6IisILYgPRamN+9Oe0aIpn8sMEmd2rvqJ1GVMkD39ITrpgXMtACplVLpsuoK4wGRnpns0FZ7eHGWkDTMjrlh7eVwB1esaXypWeREgbs86bM+RteA2JSRcyG1xH2XbeEk7mGAKBpDZKsxXuzcYJcM6nLKxHxWta9HSWcXqTNGdqaMjBVIC0uThMOyI9eewOTplrsxyZ4LHlJG5YzSG0TSgwWHzVUV9SqTnmfdeEWa3k9rU7ggVUClTd6CoX4QXDteH5qNIBt8lg2kowPoVdb1CTuGkwLk4jQYYV+jvCy/zMmFG2LK7yiDu3imI6jBw+Z4+y/mCst6bzUPNd8NTegLZP7Rvk078GzAe800CB+bKry9OQFm/q1v+7XwmnS2JLOgF1tyNnD4ZkgClhk7PQKbvo5s6ficp2ce4TfSj4/MZkfGXdE0eOjDLKy9p0wPL/lIpOWiFrOO3XgzYkWNKa3NbAXSIQrvo1aNmNBIqOYzBs0uuVOTq</TokenId><TrxResult xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" /><a:GetEnrollmentOutMessages><a:GetEnrollmentOutMsg><CorrelationId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">0</CorrelationId><CustomAttributes i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><DataSource i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><ExceptionDetail i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><HostName i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><InitialCatalog i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><MessageErrorCode i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><MessageResult i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><MessageStatus xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">OK</MessageStatus><a:EnrollmentInfo><a:GetEnrollmentInfo><a:AppRecDate>2012-06-05T00:00:00</a:AppRecDate><a:Applicant>false</a:Applicant><a:ApplicationDetails i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:CampusCode>MAIN</a:CampusCode><a:CampusDescription>Los Angeles Film School</a:CampusDescription><a:CampusId>5</a:CampusId><a:CatalogYearCode /><a:CatalogYearDescription /><a:CatalogYearId i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:CurrentEnrollment>false</a:CurrentEnrollment><a:DateLastModified>2017-06-05T12:29:21.08</a:DateLastModified><a:DocumentDetails i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:EnrollDate>2012-06-04T00:00:00</a:EnrollDate><a:EnrollId>75697</a:EnrollId><a:EnrollmentDetail i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:ExpStartDate>2012-06-05T00:00:00</a:ExpStartDate><a:ExternBeginDate i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:GradDate>2014-06-01T00:00:00</a:GradDate><a:MidDate>2013-06-03T00:00:00</a:MidDate><a:ProgramCode>ASRA</a:ProgramCode><a:ProgramDescrip>Associate of Science in Recording Arts</a:ProgramDescrip><a:ProgramId>10</a:ProgramId><a:ProgramVersionCode>ASRE022811</a:ProgramVersionCode><a:ProgramVersionDescription>Extended Recording Arts V4</a:ProgramVersionDescription><a:ProgramVersionId>3696</a:ProgramVersionId><a:SchoolStatusCode>TOPROG</a:SchoolStatusCode><a:SchoolStatusDescription>Transfer To Other Program</a:SchoolStatusDescription><a:SchoolStatusId>24</a:SchoolStatusId></a:GetEnrollmentInfo><a:GetEnrollmentInfo><a:AppRecDate>2013-03-29T00:00:00</a:AppRecDate><a:Applicant>false</a:Applicant><a:ApplicationDetails i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:CampusCode>MAIN</a:CampusCode><a:CampusDescription>Los Angeles Film School</a:CampusDescription><a:CampusId>5</a:CampusId><a:CatalogYearCode /><a:CatalogYearDescription /><a:CatalogYearId i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:CurrentEnrollment>false</a:CurrentEnrollment><a:DateLastModified>2017-06-05T12:29:21.237</a:DateLastModified><a:DocumentDetails i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:EnrollDate>2013-03-29T00:00:00</a:EnrollDate><a:EnrollId>78740</a:EnrollId><a:EnrollmentDetail i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:ExpStartDate>2013-03-29T00:00:00</a:ExpStartDate><a:ExternBeginDate i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:GradDate>2014-09-28T00:00:00</a:GradDate><a:MidDate>2013-12-06T00:00:00</a:MidDate><a:ProgramCode>ASRA</a:ProgramCode><a:ProgramDescrip>Associate of Science in Recording Arts</a:ProgramDescrip><a:ProgramId>10</a:ProgramId><a:ProgramVersionCode>ASRE010713</a:ProgramVersionCode><a:ProgramVersionDescription>Extended Recording Arts V5</a:ProgramVersionDescription><a:ProgramVersionId>3716</a:ProgramVersionId><a:SchoolStatusCode>WITHDRAW</a:SchoolStatusCode><a:SchoolStatusDescription>Withdrawn</a:SchoolStatusDescription><a:SchoolStatusId>112</a:SchoolStatusId></a:GetEnrollmentInfo><a:GetEnrollmentInfo><a:AppRecDate>2016-07-26T00:00:00</a:AppRecDate><a:Applicant>false</a:Applicant><a:ApplicationDetails i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:CampusCode>MAIN</a:CampusCode><a:CampusDescription>Los Angeles Film School</a:CampusDescription><a:CampusId>5</a:CampusId><a:CatalogYearCode /><a:CatalogYearDescription /><a:CatalogYearId i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:CurrentEnrollment>false</a:CurrentEnrollment><a:DateLastModified>2017-06-05T12:29:34.087</a:DateLastModified><a:DocumentDetails i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:EnrollDate>2016-07-26T00:00:00</a:EnrollDate><a:EnrollId>94774</a:EnrollId><a:EnrollmentDetail i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:ExpStartDate>2016-07-26T00:00:00</a:ExpStartDate><a:ExternBeginDate i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:GradDate>2018-07-01T00:00:00</a:GradDate><a:MidDate>2017-04-04T00:00:00</a:MidDate><a:ProgramCode>ASRA</a:ProgramCode><a:ProgramDescrip>Associate of Science in Recording Arts</a:ProgramDescrip><a:ProgramId>10</a:ProgramId><a:ProgramVersionCode>ASRA050415</a:ProgramVersionCode><a:ProgramVersionDescription>Recording Arts Version 8</a:ProgramVersionDescription><a:ProgramVersionId>3753</a:ProgramVersionId><a:SchoolStatusCode>WITHDRAW</a:SchoolStatusCode><a:SchoolStatusDescription>Withdrawn</a:SchoolStatusDescription><a:SchoolStatusId>112</a:SchoolStatusId></a:GetEnrollmentInfo><a:GetEnrollmentInfo><a:AppRecDate>2017-06-04T00:00:00</a:AppRecDate><a:Applicant>false</a:Applicant><a:ApplicationDetails i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:CampusCode>MAIN</a:CampusCode><a:CampusDescription>Los Angeles Film School</a:CampusDescription><a:CampusId>5</a:CampusId><a:CatalogYearCode /><a:CatalogYearDescription /><a:CatalogYearId i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:CurrentEnrollment>true</a:CurrentEnrollment><a:DateLastModified>2017-06-30T11:33:12.783</a:DateLastModified><a:DocumentDetails i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:EnrollDate>2017-06-30T00:00:00</a:EnrollDate><a:EnrollId>100068</a:EnrollId><a:EnrollmentDetail i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:ExpStartDate>2017-06-04T00:00:00</a:ExpStartDate><a:ExternBeginDate i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:GradDate>2018-07-26T00:00:00</a:GradDate><a:MidDate>2017-06-30T00:00:00</a:MidDate><a:ProgramCode>BSGD-O</a:ProgramCode><a:ProgramDescrip>O-Bachelor of Science in Graphic Design</a:ProgramDescrip><a:ProgramId>51</a:ProgramId><a:ProgramVersionCode>BSGDOV1</a:ProgramVersionCode><a:ProgramVersionDescription>Online Graphic Design V1</a:ProgramVersionDescription><a:ProgramVersionId>3754</a:ProgramVersionId><a:SchoolStatusCode>FUT</a:SchoolStatusCode><a:SchoolStatusDescription>Enrolled</a:SchoolStatusDescription><a:SchoolStatusId>5</a:SchoolStatusId></a:GetEnrollmentInfo></a:EnrollmentInfo><a:StuNum>38669</a:StuNum><a:StudentId>1087777</a:StudentId></a:GetEnrollmentOutMsg></a:GetEnrollmentOutMessages></GetEnrollmentResult></GetEnrollmentResponse></s:Body></s:Envelope>');
            res.setStatusCode(200);
            return res;
        }
    }
    
    class RestMock2 implements HttpCalloutMock {
        // Implement this interface method
        public HTTPResponse respond(HTTPRequest req) {
            // Optionally, only send a mock response for a specific endpoint
            // and method.
            System.assertEquals('https://campuslink.lafilm.edu/Cmc.Integration.Webservices/PostStudentStatusService.asmx', req.getEndpoint());
            System.assertEquals('POST', req.getMethod());
    
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/xml');
            res.setBody('<?xml version="1.0" encoding="utf-8" ?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'+
                        '<soap:Header><ResponseHeader xmlns="http://www.campusmgmt.com/Soa/Foundation/"><Headers /></ResponseHeader></soap:Header>'+
                        '<soap:Body><PostStudentStatusResponse xmlns="http://www.campusmgmt.com/Soa/Foundation/">'+
                        '<PostStudentStatusResponse xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd">'+
                        '<Status>OK</Status> <TrxResult>OK</TrxResult>'+
                        '<TokenId>lUPZUGbE0rd3wAfdE8ajgcbQlbrLg4CCed6qDfDQApYrH88clG0pcmxpPWNbn7Vtyq6n+uu86Z2H5Qn2gIpLdURfR0QAB7afj+VZ+kRHqLLucseSe4uRePU3MoYZAMtVzalL6I01BpgNiNLz</TokenId>'+
                        '<PostStudentStatuss><PostStudentStatusOutMsg><MessageId>0</MessageId><MessageResult /><MessageErrorCode /><AdEnrollId>102672</AdEnrollId>'+
                        '<PostStudentStatusMessageResult>Enrollment school status is successfully changed to - FUT</PostStudentStatusMessageResult></PostStudentStatusOutMsg>'+
                        '</PostStudentStatuss></PostStudentStatusResponse></PostStudentStatusResponse></soap:Body></soap:Envelope>');
            res.setStatusCode(200);
            return res;
        }
    }
    
    class AllMock implements HttpCalloutMock {
        
        public HTTPResponse respond(HTTPRequest req) {
            
            HttpResponse res = new HttpResponse();
            
            if (req.getEndpoint().endsWith('PostStudentStatusService.asmx')) {
                Test.setMock(HttpCalloutMock.class, new RestMock2());
            } 
            else if (req.getEndpoint().endsWith('GetEnrollment.svc?singleWsdl')) {
                Test.setMock(HttpCalloutMock.class, new RestMock());
            } 
            else if (req.getEndpoint().endsWith('Authentication.asmx')) {
                Test.setMock(HttpCalloutMock.class, new CV_Foundation_Impl());
            } 
            else {
                System.assert(false, 'unexpected endpoint ' + req.getEndpoint());
            }
            
            return res;
        }
    }
}