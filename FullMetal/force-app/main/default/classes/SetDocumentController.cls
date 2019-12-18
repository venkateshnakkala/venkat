Public class SetDocumentController{

    public setdocumentcontroller(){
      
        
    }
    
    Public PageReference  getlandingimage()
    {
        List<document> documentList = [select Id,name from document where 
                                                  Name = 'Landing_page_Image'];
    
        if(documentList != null && documentList.size() > 0)
        {
            return  new PageReference('/apex/Documentlandingpage?id='+documentList[0].id);
        }
        else
        {
            return new PageReference('/015');
        }    
    }
}