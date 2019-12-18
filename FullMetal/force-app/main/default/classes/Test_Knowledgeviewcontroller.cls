@isTest
public class Test_Knowledgeviewcontroller {

    public static testmethod void TestKnowledge(){
        List<Knowledge__kav> kav=new List< Knowledge__kav>();
        
       Knowledge__kav kv = new Knowledge__kav();
        kv.Body__c = 'tfshuys';
        kv.Title='dtrdt';
        kv.UrlName='gtdfy';
        insert kv;
        kav.add(kv);
       system.debug(kav[0].Id);
        PageReference pageRef = new PageReference('/apex/KnowledgeArticleViewpage');
        pageRef.getParameters().put('id',kv.id);
        Test.setCurrentPage(pageRef);
        Knowledgeviewcontroller controller = new Knowledgeviewcontroller();
        controller.knowledgeid=kav[0].Id;
       
       
    }
}