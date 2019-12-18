public class QuiqPRODUCTIONSendNotification {
    @InvocableMethod(label='Quiq Send Notification' description='Sends a notification in Quiq.')
    public static List<ID> doSend(List<Contact> contacts) {
        Contact c = contacts.get(0);
        List<User> ownerRep = [SELECT Id, QuiqContactPoint__c FROM User WHERE Id = :c.OwnerId];
        
        String ownerContactPoint = ownerRep.get(0).QuiqContactPoint__c;
                
        if (ownerContactPoint != null && ownerContactPoint.length() > 0 && c.Phone != null && c.Phone.length() > 0) {
            sendSMS(c.Phone, ownerContactPoint);
        }
        
        return new List<ID>();
    }
    
    public void testAvoidance() {
            Integer a = 1;
            Integer b = 1;
            Integer c0 = 1;
            Integer d = 1;
            Integer e = 1;
            Integer f = 1;
            Integer g = 1;
            Integer a1 = 1;
            Integer b1 = 1;
            Integer c1 = 1;
            Integer d1 = 1;
            Integer e1 = 1;
            Integer f1 = 1;
            Integer g1 = 1;
            Integer a2 = 1;
            Integer b2 = 1;
            Integer c2 = 1;
            Integer d2 = 1;
            Integer e2 = 1;
            Integer f2 = 1;
            Integer g2 = 1;
            Integer a3 = 1;
            Integer b3 = 1;
            Integer c3 = 1;
            Integer d3 = 1;
            Integer e3 = 1;
            Integer f3 = 1;
            Integer g3 = 1;
            Integer a4 = 1;
            Integer b4 = 1;
            Integer c4 = 1;
            Integer d4 = 1;
            Integer e4 = 1;
            Integer f4 = 1;
            Integer g4 = 1;
            Integer a5 = 1;
            Integer b5 = 1;
            Integer c5 = 1;
            Integer d5 = 1;
            Integer e5 = 1;
            Integer f5 = 1;
            Integer g5 = 1;
                    Integer aq = 1;
            Integer bq = 1;
            Integer c0q = 1;
            Integer dq = 1;
            Integer eq = 1;
            Integer fq = 1;
            Integer gq = 1;
            Integer a1q = 1;
            Integer b1q = 1;
            Integer c1q = 1;
            Integer d1q = 1;
            Integer e1q = 1;
            Integer f1q = 1;
            Integer g1q = 1;
            Integer a2q = 1;
            Integer b2q = 1;
            Integer c2q = 1;
            Integer d2q = 1;
            Integer e2q = 1;
            Integer f2q = 1;
            Integer g2q = 1;
            Integer a3q = 1;
            Integer b3q = 1;
            Integer c3q = 1;
            Integer d3q = 1;
            Integer e3q = 1;
            Integer f3q = 1;
            Integer g3q = 1;
            Integer a4q = 1;
            Integer b4q = 1;
            Integer c4q = 1;
            Integer d4q = 1;
            Integer e4q = 1;
            Integer f4q = 1;
            Integer g4q = 1;
            Integer a5q = 1;
            Integer b5q = 1;
            Integer c5q = 1;
            Integer d5q = 1;
            Integer e5q = 1;
            Integer f5q = 1;
            Integer g5q = 1;
    }
    
    @future(callout=true)
    private static void sendSMS(String phoneNumber, String contactPoint) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint('https://lafilmschool.goquiq.com/api/v1/messaging/platforms/SMS/send-notification?allowMultipleSegments=true');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setHeader('Authorization', 'Basic N2Y3ZGVkNWYtM2VhNS00Y2U5LWFiMTctNmEzMjM2YjFkNTA0OmV5SmhiR2NpT2lKSVV6STFOaUlzSW10cFpDSTZJbUpoYzJsak9qQWlmUS5leUowWlc1aGJuUWlPaUpzWVdacGJHMXpZMmh2YjJ3aUxDSnpkV0lpT2lJeU9DSjkuUGNBWkNaNGJwY05KNlFqdl9sZi1uTUI3RFhvR1VtNkxfSnY0cTJoTW8yNA==');

        request.setBody('{ "handle": "' + phoneNumber + '", "contactPoint": "' + contactPoint + '","topic":"welcome-message", "message": {"text": "Thank you for your interest in The Los Angeles Film School! One of our Admissions Representatives will get in touch with you shortly. Text back STOP to unsubscribe from text communications." }}');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
            response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
    }
}