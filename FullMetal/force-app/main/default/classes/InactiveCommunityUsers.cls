global class InactiveCommunityUsers implements Schedulable {

    global void execute(SchedulableContext ctx)
    {
        date now = date.today();
        date start = now.addDays(-60);
        String s=String.ValueOf(start)+'T00:00:00Z';
        
        String soql='Select Id, IsActive  From User WHERE Profile.Id=\'00e1a000000IzWxAAK\' AND IsActive=true AND (LastLoginDate < '+s+' OR (LastLoginDate=NULL AND CreatedDate<'+s+'))';
        
        SearchAndReplace R = new SearchAndReplace(soql,'IsActive',false);
        if(!Test.isRunningTest()){database.ExecuteBatch(R,50);}
    }  
}