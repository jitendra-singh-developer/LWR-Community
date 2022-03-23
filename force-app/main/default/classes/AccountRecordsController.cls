public inherited sharing class AccountRecordsController {

    
    @AuraEnabled(cacheable=true)
    public static String getAccount() {
        return 'This is Account';
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
        return [select Id, Name, Phone, Fax from Account limit 20];
    }

}