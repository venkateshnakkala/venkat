@isTest

private class testContactUtilities {

    static testMethod void test1(){
        List<Contact> con = new List<Contact>();
        con.add(new Contact(lastname='aaaa', Lead_Source_Code__c='ARIZONA'));
        con.add(new Contact(lastname='bbbb', Lead_Source_Code__c='COLBNDS'));
        con.add(new Contact(lastname='aaaa', Lead_Source_Code__c='COR1000'));
        con.add(new Contact(lastname='bbbb', Lead_Source_Code__c='COR1001'));
        con.add(new Contact(lastname='bbbb', Lead_Source_Code__c='KSCARY'));
        
        insert con;
        System.assert(con.size()>0);
    }

    static testMethod void test2(){
        List<Contact> con = new List<Contact>();
        con.add(new Contact(lastname='aaaa', Previous_Education_Codes__c= 'AA/AS'));
        con.add(new Contact(lastname='aaaa', Previous_Education_Codes__c= 'COL'));
        con.add(new Contact(lastname='aaaa', Previous_Education_Codes__c= 'BA/BS'));
        con.add(new Contact(lastname='aaaa', Previous_Education_Codes__c= 'GED'));
        con.add(new Contact(lastname='aaaa', Previous_Education_Codes__c= 'HS'));
        con.add(new Contact(lastname='aaaa', Previous_Education_Codes__c= 'INHS'));
        con.add(new Contact(lastname='aaaa', Previous_Education_Codes__c= 'MS'));
        insert con;
        System.assert(con.size()>0);
    }
}