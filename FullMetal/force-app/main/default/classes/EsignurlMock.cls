@isTest
global class EsignurlMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        //for esign url
        system.debug('Request endpoint====== '+req.getEndpoint());
        string endpointt=req.getEndpoint();
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        if(endpointt.contains('signingUrls')){
            String esignurl= '{ "signingUrlSetInfos": [ { "signingUrls": [ { "email": "akhilkashyap777@gmail.com", "esignUrl": "https://secure.na1.echosign.com/public/apiesign?pid=CBFCIBAA3AAABLblqZhDwk2P5xE4Dft33Li_RynoodgalOZHPDtavtFG3FLAx5IkLbXV2gO7jwBZpBYdXfAI*" } ] } ] }';
            
            response.setBody(esignurl);
            response.setStatusCode(401);
            return response;
            
        }
        else if(endpointt.contains('refresh')){
            response.setBody('{ "access_token": "3AAABLblqZhD12NPRm4Q2hn0FIG9UaBoyZ3IRqbHmHpMWa3a2YYdnTYc4Osivg7tSOtN_ctDOZqd4gS_0K4GhPWQUPCKiVb1F", "refresh_token": "3AAABLblqZhAnOBUxIEk6nE7EXJULK4an7x9aotpPBDsAMEJA6IK_76Q6mXGniMJKO_d01ANlysM*", "token_type": "Bearer", "expires_in": 3600 }');
            response.setStatusCode(401);
            return response;
        }        
        
        else{
            response.setBody('{ "access_token": "3AAABLblqZhD12NPRm4Q2hn0FIG9UaBoyZ3IRqbHmHpMWa3a2YYdnTYc4Osivg7tSOtN_ctDOZqd4gS_0K4GhPWQUPCKiVb1F", "refresh_token": "3AAABLblqZhAnOBUxIEk6nE7EXJULK4an7x9aotpPBDsAMEJA6IK_76Q6mXGniMJKO_d01ANlysM*", "token_type": "Bearer", "expires_in": 3600 }');
            response.setStatusCode(200);
            return response;
        }
        //return response;
        
    }
}