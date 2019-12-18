trigger ContactUpdateCodesTrigger on Contact (before insert, before update) {
    
    
    for (Contact con : trigger.new){
        
        ContactUtilities.setAffliationCodes(con);
        ContactUtilities.setCitizenshipCodes(con);
        ContactUtilities.setGenderCodes(con);
        ContactUtilities.setLeadSourceCode(con);
        ContactUtilities.setMaritalCodes(con);
        ContactUtilities.setNationalityCodes(con);
        ContactUtilities.setPreviousEducationCodes(con);
        ContactUtilities.setRaceCodes(con);
        ContactUtilities.setSchoolStatusCodes(con);
        
        
    }             
}