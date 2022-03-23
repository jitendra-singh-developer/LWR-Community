@isTest
public class AccountObjectTriggerTest {
    
     @isTest
    public static void testMethodOne(){
        EMDR_Code__c eMDRCodeObject = TestDataFactory.createEMDRCode('878787',true);
        TestDataFactory.createCode(eMDRCodeObject.Name,true);
        Account accountObject = TestDataFactory.createAccount(false);
        accountObject.Code_Choice__c = eMDRCodeObject.Id;
        insert accountObject;
        
        TestDataFactory.createMIR(accountObject.Id,true);
        TestDataFactory.createEMDR(accountObject.Id,true);
        accountObject.Account_Phase__c = 'Second Phase';
        update accountObject;
    }

}