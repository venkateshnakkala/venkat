public class rating_case_controller{

public decimal rating{get;set;}
public string comment{get;set;}
    public case caseObj{get;set;}
string caseId;

public rating_case_controller(ApexPages.StandardController controller) {
 caseId = apexpages.currentpage().getparameters().get('Id');   
    caseObj = [Select Rating__c,Casenumber,Subject from Case where id =:caseId ];
 }
 
 public void saveCase(){
 system.debug('save');
     Case cases = new Case(Id=caseId,Comment__c = comment,Rating__c = rating);
     update cases;
     
     caseObj = [Select Rating__c,Casenumber,Subject from Case where id =:caseId ];
 }
}