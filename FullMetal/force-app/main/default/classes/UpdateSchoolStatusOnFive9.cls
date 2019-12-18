global class UpdateSchoolStatusOnFive9 
{
@future (callout=true)
    
    public static void UpdateStatus(String url)
    {
     HttpRequest req = new HttpRequest();
     req.setEndpoint(url);
     req.setMethod('GET');   
     Http http = new Http();
     
        if(test.isRunningTest())
        {
         System.debug('testing done - isRunningTest');   
        }
        else
        {
            HTTPResponse res = http.send(req);
            System.debug(res.getBody());   
        }
    
    }
}