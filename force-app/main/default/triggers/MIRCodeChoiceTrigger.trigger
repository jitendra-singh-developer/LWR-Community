trigger MIRCodeChoiceTrigger on MIR_Code_Choice__c (after insert, after update, after delete) {
    
    
    
    if(trigger.isAfter){
        
        if(trigger.isInsert){
            Map<Id,MIR__c> mIRUpdateMap = new Map<Id,MIR__c>();
            
            Set<Id> MIRIdSet = new Set<Id>();
            Set<Id> codeIdSet = new Set<Id>();
            for(MIR_Code_Choice__c MIRCodeObject: trigger.new){
                MIRIdSet.add(MIRCodeObject.MIR__c);
                codeIdSet.add(MIRCodeObject.Code__c);
            }
            
            Map<Id,Code__c> codeMap = new Map<Id,Code__c>([Select Id, Name FROM Code__c Where Id IN : codeIdSet]);
            
            
            for(MIR_Code_Choice__c MIRCodeObject: trigger.new){
                MIR__c MIRObject = new MIR__c();
                MIRObject.Id = MIRCodeObject.MIR__c;
                if(MIRCodeObject.Select_Code_Number__c == '1'){
                    MIRObject.Code_1__c = codeMap.get(MIRCodeObject.Code__c).Name;   
                }else if(MIRCodeObject.Select_Code_Number__c == '2'){
                    MIRObject.Code_2__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '3'){
                    MIRObject.Code_3__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '4'){
                    MIRObject.Code_4__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '5'){
                    MIRObject.Code1_1__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '6'){
                    MIRObject.Code1_2__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '7'){
                    MIRObject.Code1_3__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '8'){
                    MIRObject.Code1_4__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }
                
               
                    System.debug('ooooooooo'+ MIRObject);
                    //   System.assert(mIRUpdateMap.containskey(MIRObject.ID));
                    MIR__c tempMIRObject = new MIR__c();
                    tempMIRObject = mIRUpdateMap.get(MIRObject.Id);
                    System.debug('tmepMIRObject'+ tempMIRObject);
                    if(mIRUpdateMap.containskey(MIRObject.ID)){
                        System.debug('yyyyyyyyy');
							 if(MIRCodeObject.Select_Code_Number__c == '2'){
                            tempMIRObject.Code_2__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '3'){
                            tempMIRObject.Code_3__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '4'){
                            tempMIRObject.Code_4__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '5'){
                            tempMIRObject.Code1_1__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '6'){
                            tempMIRObject.Code1_2__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '7'){
                            tempMIRObject.Code1_3__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '8'){
                            tempMIRObject.Code1_4__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }
                        
                        mIRUpdateMap.put(tempMIRObject.Id,tempMIRObject);
                    }else{
                        mIRUpdateMap.put(MIRObject.Id,MIRObject);
                    }
            
                }
                
                
                
			 if(mIRUpdateMap.values().size() > 0){
                Update mIRUpdateMap.values() ;  
            }                
                
                
            }
           
            
        }
        
        if(trigger.IsUpdate){
            
            Map<Id,MIR__c> mIRUpdateMap = new Map<Id,MIR__c>();
            System.debug('what is in '+ trigger.new);
            Set<Id> MIRIdSet = new Set<Id>();
            Set<Id> codeIdSet = new Set<Id>();
            for(MIR_Code_Choice__c MIRCodeObject: trigger.new){
                MIRIdSet.add(MIRCodeObject.MIR__c);
                codeIdSet.add(MIRCodeObject.Code__c);
            }
            System.debug('EIds'+ MIRIdSet);
            System.debug('EIds'+ codeIdSet);
            Map<Id,Code__c> codeMap = new Map<Id,Code__c>([Select Id, Name FROM Code__c Where Id IN : codeIdSet]);
            System.debug('map1111'+ codeMap);
            
            for(MIR_Code_Choice__c MIRCodeObject: trigger.new){
                MIR__c MIRObject = new MIR__c();
                MIRObject.Id = MIRCodeObject.MIR__c;
                if(MIRCodeObject.Select_Code_Number__c == '1'){
                    MIRObject.Code_1__c = codeMap.get(MIRCodeObject.Code__c).Name;   
                }else if(MIRCodeObject.Select_Code_Number__c == '2'){
                    MIRObject.Code_2__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '3'){
                    MIRObject.Code_3__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '4'){
                    MIRObject.Code_4__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '5'){
                    MIRObject.Code1_1__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '6'){
                    MIRObject.Code1_2__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '7'){
                    MIRObject.Code1_3__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }else if(MIRCodeObject.Select_Code_Number__c == '8'){
                    MIRObject.Code1_4__c = codeMap.get(MIRCodeObject.Code__c).Name;
                }
                
                
                    MIR__c tempMIRObject = mIRUpdateMap.get(MIRObject.Id);
                    if(mIRUpdateMap.containskey(MIRObject.ID)){
                        system.debug('OOOOOOOOoooooo');
                        if(MIRCodeObject.Select_Code_Number__c == '2'){
                            tempMIRObject.Code_2__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '3'){
                            tempMIRObject.Code_3__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '4'){
                            tempMIRObject.Code_4__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '5'){
                            tempMIRObject.Code1_1__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '6'){
                            tempMIRObject.Code1_2__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '7'){
                            tempMIRObject.Code1_3__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }else if(MIRCodeObject.Select_Code_Number__c == '8'){
                            tempMIRObject.Code1_4__c = codeMap.get(MIRCodeObject.Code__c).Name;
                        }
                          mIRUpdateMap.put(tempMIRObject.Id,tempMIRObject);
                    }
                    else{
                          mIRUpdateMap.put(MIRObject.Id,MIRObject);
                    }
                    
                
                
                
                
              
            }
            if(mIRUpdateMap.values().size() > 0){
                Update mIRUpdateMap.values() ;  
            }
            
        }
        
        
        
        if(trigger.IsDelete){
            
            system.debug('kya values1 new'+ trigger.new);
            
            system.debug('kya values1 old'+ trigger.old);
            Map<Id,MIR__c> mIRUpdateMap = new Map<Id,MIR__c>();
            for(MIR_Code_Choice__c mIRCodeChoiceObject: trigger.old){
                MIR__c mIRObject = new MIR__c();
                mIRObject.Id = mIRCodeChoiceObject.MIR__c;
                if(mIRCodeChoiceObject.Select_Code_Number__c == '1'){
                    mIRObject.Code_1__c = '';   
                }else if(mIRCodeChoiceObject.Select_Code_Number__c == '2'){
                    mIRObject.Code_2__c = '';
                }else if(mIRCodeChoiceObject.Select_Code_Number__c == '3'){
                    mIRObject.Code_3__c = '';
                }else if(mIRCodeChoiceObject.Select_Code_Number__c == '4'){
                    mIRObject.Code_4__c = '';
                }else if(mIRCodeChoiceObject.Select_Code_Number__c == '5'){
                    mIRObject.Code1_1__c = '';
                }else if(mIRCodeChoiceObject.Select_Code_Number__c == '6'){
                    mIRObject.Code1_2__c = '';
                }else if(mIRCodeChoiceObject.Select_Code_Number__c == '7'){
                    mIRObject.Code1_3__c = '';
                }else if(mIRCodeChoiceObject.Select_Code_Number__c == '8'){
                    mIRObject.Code1_4__c = '';
                }
                
                mIRUpdateMap.put(mIRObject.Id,mIRObject);
            }
            if(mIRUpdateMap.values().size() > 0){
                update mIRUpdateMap.values();
            }
        }
        
    }