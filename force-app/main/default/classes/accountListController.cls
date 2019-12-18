public class accountListController{
    public class Wrapper{
        public Id Id{get;set;}
        public String Name{get;set;}
        public List<Wrapper> children{get;set;}
    }
    public List<Wrapper> accounts{
        get
        {
        
            List<Wrapper> accounts = new List<Wrapper>();
           
          
            List<Id> oppIds = new List<Id>();
         
            for(Account acc : [Select Id, Name,(Select Id, Name From Contacts)  From Account]) {
             
                Wrapper account = new Wrapper();
                Wrapper account1 = new Wrapper();
                account.Id = acc.Id;
                account.Name = acc.Name;
                account.children = new List<Wrapper>();
                accounts.add(account);
            system.debug('Account related contact details'+accounts);
                for(Contact con:acc.contacts){
                     Wrapper Contact = new Wrapper();
                         Contact.Id=con.Id;
                         Contact.Name = con.Name;
                       Contact.children = new List<Wrapper>();
                    
                        account.children.add(Contact);
                    system.debug('Account related contact details'+account.children);
              
          for(Opportunity opp : acc.Opportunities) {
                    Wrapper opportunity = new Wrapper();
                    opportunity.Id = opp.Id;
                    opportunity.Name = opp.Name;
                    opportunity.children = new List<Wrapper>();
                    account.children.add(opportunity);
                    oppIds.add(opp.Id);
                     
                }   
                }
            }
  
           Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>([Select Id, (Select Id, Contact.Name From OpportunityContactRoles) From Opportunity where id In :oppIds]);
           
        /*    for(Wrapper account : accounts) {
                for(Wrapper opportunity : account.children){

                    for(OpportunityContactRole opCR : oppMap.get(opportunity.Id).OpportunityContactRoles){
                        Wrapper contact = new Wrapper();
                        contact.Id = opCR.Id;
                        contact.Name = opCr.Contact.Name;
                        opportunity.children.add(contact);
                    }
                }
            } */
            return accounts; 
        }
    }
}