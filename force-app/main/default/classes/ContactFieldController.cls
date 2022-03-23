public class ContactFieldController {
    public Contact contacts {get;set;}
    public List<Contact> contactList {get;set;}
     public String renderingService { get;set; }
    
    
    public String renderedFileName { 
        get; 
        set { renderedFileName = this.sanitizeFileName(value); }
    }
    public ContactFieldController(){
        contacts = new Contact();
        List<Schema.FieldSetMember> fieldList = SObjectType.Contact.FieldSets.ContactSet.getFields();
        System.debug('jdklfjkds'+ fieldList);
        String query = 'SELECT ';
        for(Schema.FieldSetMember f : fieldList) {
            
            query += f.getFieldPath() + ', ';
           
        }
        query += 'Id From Contact ';
        contactList =  Database.query(query);
    }
      public PageReference saveToPdf() {
          
        renderingService = 'PDF';
        return null;
    }
    
       public String renderedContentType {
        get {
            String renderedContentType = 'text/html'; 
            
            if( ! this.renderingAsHtml() ) {
             
                renderedContentType = 'application/pdf';
                
              
                if( this.renderedFileName != null) {
            
                    renderedContentType += '#' + this.renderedFileName;
                    
                   
                    ApexPages.currentPage().getHeaders().put(
                        'content-disposition', 'attachment; filename=' + 
                         this.renderedFileName);
                }
            }
            
            return renderedContentType;
        }
    }
    
    
    public void quickSave(){
        insert contacts;
        
    }
    public PageReference Save(){
        quickSave();
        PageReference pg = new PageReference('/apex/ContactFieldListVF');
        return pg;
    }
    
      public Boolean renderingAsHtml() {
        return ( (renderingService == null) || 
                 ( ! renderingService.startsWith('PDF')) );
    }
    
      private String sanitizeFileName(String unsafeName) {
        String allowedCharacters = '0-9a-zA-Z-_.';
        String sanitizedName = 
            unsafeName.replaceAll('[^' + allowedCharacters + ']', '');

        return(sanitizedName);
    }
}