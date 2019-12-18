@isTest
public class CV_Foundation_Test{
    Static testMethod void test1(){
        Test.setMock(WebServiceMock.class, new CV_Foundation_test.CV_Foundation_Impl());
        
        CV_Foundation.AuthenticationSoap service = new CV_Foundation.AuthenticationSoap();
        CV_Message_Definition.TokenRequest request = new CV_Message_Definition.TokenRequest();
        CV_Message_Definition.TokenResponse response = new CV_Message_Definition.TokenResponse();
        
        response=service.GetAuthorizationToken(request);
        
        CV_Foundation.ArrayOfAnyType an = new CV_Foundation.ArrayOfAnyType();
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        
        CV_Foundation.ResponseHeader rh = new CV_Foundation.ResponseHeader();
        rh.Headers = an;
        
        CV_Foundation.RequestHeader rq = new CV_Foundation.RequestHeader();
        rq.Headers = an;
        
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
    }
    
    class CV_Foundation_Impl implements WebServiceMock {
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
}