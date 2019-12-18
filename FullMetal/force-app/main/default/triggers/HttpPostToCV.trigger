trigger HttpPostToCV on Contact (after insert) {
/*
    List<Contact> cont = [select Id, lead_source_code__c, FirstName, LastName, MailingStreet, MailingCity, 
    MailingState, MailingCountry, MailingPostalCode, Email, Phone, 
     OtherPhone, Program_Code__c, Previous_Education_Codes__c, Affiliation_Code__c from Contact WHERE Id IN: Trigger.newMap.keySet() ];
    
    for (Contact c: cont){
    
         if(c.FirstName == null){
            c.FirstName = '';
        }
        if(c.MailingState== null || c.MailingState.length() > 2 ){
            c.MailingState = '';
        }
        if(c.MailingCountry == null){
            c.MailingCountry = '';
        }
        if(c.OtherPhone == null){
            c.OtherPhone = '';
        }
        if(c.Previous_Education_Codes__c == null){
            c.Previous_Education_Codes__c = '';
        }
        if(c.Affiliation_Code__c == null){
            c.Affiliation_Code__c = '';
        }
        if(c.MailingCity == null){
            c.MailingCity = '';
        }
        if(c.MailingPostalCode== null){
            c.MailingPostalCode= '';
        }
        if(c.MailingStreet== null){
            c.MailingStreet= '';
        }
        if(c.OtherPhone== null || c.OtherPhone == ''){
            c.OtherPhone= '555-555-5555';
        }
        if(c.Phone== null || c.Phone == ''){
            c.Phone= '555-555-5555';
        }
        
        String LeadSource = c.lead_source_code__c;
        String FirstName = c.FirstName;
        String LastName = c.LastName;
        String MailingStreet = c.MailingStreet; 
        String MailingCity = c.MailingCity;
        String MailingState =  c.MailingState;
        String MailingPostalCode = c.MailingPostalCode;
        String MailingCountry = c.MailingCountry;
        String Email = c.Email;
        String Phone = c.Phone;
        String OtherPhone = c.OtherPhone;
        String Program_Code = c.Program_Code__c;
        String Previous_Education = c.Previous_Education_Codes__c;
        String Affiliation_Code = c.Affiliation_Code__c;
        String SalesForceID = c.id;
        
        String url = 'http://eleads.lafilm.com:8088/Cmc.Integration.LeadImport.HttpPost/ImportLeadProcessor.aspx?Format=CollegeDirectories&leadsource='
               + LeadSource + '&Firstname=' + FirstName + '&Lastname=' + LastName + '&Address1=' + MailingStreet + '&Address2=&City='
               + MailingCity + '&State=' + MailingState + '&Postalcodeorzip=' + MailingPostalCode + '&Country='
               + MailingCountry + '&Email=' + Email + '&Phone=' + Phone + '&WorkPhone=' + OtherPhone + '&Program='
               + Program_Code + '&Campus=MAIN&PreviousEducation=' + Previous_Education + '&Agency='
               + Affiliation_Code + '&ZSalesForceID=' + SalesForceID;
        
    
        sendHttpPostToCV.sendHttpRequest(url);
        
    }
    */
}