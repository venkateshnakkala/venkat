@isTest(SeeAllData=true)
global class TOGSchedulable_test{

    public class Response implements system.HttpCalloutMock {
        
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
        
    static testMethod void test() 
    {
         Test.setMock(HttpCalloutMock.class, new Response());
         TOGSchedulable myClass = new TOGSchedulable();   
         String chron = '0 0 23 * * ?';        
         system.schedule('Test Sched', chron, myClass);
    }
}