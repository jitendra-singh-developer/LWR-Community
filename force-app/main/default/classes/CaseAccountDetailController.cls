public class CaseAccountDetailController {
    public Case cases {get;set;}
    public CaseAccountDetailController(){
         Id recordid = ApexPages.currentPage().getParameters().get('id');
        cases = [Select Id , Status , AccountId, Product__c , Type from Case Where id = : recordId ];
        
    }
}