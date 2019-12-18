public class CustomMetaDataController {
    public Map<string, string>  newAppCountry{get;set;}
    public String selectedValue{get;set;}
    public  Contact con{get;set;}
    public Contact conRecord{get;set;}
    public CustomMetaDataController(){
        countriesDropDown();  
        
    }
    public Map<string, string> countriesDropDown(){
        
        
        try{
            newAppCountry=new Map<string, string>();
            for(NewApplicationCountries__mdt Newmdt:[select MasterLabel,DeveloperName,Value__c from NewApplicationCountries__mdt]){
                newAppCountry.put(Newmdt.MasterLabel,Newmdt.Value__c);
                system.debug('map values'+newAppCountry.get(Newmdt.MasterLabel));
            } 
            return newAppCountry; 
        }
        catch(DMLException e){
             ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error,'Something went wrong, please try again.' ) );
        }
       
        return null;
    }
    public contact conmethod(){
        this.con=[select id,name,Country__c from contact where name='test' limit 1];
        system.debug('contact detail in conmethod'+ this.con);
        return this.con;
    }
    public void saveCon(){
         Contact c=conmethod();
        conRecord=new Contact();
        system.debug('contact details'+c);
        if(c!=null){
            system.debug('new contact details'+c.id);
            conrecord.Id=c.Id; 
            system.debug('new contact1 details'+conrecord.Id);
             system.debug('selected value'+selectedValue);
             this.con.Country__c=selectedValue;
            
            
        }
       system.debug('country'+ this.con.Country__c);
        upsert con;
        system.debug('saved country'+con);
    }
}