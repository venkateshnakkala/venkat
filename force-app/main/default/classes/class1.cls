public class class1{
public Account acc{get;set;}
public Account accData{get;set;}
public Contact contactRecord{get;set;}    
    
public class1(){
    this.accData=new Account();
 method();
}
public void method(){
 
 User recordUser=[select id,ContactId from User WHERE ID =: UserInfo.getUserId() AND IsPortalEnabled = TRUE limit 1]; 
    system.debug('getting current user' + JSON.serialize(recordUser));
    try{
 
          contactRecord=[select id from Contact where Id=:recordUser.ContactId limit 1];
          system.debug('getting current user' + JSON.serialize(contactRecord));
          Account acc=method2();
          if(acc!=null){
            this.accData=acc;
          }else{
               this.accData.User__c=this.contactRecord.Id;
          }
        
    }    
     catch( Exception e ) {
            System.debug( 'Exception:-\n' + e.getMessage() );
            ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error, 'Something went wrong, please try again.' ) );
        }
}
public void method1(){
 try {
   update this.contactRecord;
     Account acc=method2();
     if(acc!=null){
         this.accData.id=acc.id;
     }
     upsert this.accData;
    }
    catch( DMLException e){
      ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error, 'Something went wrong, please try again.' ) );
 }

} 
public Account method2(){
    system.debug('method2 account List====');
    List<account> listOfAccounts=[select id,Name,User__c from Account where User__c=:contactRecord.Id  Limit 1];
    system.debug('method2 account List====' + JSON.serialize(listOfAccounts));
    if(!listOfAccounts.isEmpty()){
        system.debug('method2 inside If condition accounts List===='+ JSON.serialize(listOfAccounts));
        return listOfAccounts.get(0);
    }
return null;
}

}