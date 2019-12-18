trigger HttpPostToCVApps on Application__c (after insert) {

    List<String> SFid = new List<String>(); 
    String SFaPPStuNum;
    String Program_Code;

    for (Application__c app: Trigger.new)
    {
        SFid.add(app.Student__c);
        SFaPPStuNum = app.Application_Number__c;
        Program_Code = app.Program_Code__c;
    }

    List<Contact> cont = [select Id, lead_source_code__c, FirstName, LastName, MailingStreet, MailingCity, 
    MailingState, MailingCountry, MailingPostalCode, Email, Phone, 
     OtherPhone, Program_Code__c, Previous_Education_Codes__c, Affiliation_Code__c from Contact WHERE Id in :SFid ];
    
    for (Contact c: cont){
        
        if(Program_Code=='Unknown'){
            Program_Code='';
        }
        
        if(c.lead_source_code__c==null || c.lead_source_code__c=='null'){
            c.lead_source_code__c='OTH6008';
        }
        
        String LeadSource = Codes.checkIn(c.lead_source_code__c);
        String FirstName = Codes.checkIn(c.FirstName);
        String LastName = Codes.checkIn(c.LastName);
        String MailingStreet = Codes.checkIn(c.MailingStreet); 
        String MailingCity = Codes.checkIn(c.MailingCity);
        String MailingState =  Codes.getState(c.MailingState);
        String MailingPostalCode = Codes.checkIn(c.MailingPostalCode);
        String MailingCountry = Codes.getCountryCodes(c.MailingCountry);
        String Email = Codes.checkIn(c.Email);
        String Phone;
        if(c.Phone== null){
            Phone = '0000000000';
        }
        else {
            Phone = Codes.checkIn(c.Phone);
        }
        String OtherPhone = Codes.checkIn(c.OtherPhone);
        String Previous_Education = Codes.getPrevEduCodes(c.Previous_Education_Codes__c);
        String Affiliation_Code = Codes.getAffilicationCodes(c.Affiliation_Code__c);
        String SalesForceID = c.id;
        
        String url = 'http://eleads.lafilm.com:8088/Cmc.Integration.LeadImport.HttpPost/ImportLeadProcessor.aspx?Format=CollegeDirectories&leadsource='
               + LeadSource + '&Firstname=' + FirstName + '&Lastname=' + LastName + '&Address1=' + MailingStreet + '&Address2=&City='
               + MailingCity + '&State=' + MailingState + '&Postalcodeorzip=' + MailingPostalCode + '&Country='
               + MailingCountry + '&Email=' + Email + '&Phone=' + Phone + '&WorkPhone=' + OtherPhone + '&Program='
               + Program_Code + '&Campus=MAIN&PreviousEducation=' + Previous_Education + '&Agency='
               + Affiliation_Code + '&ZSalesForceID=' + SalesForceID + '&ZSFaPPStuNum=' + SFaPPStuNum;
        
        sendHttpPostToCV.sendHttpRequest(url);
        
    }
}