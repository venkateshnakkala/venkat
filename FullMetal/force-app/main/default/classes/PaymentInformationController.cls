public class PaymentInformationController {

    public Application__c recordApplication{get;set;}


    public PaymentInformationController(){}
    
    @RemoteAction
    Public Static string payinfoupdate( string ApplicationId){
    Application__c Application=New Application__c();
        if(ApplicationId !=''){
            Application=[select id,Pay_Later__c from Application__c where id=:ApplicationId];
            Application.Pay_Later__c =true;
            update Application;
            return 'True';
        }else{
            return 'False';
        
        }
    }
    
    
    @RemoteAction
    Public Static string getPaymentLink(string selectedApplicationId){
    
        Application__c appToGet = null;
        List<Application__c> appsToGet = [SELECT id,Name,Application_Number__c,Student__r.Name,Student__r.FirstName,
        Student__r.LastName,
        Student__r.Phone,
        Student__r.Email,
        Student__r.MailingCountry,
        Student__r.MailingPostalCode,
        Student__r.MailingStreet,
        Student__r.MailingCity,
        Student__r.MailingState
        
        FROM Application__c where Id = :selectedApplicationId  ORDER BY createdDate DESC LIMIT 1];
       // FROM Application__c WHERE Student__c =: studentId AND Id = :selectedApplicationId ORDER BY createdDate DESC LIMIT 1];
        
        
        string payLink = 'https://staging.officialpayments.com/pc_entry_cobrand.jsp?productId=196583491153443887843804494705627227&';
        payLink += 'firstName='+appsToGet[0].Student__r.FirstName+'&';
        payLink += 'lastName='+appsToGet[0].Student__r.LastName+'&';
        payLink += 'address1='+appsToGet[0].Student__r.MailingStreet+'&';
        payLink += 'cityName='+appsToGet[0].Student__r.MailingCity+'&';
        payLink += 'provinceCd='+appsToGet[0].Student__r.MailingState+'&';
        payLink += 'postalCd='+appsToGet[0].Student__r.MailingPostalCode+'&';
        payLink += 'countryCd='+appsToGet[0].Student__r.MailingCountry+'&';
        payLink += 'phoneNum='+appsToGet[0].Student__r.Phone+'&';
        payLink += 'email='+appsToGet[0].Student__r.email+'&';
        payLink += 'cde-StudFirs-2='+appsToGet[0].Student__r.FirstName+'&';
        payLink += 'cde-StudLast-0='+appsToGet[0].Student__r.LastName+'&';
        payLink += 'cde-UniqID-1='+appsToGet[0].Name+'&';
        payLink += 'cde-StudID-3='+appsToGet[0].Application_Number__c+'&';
        payLink += 'paymentAmount=75.00&';
        payLink += 'paymentType=STUSCHED&';
        
        payLink += 'ccType=VI&';
       // payLink += 'postbackUrl=https://sfcindia-lafilmschool.cs53.force.com?goToSection=uploadDetailsSection/Postback&';
        //payLink += 'returnUrl=https://sfcindia-lafilmschool.cs53.force.com?goToSection=uploadDetailsSection&';
        //payLink += 'errorUrl=https://sfcindia-lafilmschool.cs53.force.com?goToSection=uploadDetailsSection&';
       // payLink += 'cancelUrl=https://sfcindia-lafilmschool.cs53.force.com?goToSection=uploadDetailsSection&';
        //string payLink='<html><Body><form method="POST" action="https://staging.officialpayments.com/pc_entry_cobrand.jsp"> <input type="hidden" name="productId" value="196583491153443887843804494705627227"> <input type="text" name="firstName" value="Akhil"> <input type="text" name="middleName" value=""> <input type="text" name="lastName" value="Mehra"> <input type="text" name="suffix" value="Mr"> <input type="text" name="address1" value="test city"> <input type="text" name="address2" value=""> <input type="text" name="cityName" value="Test CIty"> <input type="text" name="provinceCd" value="LA "> <input type="text" name="postalCd" value="90002"> <input type="text" name="phoneNum" value="9779542671"> <input type="text" name="email" value="akhilmehra0069@gmail.com"> <input type="text" name="paymentAmount" value="75"> <input type="Submit" value="Submit"> </form></body></html>';   
        system.debug('payLink==='+payLink);
        return payLink;
    }
}