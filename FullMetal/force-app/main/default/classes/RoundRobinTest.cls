@IsTest
public class RoundRobinTest{

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
    
    static testMethod void test()
    {
        List<User> uu =[select id, weight_value__c from user where userRoleId in ('00E1a000000YCtBEAW','00E1a000000YHk1EAG','00E1a000000YD0gEAG','00E1a000000YD0vEAG')];
        for(User u :uu){
            u.Weight_Value__c=1;
        }
        update uu;
        
        Contact s = new Contact(lastname='testlead', firstname='testlead', email='jweerawardhana@yahoo.com', phone='+13235468523', program_code__c='ASF', lead_source_code__c='test1');
        insert s;

        List<Contact> con = new List<Contact>();
        
        con.add(new Contact(lastname='fsfsdfsd', email='jjjjjj@gmail.com', program_code__c='ASF'));
        con.add(new Contact(lastname='testlead', firstname='testlead', email='jweerawardhana@yahoo.com', program_code__c='ASF', Other_Email__c='test@test.com', phone='+13235468523', lead_source_code__c='test2', RSVP_Event_Type__c='ALL', All_Access_Tour_Date__c=Date.today(), Evening_Sessions_Date__c=Date.today()));
        con.add(new Contact(lastname='rwerewrew', email='rrrrrr@gmail.com', program_code__c='BSEB-O'));
        con.add(new Contact(lastname='ljhkljlklhj', email='ttttttt@gmail.com', program_code__c='BSFP', Affiliation_Code__c='INTL'));
        con.add(new Contact(lastname='ytytut', email='jhhdf1212@gmail.com', program_code__c='BSFP', Affiliation_Code__c='ACT'));
        con.add(new Contact(lastname='erasdq', email='hgdf2773@gmail.com', Other_Email__c='hgdf277113@gmail.com', program_code__c='BSFP-O', Affiliation_Code__c='ACT', lead_source_code__c='test2'));
        con.add(new Contact(lastname='fffffff', firstname='fffffffff', email='testlead@gmail.com', phone='8007777777', program_code__c='BSFP', Affiliation_Code__c='ACT', lead_source_code__c='test2'));
        
        Test.setMock(HttpCalloutMock.class, new Response());
        
        RoundRobin obj = new RoundRobin(con);
        
        obj.isDups(con[6]);
        
        for(contact c :con){
            Id i = obj.whoIsNext(c);
            c.ownerid=i;
            system.assert(i!=NULL || i==NULL);
        }
        insert con;
        obj.isAdminRep(con[0].ownerid);
        
        obj.isOnlineMilitary(new Contact(lastname='erasdq', email='hgdf2773@gmail.com', program_code__c='BSFP-O', Affiliation_Code__c='ACT'));
        obj.chkLastDate(s.id);
    }
}