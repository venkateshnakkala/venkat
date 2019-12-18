/**
 * An apex page controller that takes the user to the right start page based on credentials or lack thereof
 */
public with sharing class CommunitiesLandingController {
	public String schoolId{get;set;}
    
    // Code we will invoke on page load.
    public PageReference forwardToStartPage() {      
        String communityUrl = Site.getPathPrefix();
        String customHomePage = '/Application?sId=' + schoolId;
        if (UserInfo.getUserType().equals('Guest')) {
            return new PageReference(communityUrl + '/ApplicationLogin?sId=' + schoolId);
        } 
        else {
            return new PageReference(communityUrl + customHomePage);
            }
        }

    
    public CommunitiesLandingController() {
    	if(ApexPages.currentPage().getParameters().get('sId') != null){         
                schoolId =ApexPages.currentPage().getParameters().get('sId');
        }
        else{
            schoolId = '01';
        }    
    
    }
}