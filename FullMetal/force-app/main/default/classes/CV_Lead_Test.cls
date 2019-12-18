@isTest
public class CV_Lead_Test{
    Static testMethod void test1(){
        Test.setMock(WebServiceMock.class, new CV_Lead_test.CV_Lead_Impl_1());
        
        CV_Lead.LeadsWebServiceSoap service = new CV_Lead.LeadsWebServiceSoap();
        CV_Lead_Definition.AddNewLeadRequest  request = new CV_Lead_Definition.AddNewLeadRequest();
        CV_Lead_Definition.AddNewLeadResponse response = new CV_Lead_Definition.AddNewLeadResponse();
        
        response=service.AddNewLead(request);

        CV_Lead.ArrayOfAnyType an = new CV_Lead.ArrayOfAnyType();
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};
        
        CV_Lead.ResponseHeader rh = new CV_Lead.ResponseHeader();
        rh.Headers = an;
        
        CV_Lead.RequestHeader rq = new CV_Lead.RequestHeader();
        rq.Headers = an;
        
        an.MyAnyType = new List<String>{'ffds','fsdfdss'};

    }
    
    Static testMethod void test2(){
        Test.setMock(WebServiceMock.class, new CV_Lead_test.CV_Lead_Impl_2());
        
        CV_Lead.LeadsWebServiceSoap service = new CV_Lead.LeadsWebServiceSoap ();
        CV_Lead_Definition.AddNewLeadRequest  request = new CV_Lead_Definition.AddNewLeadRequest();
        CV_Lead_Definition.AddNewLeadResponse response = new CV_Lead_Definition.AddNewLeadResponse();
        
        response=service.AddNewLeadBatch(request);
        
        CV_Lead_Definition.LeadInMsg a = new CV_Lead_Definition.LeadInMsg();
        CV_Lead_Definition.ArrayOfCustomAttributeMsg b = new CV_Lead_Definition.ArrayOfCustomAttributeMsg();
        CV_Lead_Definition.ArrayOfLeadInMsg c = new CV_Lead_Definition.ArrayOfLeadInMsg();
        CV_Lead_Definition.ArrayOfLeadOutMsg d = new CV_Lead_Definition.ArrayOfLeadOutMsg();
        CV_Lead_Definition.LeadOutMsg e = new CV_Lead_Definition.LeadOutMsg();
        CV_Lead_Definition.LeadMsg f = new CV_Lead_Definition.LeadMsg();
        CV_Lead_Definition.CustomAttributeMsg g = new CV_Lead_Definition.CustomAttributeMsg();
        
    }
    
    class CV_Lead_Impl_1 implements WebServiceMock {
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
    
    class CV_Lead_Impl_2 implements WebServiceMock {
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
               CV_Lead.AddNewLeadBatchResponse_element element = new CV_Lead.AddNewLeadBatchResponse_element();
               element.AddNewLeadResponse = respond;
               response.put('response_x', element);
           }
    }
}