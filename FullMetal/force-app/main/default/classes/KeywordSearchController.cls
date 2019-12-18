public  class KeywordSearchController {

 //Page Size
 private Static Final Integer PAGE_NUMBER = 25;
 final String PUBLISH_STATUS_ONLINE = 'Online';
  //Search String used in ArticleList tag
 public String searchstring { get; set; }
    public List<Knowledge__kav> articleList{get;set;}
    public String qryString { get; set; }
    public Boolean hasrecords { get; set; }
 public KeywordSearchController() {
 qryString = 'SELECT Id, title, UrlName, LastPublishedDate,LastModifiedById,Highlighted__c FROM Knowledge__kav WHERE (PublishStatus = \'online\' and Language = \'en_US\' and Highlighted__c=true)';
   runQuery();
    system.debug('articleList=='+articleList);
     system.debug('articleList=='+articleList.size());
 maxSize = articleList.size() ;
  if(articleList.size()>0){
      
          hasrecords =True;
      }else{
          hasrecords =False;
      }

 }
  // runs the actual query
  public void runQuery() {
        
    try {
      articleList = Database.query(qryString);
     
    } catch (Exception e) {
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
    }

  }
    public PageReference runSearch() {
        if(searchstring !=''){
         qryString = 'SELECT Id, title, UrlName, LastPublishedDate,LastModifiedById,Highlighted__c FROM Knowledge__kav WHERE (PublishStatus = \'online\' and Language = \'en_US\')';
         qryString +=' and title LIKE '+'\''+'%'+searchstring+'%'+'\'';
        }else{
            qryString = 'SELECT Id, title, UrlName, LastPublishedDate,LastModifiedById,Highlighted__c FROM Knowledge__kav WHERE (PublishStatus = \'online\' and Language = \'en_US\' and Highlighted__c=true)';

        }
        system.debug('qryString=='+qryString);
        runQuery();
         if(articleList.size()>0){
      
          hasrecords =True;
      }else{
          hasrecords =False;
      }
        return null;
    }
 //Keeps track of current page & max size of article list
 Integer currentPage = 1;
 Integer maxSize = 1;
 
 // Returns whether we need to see previous button or not
 public boolean getPrevRequired() {
  return currentPage > 1;
 }

 // Returns whether we need to see next button or not
 public boolean getNextRequired() {
  return currentPage * PAGE_NUMBER < maxSize;
 }
 
 //Returns current page number 
 public Decimal getCurrentPageNumber() {
  return this.currentPage;
 }

 //action for next click
 public PageReference next() {
  if(maxSize > this.currentPage * PAGE_NUMBER) {
   this.currentPage = this.currentPage + 1;
  }
  return null;
 }    
 
 //action for previous click
 public PageReference previous() {        
  if(this.currentPage > 1)
   this.currentPage = this.currentPage - 1;
  return null;
 }


}