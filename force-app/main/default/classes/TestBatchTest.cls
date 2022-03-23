@isTest
public class TestBatchTest {
    
    @isTest
    public static void TestOne(){
        Opportunity[] oppList = new Opportunity[] {
            new Opportunity()
                };
                    TestBatch b = new TestBatch(oppList, null);
        Test.startTest();
        Database.executeBatch(b);
        Test.stopTest();
    }
    
}