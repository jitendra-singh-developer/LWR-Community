trigger CodeTrigger on Code__c (After Insert, After Update) {
    
    if( EMDRCodeTriggerHandler.isStop){
        EMDRCodeTriggerHandler.isStop = false;  
        if(trigger.isAfter){
            if(trigger.isInsert){
                List<EMDR_Code__c> EMDRInsertList = new List<EMDR_Code__c>();
                for(Code__c codeObject : trigger.new){
                    EMDR_Code__c EMDRObject = new EMDR_Code__c();
                    EMDRObject.IsActive__c = codeObject.IsActive__c;
                    EMDRObject.Name = codeObject.Name;
                    EMDRObject.Select_Section__c = codeObject.Select_Section__c;
                    EMDRInsertList.add(EMDRObject);
                }  
                System.debug('EMDRInsertList'+ EMDRInsertList);
                Insert EMDRInsertList;
            }
            
            if(trigger.isUpdate){
                List<EMDR_Code__c> EMDRUpdateList = new List<EMDR_Code__c>();
                Set<String> codeNameSet = new Set<String>();
                for(Code__c codeObject : trigger.old){
                    codeNameSet.add(codeObject.Name);
                }
                System.debug('codeNameSet'+ codeNameSet);
                Map<String,Id> EMDRCodeMap = new Map<String,Id>();
                List<EMDR_Code__c> EMDRCodeList = [Select Id, Name, isActive__c, Select_Section__c from EMDR_Code__c Where Name IN : codeNameSet];
                System.debug('EMDRCodeList'+ EMDRCodeList);
                for(EMDR_Code__c EMDRCodeObject: EMDRCodeList){
                    
                    EMDRCodeMap.put(EMDRCodeObject.Name,EMDRCodeObject.Id);
                    
                }
                for(Code__c codeObject: trigger.new){
                    
                    EMDR_Code__c EMDRObject = new EMDR_Code__c();
                    EMDRObject.Id = EMDRCodeMap.get(trigger.oldMap.get(codeObject.Id).Name);
                    System.debug('EMDRCodeMap.get(codeObject.Name)'+EMDRCodeMap.get(trigger.oldMap.get(codeObject.Id).Name));
                    EMDRObject.IsActive__c = codeObject.IsActive__c;
                    EMDRObject.Name = codeObject.Name;
                    EMDRObject.Select_Section__c = codeObject.Select_Section__c;
                    EMDRUpdateList.add(EMDRObject);
                    
                }
                update EMDRUpdateList;
                
            }
            
            
            
            
        } 
        
    }
    
    
}