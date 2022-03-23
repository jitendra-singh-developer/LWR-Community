trigger AccountObjectTrigger on Account (after insert, after update) {
    
    
    if(trigger.isInsert && trigger.isAfter){
        if(TriggerDemoHelper.isTrue != True){
           TriggerDemoHelper.insertAccount();  
        }
       
    }
    
    
    
    
    
    
    
    
    
    
    /*if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            
           
            Map<Id,Id> accountIdCodeMap = new Map<Id,Id>();  
            Set<Id> eMDRIdSet = new Set<Id>();
            Map<Id,Id> tempararyCodeEMDRCodeIdMap = new Map<Id,Id>();
            Map<Id,Id> codeEMDRCodeIdMap = new Map<Id,Id>();
            List<MIR_Code_Choice__c> mIRCodeInsertList = new List<MIR_Code_Choice__c>();
            List<EMDR_Code_Choice__c> eMDRCodeInsertList = new List<EMDR_Code_Choice__c>();
            
            for(Account accountObject: trigger.new){
                accountIdCodeMap.put(accountObject.Id,accountObject.Code_Choice__c);
                eMDRIdSet.add(accountObject.Code_Choice__c);  
            }
            
            List<EMDR_Code__c> eMDRCodeList = [Select Id, Name from EMDR_Code__c Where Id IN : eMDRIdSet];
            Set<String> eMDRNameSet = new Set<String>();
            for(EMDR_Code__c eMDRCodeObject: eMDRCodeList){
                eMDRNameSet.add(eMDRCodeObject.Name);
            }
            List<Code__c> codeList = [Select Id, Name from Code__c Where Name IN : eMDRNameSet];
            Integer indexNumber = 0;
            System.debug('codeList me kya h'+ codeList);
            for(EMDR_Code__c eMDRCodeObject: eMDRCodeList){
                tempararyCodeEMDRCodeIdMap.put(eMDRCodeObject.Id, codeList[indexNumber].Id);
                IndexNumber ++;
            }
            for(Account accountObject: trigger.new){
                codeEMDRCodeIdMap.put(accountObject.Id,tempararyCodeEMDRCodeIdMap.get(accountObject.Code_Choice__c));  
            }
            List<MIR__c> MIRList = [Select Id , Account__c    from MIR__c Where Account__c IN : accountIdCodeMap.keyset() ];
            List<EMDR__c> EMDRList = [Select Id, Account__c from EMDR__c Where Account__c IN : accountIdCodeMap.keyset() ];         
            for(MIR__c MIRObject: MIRList){
                for(Integer indexNum = 1 ; indexNum < 9 ;indexNum++){
                    
                MIR_Code_Choice__c MIRCodeChoiceObject = new MIR_Code_Choice__c();
                MIRCodeChoiceObject.Code__c = codeEMDRCodeIdMap.get(MIRObject.Account__c);
                MIRCodeChoiceObject.MIR__c = MIRObject.Id;
                MIRCodeChoiceObject.Select_Code_Number__c = String.valueOf(indexNum);
                mIRCodeInsertList.add(MIRCodeChoiceObject);
             
                }
                
            }
            
            for(EMDR__c EMDRObject: EMDRList){
                 for(Integer indexNum = 1 ; indexNum < 9 ;indexNum++){
                EMDR_Code_Choice__c EMDRCodeChoiceObject = new EMDR_Code_Choice__c();
                EMDRCodeChoiceObject.EMDR_Code__c = accountIdCodeMap.get(EMDRObject.Account__c);
                                                                         
                EMDRCodeChoiceObject.Select_Code_Number__c = String.valueOf(indexNum); 
                EMDRCodeChoiceObject.EMDR__c = EMDRObject.Id;
                eMDRCodeInsertList.add(EMDRCodeChoiceObject);
                      
                }
                
            }
            
            
            if(eMDRCodeInsertList.size() > 0){
                insert eMDRCodeInsertList;
            }
            if(mIRCodeInsertList.size() > 0){
                insert mIRCodeInsertList;
            }
        }
    }*/
    
    
    
}