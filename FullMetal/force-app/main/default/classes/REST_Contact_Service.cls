@RestResource(urlMapping='/contact/*')
global with sharing class REST_Contact_Service {
    @HttpGet
    global static void create(){
        createwithpost();
    }
    
    @HttpPost
    global static void createwithpost() {
        try {
            contact c = new contact();
            
            c.Lead_Source_Code__c = RestContext.request.params.get('LeadSource');
            c.FirstName = RestContext.request.params.get('FirstName');
            c.LastName = RestContext.request.params.get('LastName');
            
            if(c.FirstName!=NULL && (c.FirstName.isAllUpperCase() || c.FirstName.isAllLowerCase())){
                c.FirstName=toTitleCase(c.FirstName);
            }
            
            if(c.LastName!=NULL && (c.LastName.isAllUpperCase() || c.LastName.isAllLowerCase())){
                c.LastName=toTitleCase(c.LastName);
            }
            
            if(!String.isBlank(RestContext.request.params.get('Address1')) && RestContext.request.params.get('Address1')!='null'){
                c.MailingStreet = RestContext.request.params.get('Address1');
            }
            
            if(!String.isBlank(RestContext.request.params.get('Address2')) && RestContext.request.params.get('Address2')!='null'){
                if(!String.isBlank(c.MailingStreet)){
                    c.MailingStreet = c.MailingStreet+' '+RestContext.request.params.get('Address2');
                }
                else{
                    c.MailingStreet = RestContext.request.params.get('Address2');
                }
            }
            c.MailingCity = RestContext.request.params.get('City');
            c.MailingState = RestContext.request.params.get('State');
            c.MailingCountry = RestContext.request.params.get('Country');
            c.MailingPostalCode = RestContext.request.params.get('Postalcodeorzip');
            c.Email = RestContext.request.params.get('Email'); 
            c.Phone = RestContext.request.params.get('Phone');
            c.Work_Phone__c = RestContext.request.params.get('WorkPhone');
            c.Program_Code__c = RestContext.request.params.get('Program');
            c.Previous_Education_Codes__c = RestContext.request.params.get('PreviousEducation');
            c.Affiliation_Code__c = RestContext.request.params.get('Agency');
            
            if(RestContext.request.params.containsKey('GradYear') && !String.isBlank(RestContext.request.params.get('GradYear'))){
                c.High_School_Graduation_Year__c = Decimal.valueOf(RestContext.request.params.get('GradYear'));
            }
            
            if(RestContext.request.params.containsKey('AdmRep') && !String.isBlank(RestContext.request.params.get('AdmRep'))){
                Id rep = RestContext.request.params.get('AdmRep');
                c.ownerid=rep;
            }
            
            if(RestContext.request.params.containsKey('lid') && !String.isBlank(RestContext.request.params.get('lid'))){
                String lid = RestContext.request.params.get('lid');
                c.Lead_ID__c=lid;
            }
            
            if(RestContext.request.params.containsKey('SepDate') && !String.isBlank(RestContext.request.params.get('SepDate'))){
                c.ETS_EAS__c = Date.parse(RestContext.request.params.get('SepDate'));
            }
            
            if(RestContext.request.params.containsKey('AccessTour') && !String.isBlank(RestContext.request.params.get('AccessTour'))){
                c.All_Access_Tour_Date__c = DateTime.parse(RestContext.request.params.get('AccessTour'));
            }
            
            if(RestContext.request.params.containsKey('EventType') && !String.isBlank(RestContext.request.params.get('EventType'))){
                String EventType= RestContext.request.params.get('EventType');
                c.RSVP_Event_Type__c=EventType;
            }
            if(RestContext.request.params.containsKey('PreferredContactMethod') && !String.isBlank(RestContext.request.params.get('PreferredContactMethod'))){
                String pcm= RestContext.request.params.get('PreferredContactMethod');
                c.Preferred_Contact_Method__c=pcm;
            }
            
            if(RestContext.request.params.containsKey('EveningSessions') && !String.isBlank(RestContext.request.params.get('EveningSessions'))){
                c.Evening_Sessions_Date__c = DateTime.parse(RestContext.request.params.get('EveningSessions'));
            }
            
            insert c;
            RestContext.response.addHeader('Content-Type', 'text/plain');
            RestContext.response.responseBody = Blob.valueOf('Lead Successful');
        }
        catch(Exception e){
            RestContext.response.addHeader('Content-Type', 'text/plain');
            RestContext.response.responseBody = Blob.valueOf(e.getMessage()+' '+e.getLineNumber());
        }
    }
    
    private static string toTitleCase(String name){
        String rtn=NULL;
        List<String> names = new List<String>();
        
        if(name!=NULL){
            names=name.toLowerCase().split(' ');
        }
        
        for(String n :names)
        {
            if(rtn==NULL){
                rtn=n.capitalize();
            }
            else {
                rtn+=' '+n.capitalize();
            }
            
        }
        
        return rtn;
    }
}