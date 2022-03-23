public class SendDataToApex {
	@InvocableMethod 
    public static void  updateAccountName(List<Id> ids){
        System.debug('Account Ids'+ ids);
    }
}