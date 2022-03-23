trigger OpportunityLineItemTrigger on OpportunityLineItem (After insert) {
	
    Set<Id> oppoIds = new Set<Id>();
    for(OpportunityLineItem oli: trigger.new){
        oppoIds.add(oli.OpportunityId);
    }
}