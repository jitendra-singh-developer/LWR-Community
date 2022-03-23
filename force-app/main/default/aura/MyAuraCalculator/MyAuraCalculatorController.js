({
	handleAdd : function(component, event, helper) {
         var NumA = component.get('v.NumberA');
         var NumB = component.get('v.NumberB');
        // alert(parseInt(NumA) + parseInt(NumB));
        component.set('v.Result',parseInt(NumA) + parseInt(NumB));
   
	},
    handleSub : function(component, event, helper) {
         var NumA = component.get('v.NumberA');
         var NumB = component.get('v.NumberB');
        // alert(parseInt(NumA) - parseInt(NumB));
         component.set('v.Result',parseInt(NumA) - parseInt(NumB));
   
	},
    handleMulti : function(component, event, helper) {
         var NumA = component.get('v.NumberA');
         var NumB = component.get('v.NumberB');
         component.set('v.Result',parseInt(NumA) * parseInt(NumB));
       //  alert(parseInt(NumA) * parseInt(NumB));
   
	},
    handleDivision : function(component, event, helper) {
         var NumA = component.get('v.NumberA');
         var NumB = component.get('v.NumberB');
         component.set('v.Result',parseInt(NumA) / parseInt(NumB));
       //  alert(parseInt(NumA) / parseInt(NumB));
   
	}
})