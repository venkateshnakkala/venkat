global with sharing class ApplicationLoginController {
    global String username {get; set;}
    global String password {get; set;}
    global String schoolId{get;set;}
    global ApplicationLoginController () {
        if(ApexPages.currentPage().getParameters().get('sId') != null){         
                schoolId =ApexPages.currentPage().getParameters().get('sId');
        }
        else{
            schoolId = '01';
        }        
    }
    global PageReference login() {
        PageReference applicationPage = Site.login(username, password, null); 
        if(applicationPage != null){
            return Site.login(username, password, null);   
        }
        return null;
    } 
     // Code we will invoke on page load.
    global PageReference forwardToAuthPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL')+ '?sId=' + schoolId;
        String displayType = System.currentPageReference().getParameters().get('display');
        return Network.forwardToAuthPage(startUrl + '?sId=' + schoolId, displayType);
    }
    global PageReference forwardToCustomRegPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        //return new PageReference(Site.getPathPrefix() + '/ApplicationSelfRegister?startURL=' + EncodingUtil.urlEncode(startURL, 'UTF-8'));
        return new PageReference(Site.getPathPrefix() + '/ApplicationSelfRegister' + '?sId=' + schoolId);
    }
    global PageReference forwardToForgotPassPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        //return new PageReference(Site.getPathPrefix() + '/ApplicationForgotPassword?startURL=' + EncodingUtil.urlEncode(startURL, 'UTF-8'));
        return new PageReference(Site.getPathPrefix() + '/ApplicationForgotPassword' + '?sId=' + schoolId);
    }
   
}