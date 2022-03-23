public class AuraContactController {
    
    
	@AuraEnabled
    Public static List<contact> getContacts(String accountId){
        System.debug('id'+ accountId);
        return [Select Id, FirstName, LastName, Email, Phone from Contact Where AccountId = : accountId];
    }    
    

}