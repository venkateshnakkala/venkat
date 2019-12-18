trigger AddToCampaign on Contact (after insert) {

if(!Test.isRunningTest()){

    List<CampaignMember> members = new List<CampaignMember>();

    for(Contact newLead :Trigger.new)
    {
        Id CampainId='7011a0000001dQC';
        Id ContactId = newLead.Id;
        
        /*
        if(newLead.Lead_Source_Code__c=='FSLXLIVE' || newLead.Lead_Source_Code__c=='FULLSAILLEAD' || newLead.Lead_Source_Code__c=='FULLSAIL' || newLead.Phone=='')
        {
            CampaignMember newMember = new CampaignMember();
            
            newMember.CampaignId=CampainId;
            newMember.ContactId=ContactId;
            newMember.Status='Sent';
            
            insert newMember;
        }
        else
        {
            String URL='https://api.five9.com/web2campaign/AddToList?F9domain=The%20Los%20Angeles%20Film%20School';
            URL+='&F9list=Salesforce%20Contacts&F9CallASAP=1&F9retResults=1';
            URL+='&F9key=salesforce_id&salesforce_id='+newLead.Id;
            URL+='&number1='+newLead.Phone;
            URL+='&first_name='+newLead.firstname;
            URL+='&last_name='+newLead.lastname;
            URL+='&street='+newLead.mailingstreet;
            URL+='&city='+newLead.mailingcity;
            URL+='&state='+newLead.mailingstate;
            URL+='&zip='+newLead.mailingpostalcode;
            sendHttpPostToCV.sendHttpRequest(URL);
            
            CampaignMember newMember = new CampaignMember();
            
            newMember.CampaignId=CampainId;
            newMember.ContactId=ContactId;
            newMember.Status='Sent';
            
            insert newMember;
        }
        */
        
        CampaignMember newMember = new CampaignMember();
            
        newMember.CampaignId=CampainId;
        newMember.ContactId=ContactId;
        newMember.Status='Sent';
            
        members.add(newMember);
    }
    insert members;
 }
 }