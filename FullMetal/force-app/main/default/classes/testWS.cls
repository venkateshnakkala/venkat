@isTest
global class testWS implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
       WSCVSF.CVAPI_getDataResponseType respElement = new WSCVSF.CVAPI_getDataResponseType();
       respElement.data = 'Test';
       response.put('response_x', respElement);
   }
}