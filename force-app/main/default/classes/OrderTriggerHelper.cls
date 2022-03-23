/*
Name        : OrderTriggerHelper
Date        : 31 March, 2021
Author      : Jitendra Singh
Description : This is AmountOrderTrigger helper class used to calculate order Amount and
store it in according to there related Account feild.
*/
public class OrderTriggerHelper {
    
    
    public static void opportunityOrderValidation(Map<Id,Order> opportunityMap){
        
        
        Map<ID,Schema.RecordTypeInfo> recordTypeMap = Order.sObjectType.getDescribe().getRecordTypeInfosById();
        List<Order> orderList = [select Id, order.OpportunityId, order.RecordTypeId 
                                 from order 
                                 where order.OpportunityId IN : opportunityMap.keyset() ];
        
        if(orderList.size() > 0 && !orderList.isEmpty()){
            for(order orderObject: orderList){
                
                Order orderObj = opportunityMap.get(orderObject.OpportunityId);
                Schema.RecordTypeInfo newOrderRecord = recordTypeMap.get(orderObj.RecordTypeId);
                Schema.RecordTypeInfo oldOrderRecord = recordTypeMap.get(orderObject.RecordTypeId);
                if(newOrderRecord.getName() == oldOrderRecord.getName()){
                    orderObj.addError(' One Order Already Exists With This '+newOrderRecord.getName()+' Record Type');
                }
                
            }
        }
    }
    
    //This function is use to update accounts related to their order.
    public static void updateAccounts(set<Id> accountIds){
        
        List<Account> accountList = new List<Account>(); 
        
        //Through this iteration i assign total order amount in account field and for total order amount i use AggeregateResult .
        for(AggregateResult aggregateObject: [SELECT AccountId, sum(Amount__c) totalSum
                                              FROM Order  
                                              WHERE AccountId IN : accountIds 
                                              Group by AccountId]){        
                                                  // Account accountObject = new Account(); 
                                                  // accountObject.Id = (Id) aggregateObject.get('AccountId');
                                                  // accountObject.Total_Order_Amount__c = (Decimal) aggregateObject.get('totalSum');
                                                  // accountList.add(accountObject); 
                                                  accountList.add(new Account(Id = (Id) aggregateObject.get('AccountId'),Total_Order_Amount__c = (Decimal) aggregateObject.get('totalSum')));
                                              }
        //It check the size of accountList before performing update statement.
        if(accountList.size() > 0 && !accountList.isEmpty()){
            
            update accountList;
        }        
    }
    
    // When a order is updated then their relative account will changed .
    public static void updateAccountField(Set<Id> accountIds){
        List<Account> accountUpdateList = new List<Account>();
        for(AggregateResult aggregateObject: [SELECT AccountId, max(Order_Activate_Date__c) maxDate 
                                              FROM Order WHERE AccountId IN : accountIds Group by AccountId]){
                                                  
                                                  accountUpdateList.add(new Account(Id = (Id)aggregateObject.get('AccountId'),Last_Order_Activate_Date__c =(Date)aggregateObject.get('maxDate')));  
                                              }
        if(accountUpdateList.size() > 0 && !accountUpdateList.isEmpty()){
            update accountUpdateList;
        }  
    }
    // When any order is deleted for Database is this method is remove that order amount from Amount's Total order Amount field.
    public static void deletedOrders(Set<Id> accountIds, List<Order> orderList ){
        
        Map<Id,Account> accountMap = new Map<Id,Account>([SELECT Id, Total_Order_Amount__c 
                                                          FROM Account WHERE Id IN : accountIds]);
        List<Account> accountList = new List<Account>();
        for(Order orderObject : orderList){
            Account accountObject = new Account();
            if(orderObject.Amount__c != null){
                accountObject = accountMap.get(orderObject.AccountId) ;
                //Total order amount should not be null or Zero otherwise it gives us error.
                if(accountObject.Total_Order_Amount__c != null || accountObject.Total_Order_Amount__c == 0){
                    accountObject.Total_Order_Amount__c = accountObject.Total_Order_Amount__c - orderObject.Amount__c;
                    accountList.add(accountObject); 
                } 
            }  
        } 
        //And lastly i checked the size of accountList or it's null of not before update.
        if(accountList.size() > 0 && !accountList.isEmpty()){
            update accountList;   
        } 
    } 
    
    public static void createNewCreditMemoTypeRecord(List<Order> orderList){ 
        List<Order> insertOrders = new List<Order>();
        RecordType recordTypeObj = [Select Id, Name from RecordType Where Name = 'Credit Memo'];
		Map<String, Order_Metadata__mdt> orderMetadataList = Order_Metadata__mdt.getAll();
        for(Order orderObj: orderList){
            Order orderObject = new Order();
            for(Order_Metadata__mdt orderMetaRecord: orderMetadataList.values()){
                orderObject.put(orderMetaRecord.Label, orderObj.get(String.valueOf(orderMetaRecord.Label)) );
            }
    		orderObject.RecordTypeId = recordTypeObj.Id;
            insertOrders.add(orderObject); 
        }
        if(insertOrders.size() > 0){
           
           insert insertOrders;
        }  
    }
}