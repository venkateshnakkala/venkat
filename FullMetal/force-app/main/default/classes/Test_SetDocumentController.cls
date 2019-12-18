@isTest
private class Test_SetDocumentController {
    @isTest static void SetDocument(){

     Id fldr = [select id from folder where name = 'LAFS-Application'].id;  
        
        document doctest = new document(Name ='Landing_page_Image',
                                       FolderId = fldr);   
        insert doctest;
         
        SetDocumentController docController = new SetDocumentController();
        
        PageReference ref = new PageReference('/apex/Documentlandingpage');
        Test.setCurrentPage(ref);
        docController.getlandingimage();
         
    
    }
   @isTest static void SetDocumentElse(){
     SetDocumentController docController = new SetDocumentController();
    docController.getlandingimage();
    }
   
}