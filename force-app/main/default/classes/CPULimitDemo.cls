public class CPULimitDemo {
	
    public static void testMethod1(){
        List<Account> account = [Select Id,Name from Account];
        update account;
        delete account;
        undelete account;
        delete account ;
        update account;
        delete account;
        undelete account;
            update account;
        for(Integer i=0;i<100;i++){
            System.debug('Check cpu limit'+i+'Limit====>'+ Limits.getCpuTime());
        }
    }
    
}