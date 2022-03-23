public class BulkInsertBookingController {
    public List<Booking__c> bookings {get;set;}
    public BulkInsertBookingController()
    {
        bookings = new List<Booking__c>();
        for(integer i=0;i<3;i++)
        {
           bookings.add(new Booking__c()); 
		}
        
    }
    
    public void save()
    {
        upsert bookings;
	}
}