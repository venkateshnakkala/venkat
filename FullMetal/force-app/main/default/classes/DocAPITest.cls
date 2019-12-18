@IsTest
public class DocAPITest{

   public class MyException extends Exception {}
   
    public class GetDocumentsResponse implements HttpCalloutMock 
    {
        public HTTPResponse respond(HTTPRequest req) 
        {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'text/xml');
            res.setHeader('SOAPAction','http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd/IDocuments/GetDocuments');
            res.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
            
            res.setBody('<?xml version="1.0" encoding="UTF-8"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Body>'+
                        '<GetDocumentsResponse xmlns="http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd">'+
                        '<GetDocumentsResult xmlns:a="http://schemas.datacontract.org/2004/07/Cmc.Integration.Wcf.Messages.Crm" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">'+
                        '<ProcessedRequest i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<Status xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">OK</Status>'+
                        '<TokenId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">test</TokenId>'+
                        '<TrxResult xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" /><a:GetDocumentsOutMsgs><a:GetDocumentsOutMsg>'+
                        '<CorrelationId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">0</CorrelationId>'+
                        '<CustomAttributes i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<DataSource i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<ExceptionDetail i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<HostName i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<InitialCatalog i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<MessageErrorCode i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<MessageResult i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<MessageStatus xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">OK</MessageStatus>'+
                        '<a:DeletedDocuments i:nil="true" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" /><a:Documents><a:DocumentFields><a:AddedByStaff>kbarnett@lafilm.com</a:AddedByStaff>'+
                        '<a:AwardYear></a:AwardYear><a:Comments /><a:DateApproved>1900-01-01T00:00:00</a:DateApproved><a:DateExpire>1900-01-01T00:00:00</a:DateExpire>'+
                        '<a:DateLastModified>2017-02-01T15:34:18.553</a:DateLastModified><a:DateReceived>1900-01-01T00:00:00</a:DateReceived><a:DateRequested>2011-07-06T00:00:00</a:DateRequested>'+
                        '<a:DateSent>1900-01-01T00:00:00</a:DateSent><a:DocumentDescrip>SA - Lock Out</a:DocumentDescrip><a:DocumentId>270997</a:DocumentId><a:DocumentStatus>SENT</a:DocumentStatus>'+
                        '<a:DocumentStatusId>11</a:DocumentStatusId><a:DocumentType>SA-PLO</a:DocumentType><a:DocumentTypeId>153</a:DocumentTypeId><a:DueDate>1900-01-01T00:00:00</a:DueDate>'+
                        '<a:EnrollmentId>97858</a:EnrollmentId><a:StudentId>1013097</a:StudentId><a:WorkflowInstanceId>00000000-0000-0000-0000-000000000000</a:WorkflowInstanceId>'+
                        '</a:DocumentFields></a:Documents></a:GetDocumentsOutMsg></a:GetDocumentsOutMsgs></GetDocumentsResult></GetDocumentsResponse></s:Body></s:Envelope>');
            res.setStatusCode(200);
            return res;
        }
    }
    
    public class UpdateDocumentResponse implements system.HttpCalloutMock
    {
        public HttpResponse respond(HttpRequest req) 
        {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'text/xml');
            res.setHeader('SOAPAction','http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd/IDocuments/UpdateDocuments');
            res.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
            
            res.setBody('<?xml version="1.0" encoding="UTF-8"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">'+
                        '<s:Body><UpdateDocumentsResponse xmlns="http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd">'+
                        '<UpdateDocumentsResult xmlns:a="http://schemas.datacontract.org/2004/07/Cmc.Integration.Wcf.Messages.Crm" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">'+
                        '<ProcessedRequest i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<Status xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">OK</Status>'+
                        '<TokenId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">test</TokenId>'+
                        '<TrxResult xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" /><a:UpdateDocumentsOutMsgs><a:UpdateDocumentsOutMsg>'+
                        '<CorrelationId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">0</CorrelationId>'+
                        '<CustomAttributes i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<DataSource i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<ExceptionDetail i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<HostName i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<InitialCatalog i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<MessageErrorCode i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<MessageResult i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<MessageStatus xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">OK</MessageStatus><a:DocumentId>494406</a:DocumentId>'+
                        '</a:UpdateDocumentsOutMsg></a:UpdateDocumentsOutMsgs></UpdateDocumentsResult></UpdateDocumentsResponse></s:Body></s:Envelope>');
            res.setStatusCode(200);
            res.setStatus('OK');
            return res;
        }
    }
    
    public class AddDocumentResponse implements system.HttpCalloutMock
    {
        public HttpResponse respond(HttpRequest req) 
        {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'text/xml');
            res.setHeader('SOAPAction','http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd/IDocuments/AddDocuments');
            res.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
            
            res.setBody('<?xml version="1.0" encoding="UTF-8"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">'+
                        '<s:Body><AddDocumentsResponse xmlns="http://www.campusmgmt.com/Soa/Foundation/MessageDefinition.xsd">'+
                        '<AddDocumentsResult xmlns:a="http://schemas.datacontract.org/2004/07/Cmc.Integration.Wcf.Messages.Crm" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">'+
                        '<ProcessedRequest i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<Status xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">OK</Status>'+
                        '<TokenId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">test</TokenId>'+
                        '<TrxResult xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" /><a:AddDocumentsOutMsgs><a:AddDocumentsOutMsg>'+
                        '<CorrelationId xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">0</CorrelationId>'+
                        '<CustomAttributes i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<DataSource i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<ExceptionDetail i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<HostName i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<InitialCatalog i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<MessageErrorCode i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<MessageResult i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" />'+
                        '<MessageStatus xmlns="http://schemas.datacontract.org/2004/07/Cmc.CampusLink.Wcf.Messages.Common">OK</MessageStatus><a:DocumentId>1722734</a:DocumentId></a:AddDocumentsOutMsg>'+
                        '</a:AddDocumentsOutMsgs></AddDocumentsResult></AddDocumentsResponse></s:Body></s:Envelope>');
            res.setStatusCode(200);
            res.setStatus('OK');
            return res;
        }
    } 
    
    static testmethod void test1()
    {
        Contact c = new Contact(FirstName='fdsjfkdsfjs', LastName='flkjdhfksdf');
        c.SyStudentId__c='1013097';
        insert c;
        
        Application__c a = new Application__c(Student__c=c.id, Program_Code__c='ASMP');
        a.AdEnrollId__c=97858;
        insert a;
        
        List<echosign_dev1__SIGN_Agreement__c> g = new List<echosign_dev1__SIGN_Agreement__c>();
        g.add(new echosign_dev1__SIGN_Agreement__c(Application__c=a.id, Name='FA - Testing Document1 [SA-PLO]', echosign_dev1__Status__c='Signed'));
        g.add(new echosign_dev1__SIGN_Agreement__c(Application__c=a.id, Name='FA - Testing Document2 [BANK]', echosign_dev1__Status__c='Out for Signature'));
        insert g;
        
        DocAPI d = new DocAPI(new List<Id>{a.id});
        Database.ExecuteBatch(d,20);
    }
}