@isTest(SeeAllData=true)
global class TOG_test
{

    
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

    public testmethod static void test1()
    {
        Test.setMock(HttpCalloutMock.class, new Response());
        List<User> u = [select id from user where isActive=true and id!='0051a000002tHWnAAM' limit 20];
        
        List<Contact> con =  [select Id,DoNotCall,OwnerId,Phone,School_Status__c,Email,FirstName,High_School_Graduation_Year__c,LastName,Lead_Date__c,Lead_Source__c,Lead_Source_Code__c,MailingPostalCode,Program__c,Program_Code__c,Affiliation_Code__c,Exclude_TOG__c from contact where phone!=NULL and Program_Code__c in ('ASMP-O') and OwnerId='0051a000002tHWnAAM' and DoNotCall=false limit 2];
        
        Map<Id,Contact> n = new Map<Id,Contact>();
        Map<Id,Contact> o = new Map<Id,Contact>();
        
        for(Contact c :con)
        {
            n.put(c.id, c);
            o.put(c.id, c);
        }
        
        o.get(con[0].id).OwnerId=u[18].id;
        
        Test.setMock(HttpCalloutMock.class, new Response());
        TOG t = new TOG(n,o);
        Database.ExecuteBatch(t);
    }
    
    public testmethod static void test2()
    {
        Test.setMock(HttpCalloutMock.class, new Response());
        List<User> u = [select id from user where isActive=true and id!='0051a000002tHWnAAM' limit 20];
        
        List<Contact> con =  [select Id,DoNotCall,OwnerId,Phone,School_Status__c,Email,FirstName,High_School_Graduation_Year__c,LastName,Lead_Date__c,Lead_Source__c,Lead_Source_Code__c,MailingPostalCode,Program__c,Program_Code__c,Affiliation_Code__c,Exclude_TOG__c from contact where phone!=NULL and Program_Code__c in ('ASMP') and OwnerId='0051a000002tHWnAAM' and DoNotCall=false limit 2];
        
        Map<Id,Contact> n = new Map<Id,Contact>();
        Map<Id,Contact> o = new Map<Id,Contact>();
        
        
        for(Contact c :con)
        {
            n.put(c.id, c);
            o.put(c.id, c);
        }
        
        n.get(con[0].id).OwnerId=u[9].id;
        
        Test.setMock(HttpCalloutMock.class, new Response());
        TOG t = new TOG(n,o);
        Database.ExecuteBatch(t);
    }
    
    public testmethod static void test3()
    {
        Test.setMock(HttpCalloutMock.class, new Response());
        List<Contact> con =  [select Id,DoNotCall,OwnerId,Phone,School_Status__c,Email,FirstName,High_School_Graduation_Year__c,LastName,Lead_Date__c,Lead_Source__c,Lead_Source_Code__c,MailingPostalCode,Program__c,Program_Code__c,Affiliation_Code__c,Exclude_TOG__c from contact where phone!=NULL and Program_Code__c in ('ASMP-O') and OwnerId='0051a000002tHWnAAM' and DoNotCall=false limit 2];
        TOG tr = new TOG();
        tr.remove('130872',con);
        //online - 130892, oncampus - 130872
    }
    
    public testmethod static void test4()
    {
        Test.setMock(HttpCalloutMock.class, new Response());
        List<Contact> con =  [select Id,DoNotCall,OwnerId,Phone,School_Status__c,Email,FirstName,High_School_Graduation_Year__c,LastName,Lead_Date__c,Lead_Source__c,Lead_Source_Code__c,MailingPostalCode,Program__c,Program_Code__c,Affiliation_Code__c,Exclude_TOG__c from contact where phone!=NULL and Program_Code__c in ('ASMP') and OwnerId='0051a000002tHWnAAM' and DoNotCall=false limit 2];
        TOG ta = new TOG();
        ta.add('130892',con);
        
        ta.sendEmail('test');
        
        //online - 130892, oncampus - 130872
    }
    
    public testmethod static void test5()
    {
        String soql ='select Id,DoNotCall, Phone,School_Status__c,Email,FirstName,High_School_Graduation_Year__c,LastName,Lead_Date__c,Lead_Source__c,Lead_Source_Code__c,MailingPostalCode,Program__c,Program_Code__c, Affiliation_Code__c, exclude_tog__c from contact where Days_in_Attempted__c=7 and OwnerId!=\'0051a000002tHWnAAM\' and (not Program_Code__c like \'%-O\') and (not Affiliation_Code__c like \'INTL%\') and school_status__c like \'%Attempt%\' and phone!=NULL and exclude_tog__c=false limit 5';
        TOG t = new TOG(soql);
        Database.ExecuteBatch(t);
    }
    
    public testmethod static void test6()
    {
        Test.setMock(HttpCalloutMock.class, new Response());
        String soql ='select Id,DoNotCall, Phone,School_Status__c,Email,FirstName,High_School_Graduation_Year__c,LastName,Lead_Date__c,Lead_Source__c,Lead_Source_Code__c,MailingPostalCode,Program__c,Program_Code__c, Affiliation_Code__c, exclude_tog__c from contact where OwnerId=\'0051a000002tHWnAAM\' and Program_Code__c like \'%-O\' and phone!=NULL and exclude_tog__c=false and Lead_Source_Code__c=\'FULLSAILLEAD\' limit 5';
        TOG t = new TOG(soql);
        Database.ExecuteBatch(t);
    }
}