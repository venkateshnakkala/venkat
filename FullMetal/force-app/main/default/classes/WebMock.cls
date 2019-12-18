@isTest
global class WebMock implements HttpCalloutMock {

   global HTTPResponse respond(HTTPRequest req) {
      HTTPResponse res = new HTTPResponse();
      /*
        Code to mock HTTP 200 response. There are two callouts one to get the token and another to get account data after passing the token. I have an if condition to set responses for both the calls.
       */
      return res;
   }

}