({
	addCBX : function(component, event, helper) {
		var nameOfabcValue=component.get("v.abc");
        if(nameOfabcValue== "true"){
          
            component.set("v.abc","false");
            
        }else{
          
            component.set("v.abc","true");
            
        }
	},
    addDetails: function(component, event, helper) {
        component.set("v.xyz","true");
        var currentEducationdetailsList= component.get("v.EducationalDetailsList");
        var currentsize=parseInt((currentEducationdetailsList.length));
          var newsize=parseInt((currentsize.length)+1);
        currentEducationdetailsList.push(newsize);
        component.set("v.EducationalDetailsList",currentEducationdetailsList);
    }
})