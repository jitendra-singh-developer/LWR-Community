({
		showContacts : function(component, event, helper) {
		var action = component.get('c.getContacts');
                action.setParams({
                accountId : component.get('v.recordId'),
            });
       	$A.enqueueAction(action,false);  
        
        action.setCallback(this,function(response){
                            var responseValue = response.getReturnValue();
            				console.log('See value'+ responseValue );
        					component.set('v.contactList',responseValue);
                           });
  
        
        },
    	
    sContact : function(component, event, helper){
    	var eventSource = event.getSource();
        var Id = eventSource.get('v.name');
        //alert(Id);
        var navEvt = $A.get('e.force:navigateToSObject');
        navEvt.setParams({
            'recordId':Id,
            'slideDevName':'detail',
        });
        navEvt.fire();
    
	}
    
	
})