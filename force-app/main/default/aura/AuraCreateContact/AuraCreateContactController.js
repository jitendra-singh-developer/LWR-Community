({
	createContact : function(component, event, helper) {
        console.log('button click');
		var action = component.get('c.createContactServer');
        action.setParams({
            contactMap : component.get('v.contactMap'),
            recordId : component.get('v.recordId'),
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            alert(state);
        } );
        $A.enqueueAction(action);
     
    
	}
})