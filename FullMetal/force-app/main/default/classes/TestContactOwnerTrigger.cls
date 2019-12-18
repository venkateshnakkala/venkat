@isTest(SeeAllData=true)
public class TestContactOwnerTrigger {
    
    class Response implements system.HttpCalloutMock {
        
        public HttpResponse respond(HttpRequest req) 
        {
            HttpResponse res = new HttpResponse();
            res.setBody('<?xml version="1.0" encoding="utf-16"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                        'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+
                        '<soapenv:Body><ns1:leadAddResponse soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="http://listloader.system.intelliqueue"> '+
                        '<leadAddReturn xsi:type="xsd:string">&lt;?xml version="1.0" encoding="UTF-8"?&gt; &lt;response&gt; &lt;status&gt;OK&lt;/status&gt; '+
                        '&lt;message&gt;&lt;![CDATA[Element LEAD_ADD.METADATA.SECURITY_KEY.XMLTEXT is undefined in XML.]]&gt;&lt;/message&gt; '+
                        '&lt;detail/&gt; &lt;list_id&gt;0&lt;/list_id&gt; &lt;failures&gt; &lt;/failures&gt; &lt;accepted&gt; &lt;/accepted&gt; '+
                        '&lt;/response&gt;</leadAddReturn> </ns1:leadAddResponse> '+
                        '<ns1:leadRemoveResponse soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="http://listloader.system.intelliqueue"> '+
                        '<leadRemoveReturn xsi:type="xsd:string">&lt;?xml version="1.0" encoding="UTF-8"?&gt; &lt;response&gt; &lt;status&gt;OK&lt;/status&gt; '+
                        '&lt;message&gt;&lt;![CDATA[Element LEAD_ADD.METADATA.SECURITY_KEY.XMLTEXT is undefined in XML.]]&gt;&lt;/message&gt; '+
                        '&lt;detail/&gt; &lt;list_id&gt;0&lt;/list_id&gt; &lt;failures&gt; &lt;/failures&gt; &lt;accepted&gt; &lt;/accepted&gt; '+
                        '&lt;/response&gt;</leadRemoveReturn> </ns1:leadRemoveResponse> </soapenv:Body></soapenv:Envelope>');
            res.setStatusCode(200);
            res.setStatus('OK');
            return res;
        }
        
    }
    static testmethod void test()
    {
        Test.setMock(HttpCalloutMock.class, new Response());
        Account acc = New Account(Name = 'Test Account');
        insert acc;
        
        Contact con = New contact ();
        con.LastName = 'con';
        con.AccountId = acc.Id;
        con.school_status__c = 'Connected';
        con.Lead_Source_Code__c = 'ARIZONA';
        
        insert con;
        
        con.school_status__c = 'Test';
        update con;
        
        con.school_status__c = 'connected';
        update con; 
        
        Contact con2 = New contact ();
        con2=[select id, ownerid from contact where id=:con.id];  
        
        Profile p =[select id from profile where name='Admissions Rep' limit 1];
        User r =[select id from user where profileid=:p.id and isActive=true and id!=:con2.ownerid limit 1];
        
        con2.Program_Code__c='ASF';
        con2.ownerId=r.id;
        
        update con2;
    }
}