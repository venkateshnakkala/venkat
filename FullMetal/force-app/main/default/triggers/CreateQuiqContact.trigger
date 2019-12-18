trigger CreateQuiqContact on Case (after update) {
    for (case c : Trigger.new){
        if (c.ContactId == null) {
            if (c.Chat_Email__c != null){
                //create the contact
                Contact con = new Contact();
                con.Email = c.Chat_Email__c; //assumes these custom fields defined on the case
                con.FirstName = c.Chat_First_Name__c;
                con.LastName = c.Chat_Last_Name__c;
                con.Phone = c.Chat_Phone__c;
                try {
                    Insert con;
                } catch (system.Dmlexception e) {
                    system.debug (e);
                }  
                // set the case contact as the new one 
                Case c2 = [Select Id from Case where Id = :c.Id];
                c2.ContactId = con.Id;
                update c2;
            }
        }
    }
}