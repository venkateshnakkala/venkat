@isTest
public class CV_Student_Test{

    Static testMethod void test1(){
        Test.setMock(WebServiceMock.class, new CV_Student_Test.CV_Student_Impl_1());
        
        CV_Student.StudentWebServiceSoap service = new CV_Student.StudentWebServiceSoap();
        
        CV_Student_Definition.GetStudentInfoResponse response1 = new CV_Student_Definition.GetStudentInfoResponse();
        CV_Student_Definition.GetStudentInfoRequest request1 = new CV_Student_Definition.GetStudentInfoRequest();
        response1=service.GetStudentInfo(request1);
        
        CV_Student.ArrayOfAnyType an = new CV_Student.ArrayOfAnyType();
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        
        CV_Student.ResponseHeader rh = new CV_Student.ResponseHeader();
        rh.Headers = an;
        
        CV_Student.RequestHeader rq = new CV_Student.RequestHeader();
        rq.Headers = an;
        
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        
        CV_Student_Definition.LeadSourceMsg a = new CV_Student_Definition.LeadSourceMsg();
        CV_Student_Definition.ArrayOfUpdateStudentInMsg b = new CV_Student_Definition.ArrayOfUpdateStudentInMsg();
        CV_Student_Definition.ArrayOfPostStudentInquiryInMsg c = new CV_Student_Definition.ArrayOfPostStudentInquiryInMsg();
        CV_Student_Definition.ArrayOfGetStudentOutMsg d = new CV_Student_Definition.ArrayOfGetStudentOutMsg();
        CV_Student_Definition.PostStudentLeadRequest e = new CV_Student_Definition.PostStudentLeadRequest();
        CV_Student_Definition.UpdateField f = new CV_Student_Definition.UpdateField('test','test');
        CV_Student_Definition.UpdateStudentInfoResponse g = new CV_Student_Definition.UpdateStudentInfoResponse();
        CV_Student_Definition.UpdateStudentLeadOutMsg h = new CV_Student_Definition.UpdateStudentLeadOutMsg();
        CV_Student_Definition.UpdateStudentInfoRequest i = new CV_Student_Definition.UpdateStudentInfoRequest();
        CV_Student_Definition.PostStudentLeadOutMsg j = new CV_Student_Definition.PostStudentLeadOutMsg();
        CV_Student_Definition.ArrayOfUpdateStudentLeadOutMsg k = new CV_Student_Definition.ArrayOfUpdateStudentLeadOutMsg();
        CV_Student_Definition.PostStudentInquiryRequest l = new CV_Student_Definition.PostStudentInquiryRequest();
        CV_Student_Definition.ArrayOfGetStudentInMsg m = new CV_Student_Definition.ArrayOfGetStudentInMsg();
        CV_Student_Definition.GetStudentInMsg n = new CV_Student_Definition.GetStudentInMsg();
        
        CV_Student_Definition.CustomAttributeMsg o = new CV_Student_Definition.CustomAttributeMsg();
        CV_Student_Definition.ArrayOfUpdateStudentLeadInMsg p = new CV_Student_Definition.ArrayOfUpdateStudentLeadInMsg();
        CV_Student_Definition.PostStudentLeadInMsg q = new CV_Student_Definition.PostStudentLeadInMsg();
        CV_Student_Definition.PostStudentInquiryResponse r = new CV_Student_Definition.PostStudentInquiryResponse();
        CV_Student_Definition.PostStudentInquiryOutMsg s = new CV_Student_Definition.PostStudentInquiryOutMsg();
        
        CV_Student_Definition.ArrayOfCustomAttributeMsg t = new CV_Student_Definition.ArrayOfCustomAttributeMsg();
        CV_Student_Definition.UpdateStudentInMsg u = new CV_Student_Definition.UpdateStudentInMsg();
        CV_Student_Definition.ArrayOfUpdateStudentOutMsg v = new CV_Student_Definition.ArrayOfUpdateStudentOutMsg();
        CV_Student_Definition.PostStudentLeadResponse w = new CV_Student_Definition.PostStudentLeadResponse();
        CV_Student_Definition.ArrayOfPostStudentInquiryOutMsg x = new CV_Student_Definition.ArrayOfPostStudentInquiryOutMsg();
        
        CV_Student_Definition.StudentMsg z = new CV_Student_Definition.StudentMsg();
        CV_Student_Definition.UpdateStudentOutMsg aa = new CV_Student_Definition.UpdateStudentOutMsg();
        CV_Student_Definition.UpdateStudentLeadInMsg bb = new CV_Student_Definition.UpdateStudentLeadInMsg();
        CV_Student_Definition.LeadSourceInfo cc = new CV_Student_Definition.LeadSourceInfo();
        CV_Student_Definition.PostStudentInquiryInMsg dd = new CV_Student_Definition.PostStudentInquiryInMsg();
        
        CV_Student_Definition.GetStudentOutMsg ee = new CV_Student_Definition.GetStudentOutMsg();

    }
    
    Static testMethod void test2(){

        Test.setMock(WebServiceMock.class, new CV_Student_Test.CV_Student_Impl_2());
        
        CV_Student.StudentWebServiceSoap service = new CV_Student.StudentWebServiceSoap();
        
        CV_Student_Definition.PostStudentInquiryResponse response2 = new CV_Student_Definition.PostStudentInquiryResponse();
        CV_Student_Definition.PostStudentInquiryRequest request2 = new CV_Student_Definition.PostStudentInquiryRequest();
        response2=service.PostStudentInquiry(request2);
        
        /*
        CV_Foundation.ArrayOfAnyType an = new CV_Foundation.ArrayOfAnyType();
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        
        CV_Foundation.ResponseHeader rh = new CV_Foundation.ResponseHeader();
        rh.Headers = an;
        
        CV_Foundation.RequestHeader rq = new CV_Foundation.RequestHeader();
        rq.Headers = an;
        
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        */
    }
    
    Static testMethod void test3(){

        Test.setMock(WebServiceMock.class, new CV_Student_Test.CV_Student_Impl_3());
        
        CV_Student.StudentWebServiceSoap service = new CV_Student.StudentWebServiceSoap();
        
        CV_Student_Definition.PostStudentLeadResponse response3 = new CV_Student_Definition.PostStudentLeadResponse();
        CV_Student_Definition.PostStudentLeadRequest request3 = new CV_Student_Definition.PostStudentLeadRequest();
        response3=service.PostStudentLead(request3);
        
        /*
        CV_Foundation.ArrayOfAnyType an = new CV_Foundation.ArrayOfAnyType();
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        
        CV_Foundation.ResponseHeader rh = new CV_Foundation.ResponseHeader();
        rh.Headers = an;
        
        CV_Foundation.RequestHeader rq = new CV_Foundation.RequestHeader();
        rq.Headers = an;
        
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        */
    }
    
    Static testMethod void test4(){

        Test.setMock(WebServiceMock.class, new CV_Student_Test.CV_Student_Impl_4());
        
        
        CV_Student.StudentWebServiceSoap service = new CV_Student.StudentWebServiceSoap();
        
        CV_Student_Definition.UpdateStudentInfoResponse response4 = new CV_Student_Definition.UpdateStudentInfoResponse ();
        CV_Student_Definition.UpdateStudentInfoRequest request4 = new CV_Student_Definition.UpdateStudentInfoRequest();
        response4=service.UpdateStudentInfo(request4);
        
        /*
        CV_Foundation.ArrayOfAnyType an = new CV_Foundation.ArrayOfAnyType();
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        
        CV_Foundation.ResponseHeader rh = new CV_Foundation.ResponseHeader();
        rh.Headers = an;
        
        CV_Foundation.RequestHeader rq = new CV_Foundation.RequestHeader();
        rq.Headers = an;
        
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        */
    }
    
    class CV_Student_Impl_1 implements WebServiceMock {
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
    
    class CV_Student_Impl_2 implements WebServiceMock {
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
               CV_Student_Definition.PostStudentInquiryResponse respond = new CV_Student_Definition.PostStudentInquiryResponse();
               CV_Student.PostStudentInquiryResponse_element element = new CV_Student.PostStudentInquiryResponse_element();
               element.PostStudentInquiryResponse = respond;
               response.put('response_x', element);
           }
    }
    
    class CV_Student_Impl_3 implements WebServiceMock {
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
    
    class CV_Student_Impl_4 implements WebServiceMock {
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
               CV_Student_Definition.UpdateStudentInfoResponse respond = new CV_Student_Definition.UpdateStudentInfoResponse();
               CV_Student.UpdateStudentInfoResponse_element element = new CV_Student.UpdateStudentInfoResponse_element();
               element.UpdateStudentInfoResponse = respond;
               response.put('response_x', element);
           }
    }
}