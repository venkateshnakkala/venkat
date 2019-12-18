@RestResource(urlMapping='/UpdateContactWRTDisposition/*')
global class UpdateContactWRTDispositionController {
    @HttpGet
    global static string UpdateContactGet() {
        String SFContactID = RestContext.request.params.get('SFContactId');
        String DispositionName = RestContext.request.params.get('DispositionName');
        
        system.debug(SFContactID + ' ' + DispositionName);
        
        String result = UpdateContact(SFContactID, DispositionName);
        
        return result;
    }
    
    public static string UpdateContact(String SFContactID, String DispositionName) {
        
        if (SFContactID != null && DispositionName != null) {
            List<Contact> contacts = [SELECT Id, Name, School_Status__c FROM Contact WHERE Id =: SFContactID];
            
            if (contacts.size() == 1) {
                Contact SFContact = contacts[0];
            
                List<Disposition__c> dispositions = [SELECT Id, Name, Status__c, Change_Value__c FROM Disposition__c WHERE Name =: DispositionName];
                
                if (dispositions.size() == 1) {
                    String result;
                    Disposition__c SFDisposition = dispositions[0];
                    
                    if (SFDisposition.change_value__c == true) {
                        SFContact.school_status__c = SFDisposition.Status__c;
                        
                        
                        try {
                            update SFContact;
                            
                            result = 'Update Successful';
                        } catch (Exception e) {
                            result = 'Error: ' + e.getMessage();
                        }
                    }
                    
                    return result; 
                } else {
                    return 'Disposition not found or multiple records found in the Custom Disposition Object.';
                }
            } else {
                return 'Contact Not Found.';
            }
        } else {
            return 'Salesforce Contact Id or Disposition missing.';
        }
        
    }
    
}