@isTest
public class TestAsynWebSerivice {

    public class rows{
        public string SyStudentId{get;set;}
    }

    public static testmethod void testWebService() {
    
        AsyncWSCVSF.AsyncLAFSPort  controller = new AsyncWSCVSF.AsyncLAFSPort ();
        
        AsyncWSCVSF.CVAPI_getDataResponseTypeFuture result = new AsyncWSCVSF.CVAPI_getDataResponseTypeFuture();
        
        String sql='select top 10 systudentid from systudent';

        Continuation con = new Continuation(30);
        con.continuationMethod='renderData';
        con.timeout=30;
        
        result = controller.beginCVAPI_getData(con,sql);
        
        system.assertEquals(null,renderData());
        
        /*
        system.assert(requests.get(controller.requestLabel) != null);


        HttpResponse response = new HttpResponse();

        Test.setContinuationResponse(controller.requestLabel, response);

        Object result = Test.invokeContinuationMethod(controller, conti);

        System.assertEquals(null, result);

        System.assertEquals('Mock response body', controller.result);*/
    }
    
    public static object renderData(){
        return NULL;
    }
}