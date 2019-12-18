global class DSSendtoQueue {
    
    @InvocableMethod
    public static void DSSendtoQueue(List<sobjectsListRequests> requests)
    {   
        System.debug('In Invocable Method');
        ID OBID;
        ID UID;
        String phoneNum;
        Datetime callBackTime;

        for (sobjectsListRequests request : requests)
        {
            OBID = request.OBID;
            UID = request.UID;
            phoneNum = request.phoneNum;
            callBackTime = request.callBackTime;
            system.debug('Time = ' + callBackTime);
        }
        
        try
        {
            DSSendtoBackend RTPQ = new DSSendtoBackend(UID, OBID, phoneNum, callBackTime/*priorityScore, groupNumber*/);
            ID jobID = System.enqueueJob(RTPQ);
        }
        catch(exception e)
        {
            System.debug('Failed to enqueue batch job.  Error: ' + e);
        }            
    }
      
    global class sobjectsListRequests
    {
        @InvocableVariable(required=True)
        public Id OBID;
        @InvocableVariable(required=True)
        public Id UID;
        @InvocableVariable(required=False)
        public String phoneNum;
        @InvocableVariable(required=False)
        public Datetime callBackTime;
    }
}