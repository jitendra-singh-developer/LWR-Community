trigger AccountTrigger on Account (after update) {
    
    
   Map<Id,Account> accountMap = New Map<Id,Account>(trigger.New) ;
   List<Opportunity> opportunityList = new List<Opportunity>( [select id,Name,Stage_Type__c,AccountId from Opportunity where accountId In : accountMap.keySet() ]);
  
  
    
    for(Opportunity opp : opportunityList )
    {       
         Account accObj = accountMap.get(opp.AccountId);
            
            System.debug('hihihihihi'+ accObj.Account_Type__c);
            if(accObj.Account_Type__c == ''){
                
                opp.Stage_Type__c = '0';
                
            }
            else if(accObj.Account_Type__c == 'Reseller' ){
                
                opp.Stage_Type__c = '10';
                
            }
            else if(accObj.Account_Type__c == 'Buyer' ){
                
                opp.Stage_Type__c = '25';
                
            }
            else if(accObj.Account_Type__c == 'Current Customer' ){
                
                opp.Stage_Type__c = '100';
                
            }  
            
            
        
        
    }
    
    
  

    

        AccountOppController.ischecked = true;
      //  update opportunityList; 
        
    
  
   
        
    
}