@isTest
public class EMDRCodeTriggerTest {
    
    @isTest
    public static void testMethodOne(){
      EMDR_Code__c eMDRCodeObject = TestDataFactory.createEMDRCode('2323232', true);
      eMDRCodeObject.Name = '565656';
      update eMDRCodeObject;
      delete eMDRCodeObject;
        
    }
    
    

}