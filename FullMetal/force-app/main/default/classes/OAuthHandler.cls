public class OAuthHandler {
    
    public static String OAUTH_ACCESS_TOKEN_ENDPOINT;
    public static String OAUTH_REFRESH_TOKEN_ENDPOINT;    
    public static String OAUTH_ACCESS_TOKEN;
    public static String OAUTH_CLIENT_ID;
    public static String OAUTH_CLIENT_SECRET;
    public static String OAUTH_REFRESH_TOKEN;
    public static String OAUTH_CODE;
    
    
    public static tokenResponse getOauthAccessToken() {
        
        //GET ADOBE CUSTOM SETTING
        AdobesignRestAPi__c adobeSign_CS = AdobesignRestAPi__c.getValues('AdobesignCreds');
        
        OAUTH_REFRESH_TOKEN = (String) adobeSign_CS.get('refresh_token__c');
        OAUTH_CLIENT_SECRET = (String) adobeSign_CS.get('client_secrate__c');
        OAUTH_CLIENT_ID = (String) adobeSign_CS.get('client_id__c');
        OAUTH_REFRESH_TOKEN_ENDPOINT = (String) adobeSign_CS.get('endpoint__c');
        //  OAUTH_CODE= (String) adobeSign_CS.get('code__c');
        
        HttpRequest req = new HttpRequest();
        
        //REQUEST BODY
        String requestBody = 'refresh_token=' + OAUTH_REFRESH_TOKEN +
            '&client_id=' + OAUTH_CLIENT_ID +
            '&client_secret=' + OAUTH_CLIENT_SECRET +
            '&grant_type=refresh_token'; 
        
        req.setEndpoint(OAUTH_REFRESH_TOKEN_ENDPOINT + '/oauth/refresh');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody(requestBody);
        req.setMethod('POST');
        tokenResponse TokenResp=new tokenResponse();
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        if(res.getStatusCode() == 200) {
            System.debug('REFRESH TOKEN ' + res.getBody());
            TokenResp = (tokenResponse) JSON.deserialize(res.getBody(), tokenResponse.class);
            return TokenResp;
        }else
            return getOauth();
    }
    
    public static tokenResponse getOauth() {
        
        //GET ADOBE CUSTOM SETTING
        AdobesignRestAPi__c adobeSign_CS = AdobesignRestAPi__c.getValues('AdobesignCreds');
        
        OAUTH_REFRESH_TOKEN = (String) adobeSign_CS.get('refresh_token__c');
        OAUTH_CLIENT_SECRET = (String) adobeSign_CS.get('client_secrate__c');
        OAUTH_CLIENT_ID = (String) adobeSign_CS.get('client_id__c');
        OAUTH_REFRESH_TOKEN_ENDPOINT = (String) adobeSign_CS.get('endpoint__c');
        OAUTH_CODE= (String) adobeSign_CS.get('code__c');
        String  redirect_uri= (String) adobeSign_CS.get('redirect_uri__c');
        HttpRequest req = new HttpRequest();
        
        //REQUEST BODY
        String requestBody = 'grant_type=' + 'authorization_code' +
            '&redirect_uri='+ redirect_uri +
            '&client_id=' + OAUTH_CLIENT_ID +
            '&client_secret=' + OAUTH_CLIENT_SECRET +
            '&code='+OAUTH_CODE; 
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody(requestBody);
        req.setMethod('POST');
        req.setEndpoint(OAUTH_REFRESH_TOKEN_ENDPOINT +'/oauth/token');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        if(res.getStatusCode() == 200) {
            system.debug('Token From Authorization '+res.getBody());
            OAuthHandler.tokenResponse tokenWrapper = (tokenResponse) JSON.deserialize(res.getBody(), tokenResponse.class);
            return tokenWrapper;
        }else
            return null;
    }
    
   /* public static Boolean updateAbodeCustomSetting(OAuthHandler.tokenResponse tokenWrapper) {  
        
        AdobesignRestAPi__c adobeSign_CS = new AdobesignRestAPi__c();
        
        if(String.isNotEmpty(tokenWrapper.ACCESS_TOKEN))            
            adobeSign_CS.access_token__c = tokenWrapper.ACCESS_TOKEN;
        
        if(String.isNotEmpty(tokenWrapper.REFRESH_TOKEN))
            adobeSign_CS.refresh_token__c = tokenWrapper.REFRESH_TOKEN;
        
        try {
            update adobeSign_CS;
            return true;
        }catch(Exception e) {
            //SEND ERROR NOTIFICATION TO DEVELOPER VIA EMAIL
            return false;   
        }            
    }*/
    
    public class tokenResponse {
        Public String ACCESS_TOKEN;
        Public String REFRESH_TOKEN;    
        Public String TOKEN_TYPE;
        Public String EXPIRES_IN;
    }
    
}