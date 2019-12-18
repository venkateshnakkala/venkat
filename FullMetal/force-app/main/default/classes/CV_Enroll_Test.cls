@isTest
public class CV_Enroll_Test{
    Static testMethod void test1(){
        Test.setMock(WebServiceMock.class, new CV_Enroll_test.CV_Enroll_Impl_1());
        
        CV_Enroll.EnrollmentWebServiceSoap service = new CV_Enroll.EnrollmentWebServiceSoap();
        CV_Enroll_Definition.AddNewEnrollmentRequest request = new CV_Enroll_Definition.AddNewEnrollmentRequest();
        CV_Enroll_Definition.AddNewEnrollmentResponse response = new CV_Enroll_Definition.AddNewEnrollmentResponse();
        
        response=service.AddNewEnrollmentBatch(request);
        
        CV_Enroll.ArrayOfAnyType an = new CV_Enroll.ArrayOfAnyType();
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        
        CV_Enroll.ResponseHeader rh = new CV_Enroll.ResponseHeader();
        rh.Headers = an;
        
        CV_Enroll.RequestHeader rq = new CV_Enroll.RequestHeader();
        rq.Headers = an;
        
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
    }
    
    Static testMethod void test2(){
        Test.setMock(WebServiceMock.class, new CV_Enroll_test.CV_Enroll_Impl_2());
        
        CV_Enroll.EnrollmentWebServiceSoap service = new CV_Enroll.EnrollmentWebServiceSoap();
        CV_Enroll_Definition.AddNewEnrollmentRequest request = new CV_Enroll_Definition.AddNewEnrollmentRequest();
        CV_Enroll_Definition.AddNewEnrollmentResponse response = new CV_Enroll_Definition.AddNewEnrollmentResponse();
        
        response=service.AddNewEnrollment(request);
        
        CV_Enroll_Definition.ArrayOfEnrollmentInMsg a = new CV_Enroll_Definition.ArrayOfEnrollmentInMsg();
        CV_Enroll_Definition.EnrollmentInMsg b = new CV_Enroll_Definition.EnrollmentInMsg();
        CV_Enroll_Definition.ArrayOfCustomAttributeMsg c = new CV_Enroll_Definition.ArrayOfCustomAttributeMsg();
        CV_Enroll_Definition.EnrollmentAdvisorMsg d = new CV_Enroll_Definition.EnrollmentAdvisorMsg();
        CV_Enroll_Definition.EnrollmentOutMsg e = new CV_Enroll_Definition.EnrollmentOutMsg();
        CV_Enroll_Definition.AreaOfStudyMsg f = new CV_Enroll_Definition.AreaOfStudyMsg();
        CV_Enroll_Definition.CustomAttributeMsg g = new CV_Enroll_Definition.CustomAttributeMsg();
        CV_Enroll_Definition.ArrayOfEnrollmentOutMsg h = new CV_Enroll_Definition.ArrayOfEnrollmentOutMsg();
    }
    
    class CV_Enroll_Impl_1 implements WebServiceMock {
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
               CV_Enroll.AddNewEnrollmentBatchResponse_element element = new CV_Enroll.AddNewEnrollmentBatchResponse_element();
               element.AddNewEnrollmentResponse = respond;
               response.put('response_x', element);
           }
    }
    
    class CV_Enroll_Impl_2 implements WebServiceMock {
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
}