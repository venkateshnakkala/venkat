public class TOG_UPLOADS
{
    public Blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    
    public String[] csvFileLines{get;set;}
    public List<Id> ids{get;set;}
    public List<Contact> con {get;set;}
    
    public TOG_UPLOADS()
    {
        csvFileLines = new String[]{};
        ids = new List<Id>();
        con = new List<Contact>();
    }
  
    public void importCSVFile()
    {
        try
        {
            csvAsString = csvFileBody.toString();
            csvFileLines = csvAsString.split('\n'); 
            
            for(Integer i=1;i<csvFileLines.size();i++)
            {
               string[] csvRecordData = csvFileLines[i].split(',');
               ids.add(csvRecordData[0].replace('"','').trim());             
            
            }
            
            if(ids.size()>0)
            {
                List<Contact> chunk = new List<Contact>();
                con=[select id, Exclude_TOG__c, owner.id, owner.name, program_code__c from contact where owner.id='0051a000002tHWn' and id in:ids];
                
                for(Contact c :Con)
                {
                    chunk.add(c);
                    
                    if(chunk.size()==5)
                    {
                        Database.executeBatch(new RoundRobinInBatches(chunk),5);
                        chunk = new List<Contact>();
                    }
                }
                
                if(chunk.size()>0){
                    Database.executeBatch(new RoundRobinInBatches(chunk),5);
                }
            }
        
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,e.getMessage());
            ApexPages.addMessage(errorMessage);
        }
        
    }
}