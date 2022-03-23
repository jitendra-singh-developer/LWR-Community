public class BookingDomController2 {
    
    public Booking__c Book {get;set;}
    public Booking__c Book1 {get;set;}
    public Booking__c Book2 {get;set;}
    public BookingDomController2()
    {
        
        Book = new Booking__c(); 
        Book1 = new Booking__c();
        Book2 = new Booking__c();
        
    }
    
    
    public PageReference save()
    {
        
       
            upsert Book;
        	upsert Book1;
        	upsert Book2;
           
       
        PageReference pg = new PageReference('https://ibirdssoftwareservices8-dev-ed.lightning.force.com/lightning/o/Booking__c/list?filterName=Recent');
        return pg;
        
    }
    
    
}