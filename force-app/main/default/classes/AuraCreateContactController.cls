public class AuraCreateContactController {
	
    @AuraEnabled
    public static String createContactServer(Map<String,Object> contactMap, String recordId){
		Contact conObj = new Contact();
        System.debug('contactMap'+ contactMap);
        System.debug('recordId'+ recordId);
        conObj.FirstName = (String) contactMap.get('FirstName');
        conObj.LastName = (String)  contactMap.get('LastName');
        conObj.Phone = (String)  contactMap.get('Phone');
        conObj.Email = (String)  contactMap.get('Email');
        conObj.AccountId = recordId;
        System.debug('conObj'+ conObj);
        insert conObj;
        return 'Success';
      //  PageReference pg = new PageReference('/'+recordId);
      //  pg.setRedirect(true);
       // return pg;
    }
}