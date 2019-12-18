@isTest(seeAllData=true)
public class TestHttpPostToCVAppsTrigger {
      void test()
      {
          Test.startTest();
          Contact con = New contact ();
          con.FirstName = 'test';
          con.LastName = 'con';
          insert con;
          
          Test.setMock(HttpCalloutMock.class, new TestMockService());
          
          Application__c appObj = new Application__c();
          appObj.Student__c = con.Id;
          insert appObj;  
          
          Test.stopTest();
      }
      
          //Mockup service
    private class TestMockService implements HttpCalloutMock {

        public HTTPResponse respond(HTTPRequest req) {
            String response ;
            HTTPResponse res = new HTTPResponse();
            res.setStatusCode(200);

            res.setBody(response);
            return res;
        }
    }
}