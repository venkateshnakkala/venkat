public class FindDuplicatesCtrl
{
    public contact findDupContact(String email, string firstname, string lastname, string phone)
    {
        String name;

        Map<String,String> dupEmail = new Map<String,String>();
        Map<Integer,Id> dupNPE = new Map<Integer,Id>();
        Map<Integer,Id> dupNP = new Map<Integer,Id>();
        Map<Integer,Id> dupNE = new Map<Integer,Id>();

        if(firstname==NULL){
            name=lastname;
        }
        else{
            name=firstname+' '+lastname;
        }
        
        String soql;
        
        List<AggregateResult> dupList = [select Email, Other_Email__c, Phone, Name, min(id) min from contact where email=:email or other_email__c=:email or name=:name or phone=:phone group by email, other_email__c, phone, name order by email limit 200];
        
        String ee;
        String NPE;
        String NP;
        String NE;
        
        for(AggregateResult r :dupList)
        {
            
            if(r.get('Email')!=NULL){
                ee = (string)r.get('Email');
                dupEmail.put(ee.toLowerCase(),ee);
            }
            
            if(r.get('Other_Email__c')!=NULL){
                    ee = (string)r.get('Other_Email__c');
                    dupEmail.put(ee.toLowerCase(),ee);
            }
            
            if(r.get('Email')!=NULL && r.get('Phone')!=NULL){
                NPE = (string)r.get('Name')+'~'+lastTen((string)r.get('Phone'))+'~'+(string)r.get('Email');
                dupNPE.put(hash(NPE.toLowerCase()),(Id)r.get('min'));
                
                NE = (string)r.get('Name')+'~'+(string)r.get('Email');
                dupNE.put(hash(NE.toLowerCase()),(Id)r.get('min'));
            }
            
            if(r.get('Other_Email__c')!=NULL && r.get('Other_Email__c')!='' && r.get('Phone')!=NULL){
                NPE = (string)r.get('Name')+'~'+lastTen((string)r.get('Phone'))+'~'+(string)r.get('Other_Email__c');
                dupNPE.put(hash(NPE.toLowerCase()),(Id)r.get('min'));
                
                NE = (string)r.get('Name')+'~'+(string)r.get('Other_Email__c');
                dupNE.put(hash(NE.toLowerCase()),(Id)r.get('min'));
            }
            
            if(r.get('Phone')!=NULL){
                NP=(string)r.get('Name')+'~'+lastTen((string)r.get('Phone'));
                dupNP.put(hash(NP.toLowerCase()),(Id)r.get('min'));
            }
        }
        
        Contact c;
        if(dupNPE.containsKey(hash(name+'~'+lastTen(phone)+'~'+email))){
            String tt=name+'~'+lastTen(phone)+'~'+email;
            c = new Contact(Id=dupNPE.get(hash(tt.toLowerCase())));
        }
        else if(dupNE.containsKey(hash(name+'~'+email))){
            String tt=name+'~'+email;
            c = new Contact(Id=dupNE.get(hash(tt.toLowerCase())));
        }
        else if(dupNP.containsKey(hash(name+'~'+lastTen(phone)))){
            String tt=name+'~'+lastTen(phone);
            c = new Contact(Id=dupNP.get(hash(tt.toLowerCase())));
        }
        else {
            c = new Contact();
        }
        return c;
    }
    
    public Application__c findDupsApplication(Id contactId, String programCode){
        Application__c a;
        List<Application__c> app =[select id from Application__c where student__r.id=:contactId and program_code__c=:programCode and Application_Finalized__c=false order by createddate];
        if(app.size()>0){
            a = app[0];
        }
        else {
            a = new Application__c();
        }
        return a;
    }
    
    private string lastTen(String phone){
        if(phone==NULL){
            return phone;
        }
        String rowNumber = phone.replaceAll('[^0-9]+', '');
        integer len=rowNumber.length();
        
        string rtn='';
        if(len>=10){
            rtn=rowNumber.substring(len-10,len);
        }
        else{
            rtn=rowNumber;
        }
        return rtn;
    }
    
    public integer hash(String text){
        text=text.tolowerCase();
        return text.hashcode();
    }
    

}