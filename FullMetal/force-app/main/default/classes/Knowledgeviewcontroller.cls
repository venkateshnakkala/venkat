public class Knowledgeviewcontroller {
    
    public id knowledgeid{get;set;}
    public Knowledge__kav knowledgedata{get;set;}
    public string bodycontent{get;set;}
    
    public Knowledgeviewcontroller(){
       // knowledgeid='kA0S0000000Emr9';
       bodycontent='';
       knowledgeid= ApexPages.currentPage().getParameters().get('id');
       knowledgedata=[SELECT Id, title, UrlName, LastPublishedDate,LastModifiedById,Highlighted__c,body__c FROM Knowledge__kav where id=:knowledgeid];
       if(knowledgedata.body__c!=''){
           bodycontent=knowledgedata.body__c;
       }
    }
}