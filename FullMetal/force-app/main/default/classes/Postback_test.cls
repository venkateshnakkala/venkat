@isTest(SeeAllData=true)
public class Postback_test{
    
    public static testmethod void  test1(){
        PageReference pageRef = Page.Postback;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('uid','12345');
        ApexPages.currentPage().getParameters().put('confirmation','12345');
        ApexPages.currentPage().getHeaders().put('X-Salesforce-SIP','207.66.146.132');
        
        Postback t = new Postback();
        t.action();
        
        ApexPages.currentPage().getParameters().put('uid','12345');
        ApexPages.currentPage().getParameters().put('confirmation','ERROR');
        t.action();
    }
}