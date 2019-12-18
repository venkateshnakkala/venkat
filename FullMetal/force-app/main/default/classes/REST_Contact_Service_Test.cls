@isTest
public class REST_Contact_Service_Test {
    
    @isTest
    public static void test() {
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/contact/createwithpost';  
        req.httpMethod = 'GET';
        req.params.put('FirstName','ASDFRGHYTHJ');
        req.params.put('LastName','DGFGJKHLK');
        req.params.put('Email','asdf@gmail.com');
        req.params.put('Address1','fdsfdsfds');
        req.params.put('Address2','fdsfdsfds');
        req.params.put('SepDate','01/01/2001');
        req.params.put('AccessTour','01/01/2001');
        req.params.put('EventType','Daily Tour');
        req.params.put('PreferredContactMethod','Any');
        req.params.put('lid','test');
        req.params.put('GradYear','2010');
        User u =[select id from user limit 1];
        req.params.put('AdmRep',u.id);
        req.params.put('PreferredContactMethod','email');
        req.params.put('EveningSessions','01/01/2001');
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.setMock(HttpCalloutMock.class, new REST_Contact_Service_HttpCalloutMock());
        
        REST_Contact_Service.create();
        REST_Contact_Service.create();

    }
    
}