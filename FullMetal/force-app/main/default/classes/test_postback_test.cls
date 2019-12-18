@isTest(SeeAllData=true)
public class test_postback_test{
    
    public static testmethod void  test1(){
        PageReference pageRef = Page.test_postback;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('test','test');
        test_postback t = new test_postback();
        t.action();

    }
}