trigger OpportunityTrigger on Opportunity (before insert , after update) {
    
    List<Account> accountList = new List<Account>();
    List<Opportunity> opportunityList = trigger.new ;
    Map<Id,Account>  AccMap = new Map<Id,Account>([select Id , Account_Type__c  from Account]);
    
    
    if(Trigger.isInsert){
        
        
        
        for(Opportunity opp : opportunityList)
        {
            Account acc=  AccMap.get(opp.AccountId);
            if(acc.Account_Type__c  == null  ){   
                opp.Stage_Type__c = '0';   
            }
            else  if(acc.Account_Type__c == 'Reseller' ){    
                opp.Stage_Type__c = '10';  
            }
            else  if(acc.Account_Type__c == 'Buyer' ){   
                opp.Stage_Type__c = '25';   
            }
            else  if(acc.Account_Type__c == 'Current Customer' ){    
                opp.Stage_Type__c = '100';    
            } 
        }
        
        
        
        
    }
    
    if(Trigger.isUpdate)
    {
        
        
        for(Opportunity opp : opportunityList){
            
            Account acc =  AccMap.get(opp.AccountId);
            
            system.debug('update is called');
            if( (opp.Stage_Type__c == '0' || opp.Stage_Type__c == '10')  ){   
                acc.Account_Type__c = 'Reseller';  
            }
            else  if(opp.Stage_Type__c == '25'  ){    
                acc.Account_Type__c = 'Buyer'; 
            }
            else  if(opp.Stage_Type__c == '100'  ){   
                acc.Account_Type__c = 'Current Customer' ;  
            }
            
            accountList.add(acc);
            
        }
        
        
        if(!AccountOppController.ischecked){
            AccountOppController.ischecked = true;
            
          //  update accountList;
            
            
        }
        
        
        
    }
    
    
    
}