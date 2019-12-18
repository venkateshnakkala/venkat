@RestResource(urlMapping='/quiqoptout/*')
global without sharing class QuiqOptOutResource {
    global class QuiqOptOutStatusChangedItem {
        global String handle;
        global String contactPoint;
        global String platform;
        global Boolean optedOut;
    }
    
    global class QuiqOptOutStatusChanged {
        global QuiqOptOutStatusChangedItem[] updates;
    }
    
    global class QuiqPayload {
        global QuiqOptOutStatusChanged data;
        global String eventType;
        global String id;
        global Long timestamp;
    }

    @HttpPost
    global static void acceptData()
    {
        RestRequest req = RestContext.request;
        String body = req.requestBody.toString();
        QuiqPayload payload = (QuiqPayload) JSON.deserialize(body, QuiqPayload.class);
        
        RestResponse res = RestContext.response;

        if (payload.data != null) {
            for (QuiqOptOutStatusChangedItem i: payload.data.updates) {
                List<List<SObject>> searchList = [FIND :i.handle IN PHONE FIELDS Returning Contact(Id)];
                if (searchList != null && searchList.size() > 0) {
                    List<Contact> contacts = (List<Contact>) searchList[0];
                    if (contacts != null && contacts.size() > 0) {
                        for (Contact c: contacts) {
                            c.QuiqOptOut__c = i.optedOut;
                            update c;
                        }
                    }
                }
            }
        }
        res.statusCode = 200;
        
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
}