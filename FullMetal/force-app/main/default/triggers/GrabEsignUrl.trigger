trigger GrabEsignUrl on Application__c (after Update) {
    for(Application__c App:Trigger.New){
        // AgreementCountTrigger will Populate Total_Agreements__c when any document is Sent ,Update Or Deleted

        Integer newval=Integer.valueOf(App.Total_Agreements__c);
        Application__c oldApp = Trigger.oldMap.get(App.ID);
        Integer oldval=Integer.valueOf(oldApp.Total_Agreements__c);
        if(newval!=oldval && newval > oldval){
            adobesignIntegration.Esignurl(App.id);
        }
    }
        

}