public class DSSendtoBackend implements Queueable, Database.AllowsCallouts{
    ID UID;
    ID OBID;
    String phoneNum;
    Datetime callBackTime;
    //Integer priorityScore;
    //Integer groupNumber;
    
    public DSSendtoBackend(ID UID, ID OBID, String phoneNum, Datetime callBackTime /*Integer priorityScore, Integer groupNumber*/)
    {
        
        this.UID = UID;
        this.OBID = OBID;
        this.phoneNum = phoneNum;
        
        system.debug('Phone # = ' + this.phoneNum);

        this.callBackTime = callBackTime;
        //this.priorityScore = priorityScore;
        //this.groupNumber = groupNumber;
    } 
    
    public static String validPhoneNum(String phoneNumber)
    {
        System.debug('validPhoneNumber- ' + phoneNumber);
        return phoneNumber.replaceAll('[^0-9]', '');
    }
    
    public void execute(QueueableContext context)
    {
        String httpBody = '';
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://devtest.refractivedialer.com/SubmitCallBack.php');//('https://rs.refractivedialer.com/SubmitCallBack.php');
        req.setMethod('POST');
        req.setHeader('Connection', 'close');
        String struId = Id.valueOf(UID);
        String stroId = Id.valueOf(OBID);
        
        system.debug('struId = ' + Id.valueOf(UID));

        //if(groupNumber == 0)
        //{
        // httpBody = 'sfdc_user_id=' + struId + '&id=' + stroId + '&number=' + validPhoneNum(phoneNum) + /*'&priority=' + priorityScore + '&group_id=' + '45'+*/ '&isGlobal=' + False + '&activate_time=' + callBackTime;
        //}
        //else
        //{
            httpBody = 'sfdc_user_id=' + struId + '&id=' + stroId + '&number=' + validPhoneNum(phoneNum) +
            /*+ '&priority=' + priorityScore + '&group_id=' + groupNumber +'&isGlobal=' + 
               False + */'&activate_time=' + callBackTime;
        //}
        req.setBody(httpBody);
        try{
            HttpResponse res = h.send(req);
            System.debug('response' + res.getBody() );
        }
        catch (Exception e){
            System.debug('error, in the exception now');
        }
    }
}