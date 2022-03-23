trigger EMDRCodeTrigger on EMDR_Code__c (After Insert, After Update) {
	
   
    if(EMDRCodeTriggerHandler.isStop){
         EMDRCodeTriggerHandler.isStop = false;
         if(trigger.isAfter){
        if(trigger.isInsert){
            List<Code__c> codeInsertList = new List<Code__c>();
            for(EMDR_Code__c EMDRCodeObject : trigger.new){
                Code__c codeObject = new Code__c();
                codeObject.IsActive__c = EMDRCodeObject.IsActive__c;
                codeObject.Name = EMDRCodeObject.Name;
                codeObject.Select_Section__c = EMDRCodeObject.Select_Section__c;
                codeInsertList.add(codeObject);
            }  
            System.debug('EMDRInsertList'+ codeInsertList);
            Insert codeInsertList;
        }
        
        if(trigger.isUpdate){
            List<Code__c> codeUpdateList = new List<Code__c>();
            Set<String> codeNameSet = new Set<String>();
            for(EMDR_Code__c EMDRCodeObject : trigger.old){
                codeNameSet.add(EMDRCodeObject.Name);
            }
            System.debug('codeNameSet'+ codeNameSet);
            Map<String,Id> EMDRCodeMap = new Map<String,Id>();
            List<Code__c> codeList = [Select Id, Name, isActive__c, Select_Section__c from Code__c Where Name IN : codeNameSet];
            System.debug('EMDRCodeList'+ codeList);
            for(Code__c codeObject: codeList){
        	     
                EMDRCodeMap.put(codeObject.Name,codeObject.Id);
		    	            
            }
            for(EMDR_Code__c eMDRCodeObject: trigger.new){
                
                Code__c codeObject = new Code__c();
                codeObject.Id = EMDRCodeMap.get(trigger.oldMap.get(eMDRCodeObject.Id).Name);
              //  System.debug('EMDRCodeMap.get(codeObject.Name)'+EMDRCodeMap.get(trigger.oldMap.get(eMDRCodeObject.Id).Name));
                codeObject.IsActive__c = eMDRCodeObject.IsActive__c;
                codeObject.Name = eMDRCodeObject.Name;
                codeObject.Select_Section__c = eMDRCodeObject.Select_Section__c;
                codeUpdateList.add(codeObject);
                
            }
            update codeUpdateList;
            
        }
    }
      
    }
   

}