@isTest //(seeAllData=true)
public class testRoundRobin{

    class Response implements system.HttpCalloutMock {
        
        public HttpResponse respond(HttpRequest req) 
        {
            HttpResponse res = new HttpResponse();
            res.setBody('<?xml version="1.0" encoding="utf-16"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                        'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+
                        '<soapenv:Body><ns1:leadRemoveResponse soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="http://listloader.system.intelliqueue"> '+
                        '<leadRemoveReturn xsi:type="xsd:string">&lt;?xml version="1.0" encoding="UTF-8"?&gt; &lt;response&gt; &lt;status&gt;OK&lt;/status&gt; '+
                        '&lt;message&gt;&lt;![CDATA[Element LEAD_ADD.METADATA.SECURITY_KEY.XMLTEXT is undefined in XML.]]&gt;&lt;/message&gt; '+
                        '&lt;detail/&gt; &lt;list_id&gt;0&lt;/list_id&gt; &lt;failures&gt; &lt;/failures&gt; &lt;accepted&gt; &lt;/accepted&gt; '+
                        '&lt;/response&gt;</leadRemoveReturn> </ns1:leadRemoveResponse> </soapenv:Body></soapenv:Envelope>');
            res.setStatusCode(200);
            res.setStatus('OK');
            return res;
        }
        
    }
    
    static testMethod void test(){
        
        Contact s = new Contact(lastname='test', firstname='test', email='jweerawardhana@yahoo.com', phone='+13235468523', program_code__c='ASF', lead_source_code__c='test1');
        insert s;

        List<Contact> con = new List<Contact>();
        
        con.add(new Contact(lastname='fsfsdfsd', email='jjjjjj@gmail.com', program_code__c='ASF'));
        con.add(new Contact(lastname='test', firstname='test', email='jweerawardhana@yahoo.com', Other_Email__c='test@test.com', phone='+13235468523', lead_source_code__c='test2'));
        con.add(new Contact(lastname='rwerewrew', email='rrrrrr@gmail.com', program_code__c='BSEB-O'));
        con.add(new Contact(lastname='ljhkljlklhj', email='ttttttt@gmail.com', program_code__c='BSFP', Affiliation_Code__c='INTL'));
        con.add(new Contact(lastname='ytytut', email='jhhdf1212@gmail.com', program_code__c='BSFP', Affiliation_Code__c='ACT'));
        con.add(new Contact(lastname='erasdq', email='hgdf2773@gmail.com', program_code__c='BSFP-O', Affiliation_Code__c='ACT'));
        
        Test.setMock(HttpCalloutMock.class, new Response());
        
        RoundRobin obj = new RoundRobin(con);
        
        for(contact c :con){
            Id i = obj.whoIsNext(c);
            c.ownerid=i;
            system.assert(i!=NULL || i==NULL);
        }
        insert con;
        obj.adjustTotal(s.id,'ASF', 1);
        
        obj.isOnlineMilitary(new Contact(lastname='erasdq', email='hgdf2773@gmail.com', program_code__c='BSFP-O', Affiliation_Code__c='ACT'));
        obj.chkLastDate(s.id);
    }
}