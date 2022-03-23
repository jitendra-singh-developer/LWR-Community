public  class CodesUpdateController {
    
    @AuraEnabled(cacheable=true)
    public static List<Code__c> fetchCodes(){
        return [Select Id, Name, Select_Section__c , isActive__c from Code__c Where isActive__c = : true ];
    }
    
    @AuraEnabled
    public static List<SObject> fetchObjectList(String objectName , Id recordId){
        if(objectName == 'MIR__c'){
            return [select Id, Name, Account__c , Code_1__c, Code_2__c , Code_3__c, Code_4__c, Code1_1__c, Code1_2__c, Code1_3__c, Code1_4__c from MIR__c Where Account__c = : recordId];
            
        }else {
            return [select Id, Name, Account__c , Code_1__c, Code_2__c , Code_3__c, Code_4__c, Code1_1__c, Code1_2__c, Code1_3__c, Code1_4__c from EMDR__c Where Account__c = : recordId];
        } 
    }
    
    @AuraEnabled
    public static string updateCodeRecords(List<SObject> recordList , String recordDetails){
        String message = 'success';
        System.debug('recordList'+ recordList);
        System.debug('recordDetails'+ recordDetails);
        Map<String,String> codeMap = new Map<String,String>();
        codeMap = convertStringToMap(recordDetails);
        System.debug('codeMap1'+ codeMap);
        List<MIR__c> MIRUpdateList = new List<MIR__c>();
        List<EMDR__c> EMDRUpdateList = new List<EMDR__c>();
        if(recordList.size() > 0){

            for(SObject recordObject:recordList){
                String sObjName = recordObject.Id.getSObjectType().getDescribe().getName();
                system.debug(sObjName);
                
                if(String.valueOf(sObjName) == 'MIR__c'){
                    MIR__c con = (MIR__c)recordObject;
                    MIR__c updateObject =new MIR__c();
                    updateObject.Id = con.Id;
                    if(codeMap.get('Code 1') != ''){
                        updateObject.Code_1__c = codeMap.get('Code 1');
                    }
                    
                    if(codeMap.get('Code 2') != ''){
                        updateObject.Code_2__c = codeMap.get('Code 2');
                        
                    }
                    
                    if(codeMap.get('Code 3') != ''){
                        updateObject.Code_3__c = codeMap.get('Code 3');
                    }
                    
                    if(codeMap.get('Code 4') != ''){
                        updateObject.Code_4__c = codeMap.get('Code 4');
                    }
                    
                    if(codeMap.get('Code1 1') != ''){
                        updateObject.Code1_1__c = codeMap.get('Code1 1');
                    }
                    
                    if(codeMap.get('Code1 2') != ''){
                        updateObject.Code1_2__c = codeMap.get('Code1 2');
                        
                    }
                    
                    if(codeMap.get('Code1 3') != ''){
                        updateObject.Code1_3__c = codeMap.get('Code1 3');
                    }
                    
                    if(codeMap.get('Code1 4') != ''){
                        updateObject.Code1_4__c = codeMap.get('Code1 4');
                    }
                    MIRUpdateList.add(updateObject);  
                }
                
                  if(String.valueOf(sObjName) == 'EMDR__c'){
                    EMDR__c con = (EMDR__c)recordObject;
                    EMDR__c updateObject =new EMDR__c();
                    updateObject.Id = con.Id;
                    if(codeMap.get('Code 1') != ''){
                        updateObject.Code_1__c = codeMap.get('Code 1');
                    }
                    
                    if(codeMap.get('Code 2') != ''){
                        updateObject.Code_2__c = codeMap.get('Code 2');
                        
                    }
                    
                    if(codeMap.get('Code 3') != ''){
                        updateObject.Code_3__c = codeMap.get('Code 3');
                    }
                    
                    if(codeMap.get('Code 4') != ''){
                        updateObject.Code_4__c = codeMap.get('Code 4');
                    }
                    
                        if(codeMap.get('Code1 1') != ''){
                        updateObject.Code1_1__c = codeMap.get('Code1 1');
                    }
                    
                    if(codeMap.get('Code1 2') != ''){
                        updateObject.Code1_2__c = codeMap.get('Code1 2');
                        
                    }
                    
                    if(codeMap.get('Code1 3') != ''){
                        updateObject.Code1_3__c = codeMap.get('Code1 3');
                    }
                    
                    if(codeMap.get('Code1 4') != ''){
                        updateObject.Code1_4__c = codeMap.get('Code1 4');
                    }
                    EMDRUpdateList.add(updateObject);    
                    
                }
            }

        }else {
            message = 'error';
        }
       
        try{
            if(EMDRUpdateList.size() > 0)
            update EMDRUpdateList;
            if(MIRUpdateList.size() > 0)
            update MIRUpdateList;

        }catch(Exception e){
            message = 'error';   
        }
        return message;
    }
    
    public static Map<String,String> convertStringToMap(String recordDetails){
        
        String str = recordDetails;
        str = str.replace('},{','>');
        str = str.remove('"');
        str = str.remove('{');
        str = str.remove('}');
        str = str.remove('[');
        str = str.remove(']');
        str = str.remove('code');
        str = str.remove('Name');
        str = str.remove(':');
        String[] stringArr = new String[]{};
            stringArr = str.split('>');
        Map<String,String> codeMap = new Map<String,String>();
        for(String stringObject: stringArr){
            Integer indexNum = stringObject.indexOf(',');
            String  code = stringObject.substring(0,indexNum);
            String codeName =   stringObject.substring(indexNum+1,stringObject.length());
            codeMap.put(codeName,code);
            
        }
        return codeMap; 
    }
}