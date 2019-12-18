public class adobesignIntegration {
    
    @Future(callout=True)
    public static void Esignurl(String signAgg) {
        // Query Agreement Record
        List<echosign_dev1__SIGN_Agreement__c> SignAgreementList=[SELECT Application__c,echosign_dev1__Document_Key__c,EsignUrl__c,Total_Esign_Url_Records__c,Id,Name FROM echosign_dev1__SIGN_Agreement__c WHERE Total_Esign_Url_Records__c <= 0 AND echosign_dev1__StatusVisible__c='Out for Signature' AND Application__c =:signAgg Order By CreatedDate];
        system.debug('SignAgreementList size'+SignAgreementList.size());
        String AgreementId;//=SignAgreement.echosign_dev1__Document_Key__c;
        
        //ENDPOINT URL
        String requestEndPointURL; //= '/api/rest/v5/agreements/' + AgreementId + '/signingUrls';
        List<String> requestEndPointURLList=new List<String>();
        for(echosign_dev1__SIGN_Agreement__c SignAgreement:SignAgreementList){
            AgreementId=SignAgreement.echosign_dev1__Document_Key__c;
            requestEndPointURL='/api/rest/v5/agreements/' + AgreementId + '/signingUrls';
            requestEndPointURLList.add(requestEndPointURL);
        }
        List<Agreement_Esign_Urls__c> SignUrlList =new List<Agreement_Esign_Urls__c>();
        integer i=0;
        for(String st :requestEndPointURLList){
            HTTPResponse response = doHTTPCallout(st, 'GET', null);
            if(response.getStatusCode() == 200) { //REQUEST IS SUCCESSFUL
                system.debug('resp'+response.getBody());
                Agreement_Esign_Urls__c SignUrl=EsignurlRequestBody(response.getBody(), SignAgreementList[i]);
                
                if(SignUrl != null)
                    SignUrlList.add(SignUrl);         
                
            }
            i++;
        }
        if(SignUrlList.size()>0)
            insert SignUrlList;
        
        
    }
    
    public static Agreement_Esign_Urls__c EsignurlRequestBody(String masterList,echosign_dev1__SIGN_Agreement__c SignAgreement){
        Map<String, Object> cObjMap = (Map<String, Object>) JSON.deserializeUntyped(masterList);
        //AdobesignRestAPi__c CustomStting=new AdobesignRestAPi__c();
        String cObjJson = JSON.serialize(cObjMap.get('signingUrlSetInfos'));
        cObjJson=cObjJson.removeStart('[');
        cObjJson=cObjJson.removeEnd(']');
        Map<String, Object> cObjMapFurious = (Map<String, Object>) JSON.deserializeUntyped(cObjJson);
        String cObjJson2 = JSON.serialize(cObjMapFurious.get('signingUrls'));
        cObjJson2=cObjJson2.removeStart('[');
        cObjJson2=cObjJson2.removeEnd(']'); 
        Map<String, object> cObjMapFuriousva = (Map<String,object>) JSON.deserializeUntyped(cObjJson2);
        String esiginingurl=string.valueOf(cObjMapFuriousva.get('esignUrl'));
        Agreement_Esign_Urls__c Agg=new Agreement_Esign_Urls__c();
        Agg.AgreemAgreement__c=SignAgreement.id;
        Agg.Esign_Url__c=esiginingurl;
        //CustomStting=adobeSign_CSUp;
        //update CustomStting ;
        return Agg;
        
    }
    
    
    public static HTTPResponse doHTTPCallout(String requestEndPointURL, String requestMethod, String requestBody) {
        //GET ADOBE CUSTOM SETTING
        AdobesignRestAPi__c adobeSign_CS = AdobesignRestAPi__c.getValues('AdobesignCreds');
        
        
        if(adobeSign_CS == null)
            return null;
        
        String endpointURL = adobeSign_CS.endpoint__c;
        endpointURL += requestEndPointURL;
        
        //INITIATE HTTP REQUEST
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setHeader('Authorization', 'Bearer ' + adobeSign_CS.access_token__c);
        req.setMethod(requestMethod);
        req.setEndpoint(endpointURL);
        
        if(String.isNotEmpty(requestBody))
            req.setBody(requestBody);
        
        HTTPResponse response = http.send(req);
        
        if(response.getStatusCode() == 401) {
            Boolean tokenGenerated;
            OAuthHandler.tokenResponse tokenWrapper=OAuthHandler.getOauthAccessToken();
            system.debug('Token Response**** '+tokenWrapper);
            if(tokenWrapper.ACCESS_TOKEN!=null && tokenWrapper.ACCESS_TOKEN!=''){
                tokenGenerated=True;
                if(tokenGenerated)
                    return doHTTPCallout1(requestEndPointURL, requestMethod, requestBody,tokenWrapper);
            }
        }else 
            return response;
        
        return null;
    } 
    public static HTTPResponse doHTTPCallout1(String requestEndPointURL, String requestMethod, String requestBody ,OAuthHandler.tokenResponse tk) {
        //GET ADOBE CUSTOM SETTING
        AdobesignRestAPi__c adobeSign_CS = AdobesignRestAPi__c.getValues('AdobesignCreds');
        if(adobeSign_CS == null)
            return null;
        
        String endpointURL = adobeSign_CS.endpoint__c;
        endpointURL += requestEndPointURL;
        system.debug('Token From wrapper '+tk.ACCESS_TOKEN);
        //INITIATE HTTP REQUEST
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setHeader('Authorization', 'Bearer ' + tk.ACCESS_TOKEN);
        req.setMethod(requestMethod);
        req.setEndpoint(endpointURL);
        
        if(String.isNotEmpty(requestBody))
            req.setBody(requestBody);
        
        HTTPResponse response = http.send(req);
        if(response.getStatusCode() == 200) {
            if(String.isNotEmpty(tk.ACCESS_TOKEN))            
                adobeSign_CS.access_token__c = tk.ACCESS_TOKEN;
            
            if(String.isNotEmpty(tk.REFRESH_TOKEN))
                adobeSign_CS.refresh_token__c = tk.REFRESH_TOKEN;
            update adobeSign_CS;
            
            
        }
        
        
        return response;
        
    }   
    
    
}