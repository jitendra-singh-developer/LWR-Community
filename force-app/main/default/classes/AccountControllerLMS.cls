public without sharing class AccountControllerLMS {
  @AuraEnabled
  public static List<Account> getAccounts(){
    return [Select Id, Name, Industry, Site  from Account limit 50 ];
  }
}