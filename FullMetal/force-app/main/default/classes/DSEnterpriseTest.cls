@istest
public class DSEnterpriseTest {
    
    static testMethod void test_DSUpdateAccount_Opp_Contact()
    {
        //Boolean Variables
        Boolean IsContact = false;
        Boolean IsAccount = false;
        Boolean IsOpp = false;
        Boolean IsLead = false;
        
        //String to contain Account's & Opp's Id
        String AID = null;
        String OID = null;
        String CID = null;
        String LID = null;
        
        //Search the database for the active user and grab the first user id
        List<User> activeUserList = new List<User>([SELECT Id FROM User WHERE IsActive = true]);
        List<Id> activeUserIdList = new List<Id>();
        for(User u : activeUserList)
        {
            activeUserIdList.add(u.Id);
        }
        Id UID = activeUserIdList[0];
        system.debug('Id of the user\n' + UID);
        
        //Attempt to create lead
        if(!IsLead)
        {
            Lead l = new Lead(City = 'Sacramneto', AnnualRevenue = 10000.00,
                            Company = 'Sample Company', Description = 'This is a dummy lead',
                            Email = 'sample@testing.com', LeadSource = 'Web2Lead', Status ='Open', MobilePhone = '9251231234',
                            FirstName = 'Sample', LastName ='Lead', Phone = '9161231234', Rating = 'Warm', Title ='CEO',
                             Website = 'https://dialsource.com/', NumberOfEmployees = 10);
            
            //Change OwnerId to current if no Id was previously found               
            if(UID != null || UID != '') l.OwnerId = UID;
            else l.OwnerId = UserInfo.getUserId();
            
            //Insert Lead
            try
            {
                Database.SaveResult[] iresult = Database.Insert(new Lead[]{l});
                if(iresult[0].isSuccess())
                {
                    IsLead = true;
                    LID = l.Id;
                }
            }
            catch(exception e)
            {system.debug('System could not insert lead***');}
        }
        
        //Attempt to find lead id if lead insertion failed
        if(!IsLead)
        {
            try
            {
                //Search the database for the lead's Id and log it on the debug log
                LID =[SELECT Id FROM Lead WHERE OwnerId IN : activeUserIdList LIMIT 1].Id;
                system.debug('Id of the lead\n' + [SELECT Id FROM Lead WHERE OwnerId IN : activeUserIdList LIMIT 1]);
                
                //If LID is not null or empty then set to true
                if(LID != null || LID != '') IsLead = true;
            }
            catch(exception e)
            {
                system.debug('\n***Lead could not be found or inserted***\n');
            }
        }
        
        
        
        //Attempt to create Account
        if(!IsAccount)
        {
            Account a = new Account(Name = 'Sample Account', BillingCity = 'Sacramneto', AnnualRevenue = 10000.00,
                            BillingCountry = 'USA', BillingPostalCode = '95815', Description = 'This is a dummy lead',
                            BillingState ='CA', BillingStreet = '1481 Sample Rd', Industry = 'Life Sciences',
                            Ownership ='Private', ShippingCity ='Sacramneto',
                            ShippingCountry = 'USA', ShippingPostalCode ='95815', ShippingState = 'CA', ShippingStreet= '1481 Sample Rd',
                            Site= 'Branch', Phone = '9161231234', Rating = 'Warm', TickerSymbol= 'DSI', Type ='Customer',
                            Website = 'https://dialsource.com/', NumberOfEmployees = 10);
            
            //Change OwnerId to current if no Id was previously found               
            if(UID != null || UID != '') a.OwnerId = UID;
            else a.OwnerId = UserInfo.getUserId();
            
            try
            {
                //Insert Account
                Database.SaveResult[] iresult = Database.Insert(new Account[]{a});
                if(iresult[0].isSuccess())
                {
                    IsAccount = true;
                    AID = a.Id;
                }
            }
            catch(exception e)
            {system.debug('System could not insert Account***');}
        }
        
        //Attempt to find Account id if Account insertion failed
        if(!IsAccount)
        {
            try
            {
                //Search the database for the Account's Id and log it on the debug log
                AID =[SELECT Id FROM Account WHERE OwnerId IN : activeUserIdList LIMIT 1].Id;
                system.debug('Id of the Account\n' + [SELECT Id FROM Account WHERE OwnerId IN : activeUserIdList LIMIT 1]);
                
                //If AID is not null or empty then set to true
                if(AID != null || AID != '') IsAccount = true;
            }
            catch(exception e)
            {
                system.debug('\n***Account could not be found or inserted***\n');
            }
        }
        
        
        
        //Attempt to create Opportunity
        if(!IsOpp)
        {
            Opportunity o = new Opportunity(Amount = 100, CloseDate = system.today(), Description = 'This is a dummy Opp',
                            LeadSource = 'Web2Lead', Name = 'Sample Opp', NextStep = 'Discuss with your boss',
                            Probability = 25, StageName ='Closed Won', Type ='New Customer');
            
            //Change OwnerId to current if no Id was previously found               
            if(UID != null || UID != '') o.OwnerId = UID;
            else o.OwnerId = UserInfo.getUserId();
            
            //Update accountid if account was previously found              
            if(AID != null || AID != '') o.AccountId = AID;
            
            try
            {
                //Insert Opportunity
                Database.SaveResult[] iresult = Database.Insert(new Opportunity[]{o});
                if(iresult[0].isSuccess())
                {
                    IsOpp = true;
                    OID = o.Id;
                }
            }
            catch(exception e)
            {system.debug('System could not insert Opportunity***');}
        }
        
        //Attempt to find Opportunity id if Opportunity insertion failed
        if(!IsOpp)
        {
            try
            {
                //Search the database for the Opportunity's Id and log it on the debug log
                OID =[SELECT Id FROM Opportunity WHERE OwnerId IN : activeUserIdList LIMIT 1].Id;
                system.debug('Id of the Opportunity\n' + [SELECT Id FROM Opportunity WHERE OwnerId IN : activeUserIdList LIMIT 1]);
                
                //If OID is not null or empty then set to true
                if(OID != null || OID != '') IsOpp = true;
            }
            catch(exception e)
            {
                system.debug('\n***Opportunity could not be found or inserted***\n');
            }
        }
        
        
        
        //Attempt to create Contact
        if(!IsContact)
        {
            Contact C = new Contact( AssistantName = 'Dani', AssistantPhone = '9251231234', Birthdate = system.today(),
                            Department = 'Engineering', Description = 'This is a dummy lead', Email ='sample@testing.com',
                            FirstName = 'Sample', LastName = 'Contact', HomePhone = '9161234125', LeadSource = 'Web2Lead',
                            MailingCity ='Sacramneto', MailingState ='CA', MailingCountry = 'USA', MailingPostalCode ='95815',
                            MailingStreet = '1481 Sample Rd', MobilePhone ='6191234561',
                            OtherCity ='Sacramneto', OtherState ='CA', OtherCountry = 'USA', OtherPostalCode ='95815',
                            OtherStreet = '1481 Sample Rd', OtherPhone ='7851231234', Phone = '8526324512', 
                            Title = 'CEO');
            
            //Change OwnerId to current if no Id was previously found               
            if(UID != null || UID != '') c.OwnerId = UID;
            else c.OwnerId = UserInfo.getUserId();
            
            //Update accountid if account was previously found              
            if(AID != null || AID != '') c.AccountId = AID;
            
            try
            {
                //Insert Contact
                Database.SaveResult[] iresult = Database.Insert(new Contact[]{c});
                if(iresult[0].isSuccess())
                {
                    IsContact = true;
                    CID = c.Id;
                }
            }
            catch(exception e)
            {system.debug('System could not insert lead***');}
        }
        
        //Attempt to find Contact id if Contact insertion failed
        if(!IsContact)
        {
            try
            {
                //Search the database for the Contact's Id and log it on the debug log
                CID =[SELECT Id FROM Contact WHERE OwnerId IN : activeUserIdList LIMIT 1].Id;
                system.debug('Id of the Contact\n' + [SELECT Id FROM Contact WHERE OwnerId IN : activeUserIdList LIMIT 1]);
                
                //If CID is not null or empty then set to true
                if(CID != null || CID != '') IsContact = true;
            }
            catch(exception e)
            {
                system.debug('\n***Contact could not be found or inserted***\n');
            }
        }
        
        
        
        //Print out the boolean variables
        system.debug('Boolean of the Opportunity\n' + IsOpp);
        system.debug('Boolean of the Account\n' + IsAccount);
        system.debug('Boolean of the Contact\n' + IsContact);
        system.debug('Boolean of the lead\n' + IsLead);
        
        test.startTest();
        //Lead Test
        if(IsLead)
        {
            Task t1 = new Task(
            OwnerId = UID,
            WhoId = LID,
            Status = 'Completed',
            CallDurationInSeconds = 0,
            Subject = 'Refractive Dialer Automated Call',
            dialforce__RD_Disposition__c = 'Follow Up',
            dialforce__RD_CallListName__c = 'Test List',
            Description = 'Task Assigned: Interested Description: Please look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recording Dialed:');
            
            Task t2 = new Task(
            OwnerId = UID,
            WhoId = LID,
            Status = 'Completed',
            CallDurationInSeconds = 0,
            Subject='Refractive Dialer Automated Call',
            dialforce__RD_Disposition__c='Recycle',
            dialforce__RD_CallListName__c = 'Test List 2!',
            Description='Description: Please look at recording  Please look at recording Please look at recording Please look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recording');
        
            //test.startTest();
            insert t1;
            insert t2;
            
            //Create map with id of lead and disposition name
            Map<Id, String> leadMap = new Map<Id, String>();
            Map<Id, String> leadCLMap = new Map<Id, String>();
            leadMap.put(LID, 'Follow Up');
            leadMap.put(LID, 'Recycle');
            leadCLMap.put(LID, 'Test List');
            leadCLMap.put(LID, 'Test List 2!');
            
            DSsObjectActions.DSUpdateLead(leadMap, leadCLMap);
            DSsObjectActions.DSUpdateLeadNotFuture(leadMap, leadCLMap);
            DSsObjectActions.DSUpdateLeadNotFuture(leadMap, leadCLMap);
            //test.stopTest();
        }
        //Account test
        if(IsAccount)
        {
            Task t1 = new Task(
            OwnerId = UID,
            WhatId = AID,
            Status = 'Completed',
            Subject = 'Refractive Dialer Automated Call',
            CallDurationInSeconds = 0,
            dialforce__RD_Disposition__c = 'Left Voicemail',
            dialforce__RD_CallListName__c = 'Test List',
            Description = 'Task Assigned: Interested Description: Please look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recording Dialed:');
            
            //test.startTest();
            insert t1;
            
            //Create map with id of account and disposition name
            Map<Id, String> accountMap = new Map<Id, String>();
            Map<Id, String> accountCLMap = new Map<Id, String>();
            accountMap.put(AID, 'Left Voicemail');
            accountCLMap.put(AID, 'Test List');
            
            DSsObjectActions.DSUpdateAccount(accountMap, accountCLMap);
            DSsObjectActions.DSUpdateAccountNotFuture(accountMap, accountCLMap);
            DSsObjectActions.DSUpdateAccountNotFuture(accountMap, accountCLMap);
            //test.stopTest();
        }
        //Opp test
        if(IsOpp)
        {
            Task t1 = new Task(
            OwnerId = UID,
            WhatId = OID,
            Status = 'Completed',
            Subject = 'Refractive Dialer Automated Call',
            CallDurationInSeconds = 0,
            dialforce__RD_Disposition__c = 'Left Voicemail',
            Description = 'Task Assigned: Interested Description: Please look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recording Dialed:');
            
            //test.startTest();
            insert t1;
            
            //Create map with id of opp and disposition name
            Map<Id, String> oppMap = new Map<Id, String>();
            Map<Id, String> oppCLMap = new Map<Id, String>();
            oppMap.put(OID, 'Left Voicemail');
            oppCLMap.put(OID, 'Test List');
            
            DSsObjectActions.DSUpdateOpportunity(oppMap, oppCLMap);
            DSsObjectActions.DSUpdateOpportunityNotFuture(oppMap, oppCLMap);
            DSsObjectActions.DSUpdateOpportunityNotFuture(oppMap, oppCLMap);
            //test.stopTest();
        }
        //test contact
        if(IsContact)
        {
            Task t1 = new Task(
            OwnerId = UID,
            WhoId = CID,
            Status = 'Completed',
            CallDurationInSeconds = 0,
            Subject = 'Refractive Dialer Automated Call',
            dialforce__RD_Disposition__c = 'Left Voicemail',
            Description = 'Recording: https://global.refractivedialer.com/GetRecording.php?remote_id=1439402344.7438 Task Assigned: Interested Description: Please look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recordingPlease look at recording Dialed:');
            
            //test.startTest();
            insert t1;
            
            //Create map with id of Contact and disposition name
            Map<Id, String> contactMap = new Map<Id, String>();
            Map<Id, String> contactCLMap = new Map<Id, String>();
            contactMap.put(CID, 'Left Voicemail');
            contactCLMap.put(CID, 'Test List');
            
            DSsObjectActions.DSUpdateContact(contactMap, contactCLMap);
            DSsObjectActions.DSUpdateContactNotFuture(contactMap, contactCLMap);
            DSsObjectActions.DSUpdateContactNotFuture(contactMap, contactCLMap);
            //test.stopTest();
        }
        test.stopTest();
    }
}