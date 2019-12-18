({
	deleteDetails : function(component, event, helper) {
        var NewEducationdetailsList=component.get("v.EducationaldetailsInnerCmp");
        var currentindex=component.get("v.indexNo");
        if(currentindex > -1)
		NewEducationdetailsList.splice(currentindex,1);
        component.set("v.EducationaldetailsInnerCmp",NewEducationdetailsList);
	}
})