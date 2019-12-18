trigger UpdateEchosignpermissionset on User (after insert) {
    Set<Id> userIds = New Set<Id>();
    for(User us : Trigger.new)
    {
       userIds.add(us.id); 
    }
    UpdateEchosignpermissionsetController.UpdateEchosignpermissionset(userIds);
}