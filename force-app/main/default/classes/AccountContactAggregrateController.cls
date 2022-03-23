public class AccountContactAggregrateController {
   // public List<Integer> aggragateList {get;set;}
    public List<Account> accounts {get;set;}
    //public Set<Id> idset {get;set;}
    public Map<Id,Contact> accountMap {get;set;}
    	//public AccountContactAggregrateController()
        //{
        //    accounts = [Select Id,Name,(Select Id,Name from Contacts) from Account];
		//}
		public AccountContactAggregrateController()
        {
         	accounts = [Select Id,Name from Account];
            System.debug('accountmap'+ accountMap); 
            for(Account account: accounts )
            {
               List<AggregateResult> aggregate = [Select count(id) total,AccountId from Contact Where AccountId = : account.Id Group By AccountId];
               AggregateResult sm = aggregate.get(2);
           	   System.debug('YYYYY'+ sm.get('total'));
            }
            
        }
		
    
}