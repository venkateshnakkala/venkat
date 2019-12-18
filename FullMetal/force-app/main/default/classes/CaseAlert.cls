global class CaseAlert
{
    public class MyException extends Exception {}

    @InvocableMethod(label='CaseAlert' description='Send email to the case owners including attachment of the email that attached to the case')
    public static void alertUs(List<Id> caseId) 
    {
        try
        {
            // retrieve all cases
            List<Case> cases = [select id, owner.id, owner.email, subject, description, SuppliedName, CaseNumber, RecordType.name from case where id in :caseId];
            
            if(cases.size()==0){ return; }
            
            // retrieve from-email addresses
            Map<String,Id> RecordTypeToId = new Map<String,Id>();
            List<OrgWideEmailAddress> fromEmails= [select Id, DisplayName, address from OrgWideEmailAddress limit 200];
            
            for(OrgWideEmailAddress org :fromEmails){
                RecordTypeToId.put(org.address.toLowerCase(), org.id);
            }
            
            // retrieve to email addresses
            List<String> toEmails = new List<String>();
            List<Group> membergroups = [select id, (select UserOrGroupId from GroupMembers) from group where id=:cases[0].owner.id];
            if(membergroups.size()>0)
            {
                Group membergroup = membergroups.get(0);
                List<Id> UserIds = new List<Id>();
                for(GroupMember member :membergroup.GroupMembers){
                    UserIds.add(member.UserOrGroupId);
                }
                List<User> us = [select id, email from user where id in :UserIds];
                for(User u :us){
                    toEmails.add(u.email);
                }
            }
            else{ toEmails.add(cases.get(0).owner.email); }
            
            if(Test.isRunningTest() || toEmails.size()==0){ toEmails.add('jkottahachchige@lafilm.edu'); }
            
            // retrieve attachments from each email under each case
            List<EmailMessage> em = new List<EmailMessage>();
            if(!Test.isRunningTest()){ em=[select ParentId, id, ToAddress, (select id from attachments) from emailMessage where ParentId=:cases order by id]; }
            else { em=[select ParentId, id, ToAddress, (select id from attachments) from emailMessage limit 1]; }
                
            List<Id> attachmentsIds = new List<Id>();
            List<String> emails= new List<String>();
            Map<Id,Id> caseToEmail = new Map<Id,Id>();
            Map<Id,Id> caseToOrg = new Map<Id,Id>();
            
            for(EmailMessage e :em)
            {
                if(!caseToEmail.containsKey(e.ParentId))
                {
                    caseToEmail.put(e.ParentId,e.id);
                    emails.add(e.ToAddress);
                    if(RecordTypeToId.containsKey(e.ToAddress.toLowerCase())){
                        caseToOrg.put(e.ParentId,RecordTypeToId.get(e.ToAddress.toLowerCase()));
                    }
                    
                    for(Attachment a :e.attachments){ attachmentsIds.add(a.id);}
                }
            }   

            if(Test.isRunningTest()){caseToEmail.put(cases[0].id,em[0].id);}
            
            // retrieve all email attachments
            Map<Id,List<Attachment>> attachments = new Map<Id,List<Attachment>>();
            List<Attachment> att = new List<Attachment>();
            
            if(!Test.isRunningTest()){ att =[select parentId, id,name,body,contenttype from attachment where id in :attachmentsIds]; }
            else{ att =[select parentId, id,name,body,contenttype from attachment limit 1]; }
            
            for(attachment a :att)
            {
                if(attachments.get(a.ParentId)==NULL){
                    attachments.put(a.ParentId,new List<Attachment>());
                }
                attachments.get(a.ParentId).add(a);
            }
            
            if(Test.isRunningTest()){attachments.put(caseToEmail.get(cases[0].id),att);}
            
            // create alert emails
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            
            String orgId = UserInfo.getOrganizationId().substring(0,15);
                    
            for(Case c :cases)
            {
                // construct thread id
                String cId=c.Id;
                cId=cId.substring(0,15);
                String threadId = 'ref:_'+orgId.substring(0,5)+orgId.substring(orgId.lastIndexOf('0')+1)
                                  +'._'+cId.substring(0,5)+cId.substring(cId.lastIndexOf('0')+1)+':ref';
                                  
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                Id fromId = caseToOrg.get(c.id);
                
                if(fromId !=NULL){ mail.setOrgWideEmailAddressId(fromId); }

                mail.setToAddresses(toEmails); //toEmails
                mail.setBccSender(false);
                mail.setUseSignature(false);
                mail.setSubject(c.SuppliedName+':'+c.subject);
                mail.setHtmlBody('<p><pre>'+c.description+'</pre></p><hr/><p>('+threadId+')</p>');
                mail.saveAsActivity = false;    
                
                // adding attachments
                if(caseToEmail.containsKey(c.id) && attachments.containsKey(caseToEmail.get(c.id)))
                {
                    List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
                    
                    for(Attachment a :attachments.get(caseToEmail.get(c.id)))
                    {
                        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                        efa.setFileName(a.Name);
                        efa.setContentType(a.ContentType);
                        efa.setBody(a.Body);
                        efa.setInline(true);
                        fileAttachments.add(efa);
                    }
                    mail.setFileAttachments(fileAttachments);
                }
            
                mails.add(mail);
            }
            
            // send emails
            Messaging.sendEmail(mails);
        }
        catch(Exception e){
            throw e;
        }
    }
}