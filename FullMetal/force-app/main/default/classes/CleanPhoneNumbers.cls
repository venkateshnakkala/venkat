public class CleanPhoneNumbers implements Database.Batchable<sObject>
{
    private final String Query;
    
    public cleanPhoneNumbers()
    {
      Query='select id, phone from contact where phone!=NULL';
    }
    
    public cleanPhoneNumbers(String q)
    {
        Query=q;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Contact> con)
    {
        List<Contact> contacts = new List<Contact>();
        String newPhone;
        
        for(Contact c : con)
        {
            newPhone=numberOnly(c.phone);
            
            if(c.phone!=newPhone){
                contacts.add(new Contact(Id=c.id, phone=newPhone, Parent_Phone__c=c.phone));
            }
        }
        
        update contacts;
    }
    
    public void finish(Database.BatchableContext BC){}
    
    public string numberOnly(string phone)
    {
        if(phone==NULL){ return phone; }
        
        String newPhone = phone.replaceAll('[^0-9]', '');
        Integer len = newPhone.length();
        
        if(len==11 && newPhone.substring(0,1)=='1')
        {
            phone=newPhone.substring(1,11);
            
            phone = '(' + phone.substring(0, 3) + ') ' + phone.substring(3, 6) + '-' + phone.substring(6);
        }
        return phone;
    }
}