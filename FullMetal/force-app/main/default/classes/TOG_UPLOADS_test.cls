@isTest(SeeAllData=true)
public class TOG_UPLOADS_test 
{
    public testmethod static void test1()
    {
        List<Contact> con =[select id from contact where ownerid='0051a000002tHWnAAM' limit 1];
        TOG_UPLOADS T = new TOG_UPLOADS();
        T.csvFileBody=Blob.valueof('SalesForceId\n'+con[0].id);
        T.csvAsString='test.csv';
        T.importCSVFile();
    }
}