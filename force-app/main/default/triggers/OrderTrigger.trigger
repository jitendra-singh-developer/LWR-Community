trigger OrderTrigger on Order (after update ) {
    
    set<Id> accountIds = new set<Id>();
    List<Order> activatedOrderList = new List<Order>();
    List<Order> draftOrderList = new List<Order>();
    
    if(trigger.isBefore){
      if(trigger.isInsert){
    
          Map<Id,Order> opportunityMap = new Map<Id,Order>();
          for(order orderObject: trigger.new){
              opportunityMap.put(orderObject.OpportunityId,orderObject);
             
          }
          if(opportunityMap.size() > 0 && !opportunityMap.isEmpty()){
            OrderTriggerHelper.opportunityOrderValidation(opportunityMap);
          }
      }
      if(trigger.isUpdate){
        
        for(Order order : trigger.new){
       
          if((order.Status == 'Activated') && (trigger.oldMap.get(order.id).Status != order.Status)){
                order.Order_Activate_Date__c = System.today();
          }
          if((order.Status == 'Draft') && (trigger.oldMap.get(order.id).Status != order.Status)){
              order.Order_Activate_Date__c = null;
          }      
        }
       
      }
    } 
    if(trigger.isAfter){

      if(trigger.isInsert){

        for(Order order : trigger.new){
            if(order.AccountId != null){
               accountIds.add(order.AccountId);
            }
        }
        if(accountIds.size() > 0 ){
            OrderTriggerHelper.updateAccounts(accountIds);  
        }
      }

      if(trigger.isUpdate){
        Set<Id> activatedAccountIds = new Set<Id>();
        for(Order order : trigger.new){
           if(order.AccountId != null && order.Amount__c != trigger.oldMap.get(order.id).Amount__c ){
              accountIds.add(order.AccountId); 
            }
            if(order.Status == 'Activated' && trigger.oldMap.get(order.Id).Status != order.Status){
              activatedAccountIds.add(order.AccountId);
            }
        }
       if(accountIds.size() > 0 ){
        OrderTriggerHelper.updateAccounts(accountIds);
       }
       if(activatedAccountIds.size() > 0){
        OrderTriggerHelper.updateAccountField(activatedAccountIds);
       }
          OrderTriggerHelper.createNewCreditMemoTypeRecord(Trigger.new);
    }
    if(trigger.isDelete ){
       for(Order order : trigger.old){
          if(order.AccountId != null){
            accountIds.add(order.AccountId); 
          }      
       }
       OrderTriggerHelper.deletedOrders(accountIds,trigger.old);        
    } 
  }
  
}