@isTest
public class OrderTriggerTest {
 
	
    @TestSetup
    static void setUp(){
        
        Account accountObject = TestDataFactory.createAccount(true);
        Opportunity opportunityObject = TestDataFactory.createOpportunity(true,accountObject);
        Order orderObject = TestDataFactory.insertOrder(true,accountObject,opportunityObject); 
		//Order orderObject1 = TestDataFactory.insertOrder(true,accountObject,opportunityObject); 
    }

    @isTest
    public static void testMethod1(){
        
        List<Order> orderList = [SELECT Id, Amount__c, Status FROM Order ]; 
        Order orderObject = orderList.get(0);
        ID priceBookId = Test.getStandardPricebookId();
        orderObject.Pricebook2Id = priceBookId;
        update orderObject;
        Product2 productObject = TestDataFactory.createProduct(true);
        PricebookEntry priceBookEntryObject = TestDataFactory.createPriceBookEntry(true,productObject,priceBookId);
        OrderItem orderProductObject = TestDataFactory.createOrderProduct(true,productObject,priceBookEntryObject,orderObject);
        orderObject.Status = 'Activated';
        update orderObject;
        TestDataFactory.deleteOrder(orderObject);
    }		
    
 
}