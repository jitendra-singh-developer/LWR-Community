({
	doCreateMap : function(component, event, helper) {
		var Map = [];
        for(var i=1;i<50;i++){
            Map.push({
                key:i,
                value:'test'+i
            })
        }
        component.set('v.myMap',Map);
        
	}
})