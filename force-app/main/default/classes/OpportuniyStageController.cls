public class OpportuniyStageController {
	public List<AggregateResult> sumout {get;set;}	
    public List<OpportunityModel> opportunityModels {get;set;}
    public List<Opportunity> opportunityList {get;set;}
    public OpportuniyStageController()
    {
   		opportunityModels = new List<OpportunityModel>();
        opportunityList = new List<Opportunity>();
        List<AggregateResult> aggResult = [select StageName from Opportunity Group by StageName ];
          System.debug('hehehe'+ aggResult);
     
           
        for(AggregateResult agg : aggResult)
        {
            OpportunityModel om = new OpportunityModel();
            om.stageNam = (String)agg.get('StageName');
            
             sumout = [Select sum(Amount) sum ,avg(Amount) avg ,max(Amount) max ,min(Amount) min ,count(Amount) totalcount  from Opportunity Where StageName = :  om.stageNam ];
           
			om.amountSum = (Decimal)sumout[0].get('sum');
            	om.amountMax = (Decimal)sumout[0].get('max'); 
            	om.amountMin = (Decimal)sumout[0].get('min');
            		om.avarage = (Decimal)sumout[0].get('avg');
            	om.count = (Integer)sumout[0].get('totalcount');
             
            
            if(!opportunityModels.contains(om))
            {
               opportunityModels.add(om);   
            }
           
            
            
        }
      System.debug('hello by'+ opportunityModels );
    }
    
    public class OpportunityModel
    {
        public String stageNam {get;set;}
        public Decimal amountSum {get;set;}
        public Decimal amountMax {get;set;}
        public Decimal amountMin {get;set;}
        public Decimal avarage  {get;set;}
        public Integer count {get;set;}
    }
}