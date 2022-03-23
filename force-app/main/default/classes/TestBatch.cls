global without sharing class TestBatch implements Database.Batchable<SObject>,database.stateful 
{


   List<Opportunity> oppList = new List<Opportunity>();
   List<OpportunityLineItem> OliList = new List<OpportunityLineItem>();

   global TestBatch (List<Opportunity> oppList,List<opportunitylineitem>OliList)
   {
        this.oppList  = oppList;
        this.OliList = OliList;

   }

    global Iterable<Sobject> start(Database.BatchableContext bc) 
    {
           return oppList;
    }
    global void execute(Database.BatchableContext bc,List<opportunity> scope)
    {

    }
    global void finish(Database.BatchableContext bc) 
    {


        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems FROM AsyncApexJob WHERE Id = :BC.getJobId()];


        if(a.status == 'Completed' && (a.NumberOfErrors==null || a.NumberOfErrors==0))
        {
           //2 lines of code

        }else{
            //Some 50 lines of code
        }

    }

}