public class UpdateEchosignpermissionsetController
{
  @future
  public static void UpdateEchosignpermissionset(Set<id> UserIds) 
  {
     try{
      List<PermissionSetAssignment> permasglist = New List<PermissionSetAssignment>();
      List<User> userlist = [Select Id,Name,ProfileId from User where Id IN :UserIds];
      PermissionSet  permset = [SELECT Id,Name FROM PermissionSet where Name = 'Adobe_Sign_Integration_User'];
      Profile pr = [SELECT Id,NAme FROM Profile where Name = 'Application User'];
      for(User us : userlist){
          if(us.ProfileId == pr.Id){
              PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = permset.Id, AssigneeId = us.Id);
              permasglist.add(psa);
            }  
     }
      insert permasglist;
   }catch(exception e){
        system.debug('exception caught' + e);
    }
  }
}