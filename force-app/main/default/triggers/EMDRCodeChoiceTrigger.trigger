trigger EMDRCodeChoiceTrigger on EMDR_Code_Choice__c (after insert, after update, before delete, after delete) {
	
   
        
        if(trigger.isAfter){
            
             if(trigger.isInsert
               
               
               ){
                  Map<Id,EMDR__c> EMDRUpdateMap = new Map<Id,EMDR__c>();
                 System.debug('what is in '+ trigger.new);
                 Set<Id> EMDRIdSet = new Set<Id>();
                 Set<Id> EMDRCodeIdSet = new Set<Id>();
                 for(EMDR_Code_Choice__c EMDRCodeObject: trigger.new){
                 	EMDRIdSet.add(EMDRCodeObject.EMDR__c);
                    EMDRCodeIdSet.add(EMDRCodeObject.EMDR_Code__c);
                 }
               
                 Map<Id,EMDR_Code__c> EMDRCodeMap = new Map<Id,EMDR_Code__c>([Select Id, Name FROM EMDR_Code__c Where Id IN : EMDRCodeIdSet]);
         
                 
                 
                  for(EMDR_Code_Choice__c EMDRCodeObject: trigger.new){
                      
                 	   EMDR__c EMDRObject = new EMDR__c();
                       EMDRObject.Id = EMDRCodeObject.EMDR__c;
                      if(EMDRCodeObject.Select_Code_Number__c == '1'){
                           EMDRObject.Code_1__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name;
                      }else if(EMDRCodeObject.Select_Code_Number__c == '2'){
                           EMDRObject.Code_2__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '3'){
                           EMDRObject.Code_3__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '4'){
                           EMDRObject.Code_4__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '5'){
                           EMDRObject.Code1_1__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '6'){
                           EMDRObject.Code1_2__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '7'){
                           EMDRObject.Code1_3__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '8'){
                           EMDRObject.Code1_4__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }
                
                         
                    if(EMDRUpdateMap.containskey(EMDRObject.ID)){
                        system.debug('OOOOOOOOoooooo');
                        if(EMDRCodeObject.Select_Code_Number__c == '2'){
                            EMDRUpdateMap.get(EMDRObject.Id).Code_2__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name;
                        }else if(EMDRCodeObject.Select_Code_Number__c == '3'){
                            EMDRUpdateMap.get(EMDRObject.Id).Code_3__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name;
                        }else if(EMDRCodeObject.Select_Code_Number__c == '4'){
                            EMDRUpdateMap.get(EMDRObject.Id).Code_4__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name;
                        }else if(EMDRCodeObject.Select_Code_Number__c == '5'){
                            EMDRUpdateMap.get(EMDRObject.Id).Code1_1__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name;
                        }else if(EMDRCodeObject.Select_Code_Number__c == '6'){
                            EMDRUpdateMap.get(EMDRObject.Id).Code1_2__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name;
                        }else if(EMDRCodeObject.Select_Code_Number__c == '7'){
                            EMDRUpdateMap.get(EMDRObject.Id).Code1_3__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name;
                        }else if(EMDRCodeObject.Select_Code_Number__c == '8'){
                            EMDRUpdateMap.get(EMDRObject.Id).Code1_4__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name;
                        }
                          EMDRUpdateMap.put(EMDRUpdateMap.get(EMDRObject.Id).Id,EMDRUpdateMap.get(EMDRObject.Id));
                    }
                    else{
                              
                      EMDRUpdateMap.put(EMDRObject.Id,EMDRObject);
                    }
                    
                      	
              
                 }
                   If(EMDRUpdateMap.values().size() > 0){
                     
                     System.debug('List'+ EMDRUpdateMap.values());
                     update EMDRUpdateMap.values();
                 }
           
                 	
             }
            
            if(trigger.IsUpdate){
                
                Map<Id,EMDR__c> EMDRUpdateMap = new Map<Id,EMDR__c>();
         
                 Set<Id> EMDRIdSet = new Set<Id>();
                 Set<Id> EMDRCodeIdSet = new Set<Id>();
                 for(EMDR_Code_Choice__c EMDRCodeObject: trigger.new){
                 	EMDRIdSet.add(EMDRCodeObject.EMDR__c);
                    EMDRCodeIdSet.add(EMDRCodeObject.EMDR_Code__c);
                 }
             
                 Map<Id,EMDR_Code__c> EMDRCodeMap = new Map<Id,EMDR_Code__c>([Select Id, Name FROM EMDR_Code__c Where Id IN : EMDRCodeIdSet]);
      
                 
                 
                 
                  for(EMDR_Code_Choice__c EMDRCodeObject: trigger.new){
                      // System.debug('Trigger.new object'+ EMDRCodeObject);
                 	   EMDR__c EMDRObject = new EMDR__c();
                       EMDRObject.Id = EMDRCodeObject.EMDR__c;
                      
                      
                      
                      if(EMDRCodeObject.Select_Code_Number__c == '1'){
                           EMDRObject.Code_1__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name;
                      }else if(EMDRCodeObject.Select_Code_Number__c == '2'){
                           EMDRObject.Code_2__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '3'){
                           EMDRObject.Code_3__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '4'){
                           EMDRObject.Code_4__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '5'){
                           EMDRObject.Code1_1__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '6'){
                           EMDRObject.Code1_2__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '7'){
                           EMDRObject.Code1_3__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }else if(EMDRCodeObject.Select_Code_Number__c == '8'){
                           EMDRObject.Code1_4__c = EMDRCodeMap.get(EMDRCodeObject.EMDR_Code__c).Name; 
                      }
                     	EMDRUpdateMap.put(EMDRObject.Id,EMDRObject);
                      
                      
                      
                      	
              
                 }
                 If(EMDRUpdateMap.values().size() > 0){
                     
                     System.debug('List'+ EMDRUpdateMap.values());
                     update EMDRUpdateMap.values();
                 }
           
                
                
                
                
                
            }
            
             if(trigger.IsDelete){
            
            system.debug('kya values1 new'+ trigger.new);
            
            system.debug('kya values1 old'+ trigger.old);
                 Map<Id,EMDR__c> eMDRUpdateMap = new Map<Id,EMDR__c>();
                 for(EMDR_Code_Choice__c eMDRCodeChoiceObject: trigger.old){
                     EMDR__c EMDRObject = new EMDR__c();
                     EMDRObject.Id = eMDRCodeChoiceObject.EMDR__c;
                     if(eMDRCodeChoiceObject.Select_Code_Number__c == '1'){
                           EMDRObject.Code_1__c = '';
 
                      }else if(eMDRCodeChoiceObject.Select_Code_Number__c == '2'){
                           EMDRObject.Code_2__c = ''; 
                      }else if(eMDRCodeChoiceObject.Select_Code_Number__c == '3'){
                           EMDRObject.Code_3__c = ''; 
                      }else if(eMDRCodeChoiceObject.Select_Code_Number__c == '4'){
                           EMDRObject.Code_4__c = ''; 
                      }else if(eMDRCodeChoiceObject.Select_Code_Number__c == '5'){
                           EMDRObject.Code1_1__c =''; 
                      }else if(eMDRCodeChoiceObject.Select_Code_Number__c == '6'){
                           EMDRObject.Code1_2__c = ''; 
                      }else if(eMDRCodeChoiceObject.Select_Code_Number__c == '7'){
                           EMDRObject.Code1_3__c = ''; 
                      }else if(eMDRCodeChoiceObject.Select_Code_Number__c == '8'){
                           EMDRObject.Code1_4__c = ''; 
                      }
                                      
                    
                       eMDRUpdateMap.put(EMDRObject.Id,EMDRObject);
                 }
                 if(eMDRUpdateMap.values().size() > 0){
                   update eMDRUpdateMap.values();
                 }
                }
            
            
            
        }
    	  
}