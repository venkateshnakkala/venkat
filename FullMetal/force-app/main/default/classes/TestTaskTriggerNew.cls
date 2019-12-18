@isTest   //@isTest(seeAllData=true)
public class TestTaskTriggerNew {

    static testmethod void test()
      {
          Account acc = New Account(Name = 'Test Account');
          insert acc;
          
          Contact con = New contact ();
          con.LastName = 'con';
          con.AccountId = acc.Id;
          insert con;
          
          Event evt = New Event ();
          evt.Event_Subject__c = 'Test';
          evt.StartDateTime = system.now();
          evt.EndDateTime = system.now();
          evt.WhoId = con.id;
          insert evt; 
          
            date duedate = system.today();
            date newdate = duedate.addDays(1);
          
          Task testTask = new Task();
          testTask.event_id__c = evt.id;
          //testTask.Event_Results__c = 'No Show';
          insert testTask;
          
          Task testTaskUpd = new Task(Id=testTask.Id);
          testTaskUpd.Event_Results__c = 'No Show';
          update testTaskUpd;
              
      }
          }