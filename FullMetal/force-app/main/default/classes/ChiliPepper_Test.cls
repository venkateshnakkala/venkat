@isTest(SeeAllData=true)
class ChiliPepper_Test {
    static testMethod void test1() 
    {
        User u = [select id, name from user where firstname='LA Film' and lastname='School' and isactive=true limit 1];
        Contact c = [select id from contact limit 1];
        
        datetime datestart = Datetime.newInstance(2015, 20 , 12, 00, 00, 00);
        datetime dateend = Datetime.newInstance(2015, 20 , 12, 01, 00, 00);
        Event e = new Event();
        e.StartDateTime = datestart;
        e.EndDateTime = dateend;
        e.Subject = 'Daily Tour';
        e.WhoId = c.id;
        e.DurationInMinutes=60;
        e.ActivityDateTime=datestart;
        e.ownerid=u.id;
        insert e;
    }

}