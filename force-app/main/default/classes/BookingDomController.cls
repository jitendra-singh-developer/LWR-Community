public class BookingDomController {
    
    public Booking__c Book {get;set;}
    public BookingDomController()
    {
        
        String bookid = Apexpages.currentPage().getParameters().get('bookid');
        if(String.isNotBlank(bookid))
        {
            
            Book = [Select id, Customer__c,Room_No__c,Status__c,Check_In_Time__c,Check_out_Time__c,Name from Booking__c Where id =: bookid];
        }
        else
        {
            Book = new Booking__c();  
        }
    }
    
    public Integer quicksave()
    {	
        
        
        try
        {
            upsert book;   
        }
        catch(Exception e)
        {
            Apexpages.addMessages(e);
          	return 1;
            
        }
      return 0;
        
    }
    public PageReference save()
    {
       	if(quicksave()==1)
        {
            return null;
        }
        else
        {
            PageReference pg = new PageReference('/'+ Book.Id);
            return pg;
        } 
        
        
    }
    public PageReference saveNew()
    {
        if(quicksave()==1)
        {
            return null;
        }
        else
        {
            PageReference pg = new PageReference('/apex/BookingDOM');
            pg.setRedirect(true);
            return pg;
        }
        
        
        
    }
    
    /*
    public void quicksave()
    {	
        
        
        try
        {
            upsert book;   
        }
        catch(Exception e)
        {
            Apexpages.addMessages(e);
          
            
        }
      
        
    }
    public PageReference save()
    {
      
         try
        {
            upsert book;   
        }
        catch(Exception e)
        {
            Apexpages.addMessages(e);
            return null;
            
        }
          PageReference pg = new PageReference('/'+ Book.Id);
            return pg;
        
    }
    public PageReference saveNew()
    {        
         try
        {
            upsert book;   
        }
        catch(Exception e)
        {
            Apexpages.addMessages(e);
            return null;
            
        }
         PageReference pg = new PageReference('/apex/BookingDOM');
            pg.setRedirect(true);
            return pg;
        
    }
	*/
    
    
}