({
	init : function(component, event, helper) {
        console.log("HERE");
        
        
        var workspaceAPI = component.find("workspace");
workspaceAPI.openTab({
recordId: '5001a00000bKdoXAAS',
focus: true
}).then(function(response) {
workspaceAPI.getTabInfo({
tabId: response
}).then(function(tabInfo) {
console.log("The url for this tab is: " + tabInfo.url);
});
})
.catch(function(error) {
console.log(error);
});
        console.log("DONE");
	}
})