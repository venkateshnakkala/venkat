/**
 * An apex page controller that takes the user to the right start page based on credentials or lack thereof
 */
@IsTest public with sharing class CommunitiesLandingControllerTest {
    @IsTest(SeeAllData=true) public static void testCommunitiesLandingController() {
        // Instantiate a new controller with all parameters in the page
        CommunitiesLandingController controller = new CommunitiesLandingController();
        
        String communityUrl = 'https://lafilmschool.force.com';
        String customHomePage = '/Application?sId=02';
   
        //System.assertEquals(PageReference('https://lafilmschool.force.com/Application'), controller.forwardToStartPage());
        PageReference pageRef = controller.forwardToStartPage();

        //Beginning of System Asserts, verify pageRef and URL First
        System.assertNotEquals(null,pageRef);
        //System.assertEquals('https://lafilmschool.force.com/Application',pageRef.getUrl());
    
        //Verify the pageRef parameters as well
        Map<String,String> pageParameters = pageRef.getParameters();
        System.assertEquals(1,pageParameters.values().size());
        //System.assertEquals('recordId',pageParameters.get('id'));
      }
}