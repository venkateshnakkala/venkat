public class sendHttpPostToCV{

@future(callout=true)
    public static void sendHttpRequest(String url){

        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.SetEndPoint(url);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/html');
        req.setBody(''); 
        //req.setTimeout(60000);
        
        if(!system.Test.isRunningTest()) HttpResponse res = h.send(req);
        
    }
}