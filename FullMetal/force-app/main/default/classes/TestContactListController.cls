@isTest
public class TestContactListController {

    static testmethod void StartTest()
    {
   	    ContactListController clc = new ContactListController();
        
        //Query Details work
        Query__c que = new Query__c();
        que.name = 'Test Query';
        que.FilterField1__c='School_Status__c';
        que.FilterField1Operator__c='=';
        que.FilterField1Value__c='';
        que.FilterField2__c ='School_Status__c';
        que.FilterField2Operator__c ='<>';
        que.FilterField2Value__c='';
        que.FilterField3__c ='School_Status__c';
        que.FilterField3Operator__c ='like start';
        que.FilterField3Value__c='';
        que.FilterField4__c ='School_Status__c';
        que.FilterField4Operator__c='like mid';
        que.FilterField4Value__c='';
        que.FilterField5__c ='School_Status__c';
        que.FilterField5Operator__c='=';
        que.FilterField5Value__c='';
        que.SortBy1__c ='School_Status__c';
        que.SortBy1Direction__c='asc';
        que.SortBy2__c ='School_Status__c';
        que.SortBy2Direction__c='asc';
        que.SortBy3__c ='School_Status__c';
        que.SortBy3Direction__c='asc';
        que.All_or_My__c = 'my';
        insert que;
        
       clc.QueryDetail = [Select name, FilterField1__c, FilterField1Operator__c, FilterField1Value__c,
                       FilterField2__c, FilterField2Operator__c, FilterField2Value__c,
                       FilterField3__c, FilterField3Operator__c, FilterField3Value__c,
                       FilterField4__c, FilterField4Operator__c, FilterField4Value__c,
                       FilterField5__c, FilterField5Operator__c, FilterField5Value__c,
                       SortBy1__c, SortBy1Direction__c,
                       SortBy2__c, SortBy2Direction__c,
                       SortBy3__c, SortBy3Direction__c
                       from Query__c where id = :que.id]; 
        
        clc.LoadAllQueries();
        
        //Searching records by alphabets
        clc.SearchByAlphabets();
        clc.getContactsFiltered();
        
        //Searching records by alphabets with pagination
        clc.SearchByPaging();
        clc.getContactsFiltered();
        
        //Search Records by Keyword
        clc.SearchByKeyword();
        clc.SearchKeyword='andrew';
        clc.SortBy1='School_Status__c';
        clc.SortBy2='None';
        clc.SortBy3='None';
        clc.SortBy4='None';
        clc.getContactsFiltered();
        
        //Search Records by Keyword with paging
        clc.SearchByPaging();
        clc.getContactsFiltered();
        
        //Moving to nextb page
        clc.NextPage();
        clc.getContactsFiltered();
        
        //Moving to previous page
        clc.PreviousPage();
        clc.getContactsFiltered();
        
        //Moving to the page not acceptable by the class
        clc.CurrentPage = 51;
        clc.ApplySorting();
        clc.getContactsFiltered();
        
    }
    
}