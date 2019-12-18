trigger QuiqPRODUCTIONSetAssignee on Task (before insert) {
    Id quiqRecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Quiq').getRecordTypeId();
  for (Task t : Trigger.new) {
    if(t.RecordTypeId == quiqRecordTypeId) {
      List<User> possibleOwnerList = [SELECT Id FROM User WHERE QuiqContactPoint__c = :t.QuiqContactPoint__c AND IsActive=true];

      if (possibleOwnerList.size() > 0) {
          User properOwner = possibleOwnerList[0];
          if (properOwner != null)
              t.OwnerId = properOwner.Id;
      }

    }
  }
}