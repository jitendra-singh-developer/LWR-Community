public class TriggerDemoHelper {
	public static boolean isTrue = false;
    public static void insertAccount(){
      //  isTrue = true;
        Account acc = new Account();
        acc.Name = 'Helo world';
        acc.Account_Phase__c = 'First Phase';
        acc.Cities__c = 'djlksdhfk';
        acc.Password__c = 'dkfjadklfj';
        insert acc;
    }
}