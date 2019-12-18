@isTest
public class Test_KeywordSearchController {
    public static testmethod void keywordsearch(){
        List<Knowledge__kav> kav=new List< Knowledge__kav>();
        Knowledge__kav kv = new Knowledge__kav();
        kv.Body__c = 'tfshuys';
        kv.Title='dtrdt';
        kv.UrlName='gtdfy';
        kv.Highlighted__c=true;
        //kv.PublishStatus='online';
        kv.Language='en_US';
        insert kv;
        kav.add(kv);
        KeywordSearchController controller = new KeywordSearchController();
        controller.searchstring='sdfgy';
        controller.qryString='kjhgfds';
        controller.hasrecords=true;
        List<Knowledge__kav> art = controller.articleList;
        
        PageReference ref = new PageReference('/apex/NewApplicationDetail');
        Test.setCurrentPage(ref);
        PageReference ref1 = new PageReference('/apex/NewApplication');
        Test.setCurrentPage(ref1);
        PageReference ref2 = new PageReference('/apex/NewApplicationComponent');
        Test.setCurrentPage(ref2);
        controller.runQuery();
        controller.getPrevRequired();
        controller.getNextRequired();
        controller.getCurrentPageNumber();
        controller.runSearch();
        controller.next();
        controller.previous();
    }
   
    
}