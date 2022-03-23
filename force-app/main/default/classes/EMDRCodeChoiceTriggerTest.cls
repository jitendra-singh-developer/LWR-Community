@isTest
public class EMDRCodeChoiceTriggerTest {
	
    @isTest
    public static void testMethodOne(){
      Account accountObject = TestDataFactory.createAccount(true);
      EMDR_Code__c eMDRCodeObject = TestDataFactory.createEMDRCode('343433',true);
      EMDR__c eMDRObject = TestDataFactory.createEMDR(accountObject.Id ,True);
      List<EMDR_Code_Choice__c> eMDRCodeChoiceList = TestDataFactory.createEMDRCodeChoices(eMDRCodeObject.Id,eMDRObject.Id,true);
      eMDRCodeObject = TestDataFactory.createEMDRCode('333333',true);
      eMDRCodeChoiceList = TestDataFactory.createEMDRCodeChoices(eMDRCodeObject.Id,eMDRObject.Id,true);
      update eMDRCodeChoiceList;
      delete eMDRCodeChoiceList;
        
        
    }
    
   
}