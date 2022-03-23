public class OpportunityAccountDetailController {
    public Opportunity oppos {get;set;}

    public OpportunityAccountDetailController(){
        Id recordid = ApexPages.currentPage().getParameters().get('id');
        oppos = [Select Id, Name , Amount , AccountId, CloseDate from Opportunity where id = : recordId ];
        
    }
    
}