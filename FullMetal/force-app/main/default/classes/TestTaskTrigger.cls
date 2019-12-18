@isTest
public class TestTaskTrigger {

    public class CalloutClass {
        public HttpResponse getInfoFromExternalService() {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('http://api.salesforce.com/foo/bar');
            req.setMethod('GET');
            Http h = new Http();
            HttpResponse res = h.send(req);
            return res;
        }
    }

      static testmethod void test()
      {

        Test.startTest();

          Account acc = New Account(Name = 'Test Account');
          insert acc;
          
          Test.setMock(HttpCalloutMock.class, new TestMockService());
          
          Contact con = New contact ();
          con.LastName = 'con';
          con.AccountId = acc.Id;
          insert con;
          
          Event evt = New Event ();
          evt.Event_Subject__c = 'Test';
          evt.StartDateTime = system.now();
          evt.EndDateTime = system.now();
          evt.WhoId = con.id;
          insert evt; 
          
            date duedate = system.today();
            date newdate = duedate.addDays(1);
          
          /*Task t = [SELECT id,event_id__c 
                    FROM Task 
                    WHERE event_id__c = : evt.id];                   

          
          
          t.Event_Results__C = 'Conducted';
          t.ActivityDate = newdate;
          t.Event_Results__c = 'No Show';
          update t;*/
          
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