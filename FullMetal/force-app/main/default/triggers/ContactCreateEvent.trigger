trigger ContactCreateEvent on Contact (after update, after insert) {
    {
        if(trigger.isupdate)
        {
            Map<id,Contact> contactoldmap = trigger.oldmap;
            list<Event> eventlist = new list<Event>();
            
            for(Contact con : trigger.new) 
            {
                Contact conold = contactoldmap.get(con.id);
                DateTime dt = System.now();
                if(con.Event_Scheduled_Date__c != conold.Event_Scheduled_Date__c && conold.CreatedDate < dt.addMinutes(-1))
                {
                    if(con.Event_Scheduled_Date__c != null && con.RSVP_Event_Type__c =='Daily Tour')
                    {
                        {
                            
                            datetime eventscheduleddate = con.Event_Scheduled_Date__c;
                            datetime newdate = eventscheduleddate.addHours(1); 
                            
                            
                            {
                                Event evt = new Event ();
                                evt.Subject = 'Daily Tour';
                                evt.Event_Subject__c = 'Daily Tour';
                                evt.StartDateTime = con.Event_Scheduled_Date__c;
                                evt.EndDateTime = newdate;
                                evt.WhoId = con.Id;
                                evt.OwnerId = '0051a000000aFEJ';
                                eventlist.add(evt);   
                            }                                    
                        }
                    }
                    if(con.Event_Scheduled_Date__c != null && con.RSVP_Event_Type__c =='All Access Tour')
                        
                    {
                        
                        datetime eventscheduleddate = con.Event_Scheduled_Date__c;
                        datetime newdate = eventscheduleddate.addHours(1); 
                        
                        
                        {
                            Event evt = new Event ();
                            evt.Subject = 'All Access Tour';
                            evt.Event_Subject__c = 'All Access Tour';
                            evt.StartDateTime = con.Event_Scheduled_Date__c;
                            evt.EndDateTime = newdate;
                            evt.WhoId = con.Id;
                            evt.OwnerId = '0051a000000aFEJ';
                            eventlist.add(evt);   
                        }                                    
                    }
                    if(con.Event_Scheduled_Date__c != null && con.RSVP_Event_Type__c =='LARS Open House')
                        
                    {
                        
                        datetime eventscheduleddate = con.Event_Scheduled_Date__c;
                        datetime newdate = eventscheduleddate.addHours(1); 
                        
                        
                        {
                            Event evt = new Event ();
                            evt.Subject = 'LARS Open House';
                            evt.Event_Subject__c = 'LARS Open House';
                            evt.StartDateTime = con.Event_Scheduled_Date__c;
                            evt.EndDateTime = newdate;
                            evt.WhoId = con.Id;
                            evt.OwnerId = '0051a000000aFEJ';
                            eventlist.add(evt);   
                        }                                    
                    }
                    if(con.Event_Scheduled_Date__c != null && con.RSVP_Event_Type__c =='EB Open House')
                        
                    {
                        
                        datetime eventscheduleddate = con.Event_Scheduled_Date__c;
                        datetime newdate = eventscheduleddate.addHours(1); 
                        
                        
                        {
                            Event evt = new Event ();
                            evt.Subject = 'EB Open House';
                            evt.Event_Subject__c = 'EB Open House';
                            evt.StartDateTime = con.Event_Scheduled_Date__c;
                            evt.EndDateTime = newdate;
                            evt.WhoId = con.Id;
                            evt.OwnerId = '0051a000000aFEJ';
                            eventlist.add(evt);   
                        }                                    
                    }
                    
                }
            }
            insert eventlist;
        }
        
        list<Event> eventlist = new list<Event>();
        for(Contact con : trigger.new) 
        {
            if(trigger.isInsert) 
            {
                if(con.Event_Scheduled_Date__c != null && con.RSVP_Event_Type__c =='Daily Tour')
                {
                    
                    datetime eventscheduleddate = con.Event_Scheduled_Date__c;
                    datetime newdate = eventscheduleddate.addHours(1); 
                    
                    
                    {
                        Event evt = new Event ();
                        evt.Subject = 'Daily Tour';
                        evt.Event_Subject__c = 'Daily Tour';
                        evt.StartDateTime = con.Event_Scheduled_Date__c;
                        evt.EndDateTime = newdate;
                        evt.WhoId = con.Id;
                        evt.OwnerId = '0051a000000aFEJ';
                        eventlist.add(evt);  
                    }                                                 
                }
                if(con.Event_Scheduled_Date__c != null && con.RSVP_Event_Type__c =='All Access Tour')
                {
                    
                    datetime eventscheduleddate = con.Event_Scheduled_Date__c;
                    datetime newdate = eventscheduleddate.addHours(1); 
                    
                    
                    {
                        Event evt = new Event ();
                        evt.Subject = 'All Access Tour';
                        evt.StartDateTime = con.Event_Scheduled_Date__c;
                        evt.Event_Subject__c = 'All Access Tour';
                        evt.EndDateTime = newdate;
                        evt.WhoId = con.Id;
                        evt.OwnerId = '0051a000000aFEJ';
                        eventlist.add(evt);  
                    }                                                 
                }
                if(con.Event_Scheduled_Date__c != null && con.RSVP_Event_Type__c =='EB Open House')
                {
                    
                    datetime eventscheduleddate = con.Event_Scheduled_Date__c;
                    datetime newdate = eventscheduleddate.addHours(1); 
                    
                    
                    {
                        Event evt = new Event ();
                        evt.Subject = 'EB Open House';
                        evt.StartDateTime = con.Event_Scheduled_Date__c;
                        evt.Event_Subject__c = 'EB Open House';
                        evt.EndDateTime = newdate;
                        evt.WhoId = con.Id;
                        evt.OwnerId = '0051a000000aFEJ';
                        eventlist.add(evt);  
                    }                                                 
                }
                if(con.Event_Scheduled_Date__c != null && con.RSVP_Event_Type__c =='LARS Open House')
                {
                    
                    datetime eventscheduleddate = con.Event_Scheduled_Date__c;
                    datetime newdate = eventscheduleddate.addHours(1); 
                    
                    
                    {
                        Event evt = new Event ();
                        evt.Subject = 'LARS Open House';
                        evt.StartDateTime = con.Event_Scheduled_Date__c;
                        evt.Event_Subject__c = 'LARS Open House';
                        evt.EndDateTime = newdate;
                        evt.WhoId = con.Id;
                        evt.OwnerId = '0051a000000aFEJ';
                        eventlist.add(evt);  
                    }                                                 
                }
            } 
        }
        insert eventlist;
    } 
}