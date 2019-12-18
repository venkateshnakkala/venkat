public class ScanQr {
public  Contact ct{get; set; }


    public ScanQr(ApexPages.StandardController controller) {
    String recid=controller.getRecord().id;
    Ct=[Select ID,Name,FirstName,LastName,Email,Phone,Program_Code__c,Program__c,Owner.Name From Contact Where Id=:recid];

    }


}