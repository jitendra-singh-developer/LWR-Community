@isTest
public class MIRCodeChoiceTriggerTest {
	
    @isTest
    public static void testMethodOne(){
      Account accountObject = TestDataFactory.createAccount(true);
      Code__c codeObject = TestDataFactory.createCode('343433',true);
      System.assertEquals('343433', codeObject.Name);
      MIR__c mIRObject = TestDataFactory.createMIR(accountObject.Id ,True);
      List<MIR_Code_Choice__c> mIRCodeChoiceList = TestDataFactory.createMIRCodeChoices(codeObject.Id,mIRObject.Id,true);
      codeObject = TestDataFactory.createCode('333333',true);
      mIRCodeChoiceList = TestDataFactory.createMIRCodeChoices(codeObject.Id,mIRObject.Id,true);
      update mIRCodeChoiceList;
      delete mIRCodeChoiceList;
    }
}