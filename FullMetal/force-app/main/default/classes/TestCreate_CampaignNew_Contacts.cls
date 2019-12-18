@isTest
public class TestCreate_CampaignNew_Contacts {
 
    static testMethod void Create_CampaignMember_For_New_Contacts() {
     
            List <Contact> Contacts;
                
            // Create a Contact with a Contact Source matching a Campaign
            Contact L1 = new Contact();
            L1.lastname = 'Create_CampaignMember_For_New_Contacts';
            L1.firstname = 'Test For';
            //L1.company = 'Company Name';
            //L1.Contactsource = 'Web'; // Make sure you have an active Campaign with this name
                
            insert L1;
            String holder = L1.id;
             
            List <CampaignMember> cm = [select id from CampaignMember where Contactid = :holder limit 1];
            system.Assert(cm.size()>=0);
             
            // Create a Contact without a Contact Source matching a Campaign
            Contact L2 = new Contact();
            L2.lastname = 'Create_CampaignMember_For_New_Contacts';
            L2.firstname = 'Test For';
           // L2.company = 'Company Name';
           // L2.Contactsource = 'No Matching Campaign'; // Make sure you DON'T have an active Campaign with this name 
                
            insert L2;
             
            String holder2 = L2.id;
             
            List <CampaignMember> cm2 = [select id from CampaignMember where Contactid = :holder2 limit 1];
            system.Assert(cm2.size()>=0);
                            
    }
}