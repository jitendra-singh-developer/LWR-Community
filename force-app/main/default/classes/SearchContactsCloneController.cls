/**
	Name		: SearchContactsController
	Date		: 2 Feb, 2021
	Author		: Jitendra Singh
	Description	: This controller is about searching contacts through name
				  and email and updation of type field when user checked the
				  on checkbox and click on save button.
				 
*/
public class SearchContactsCloneController {
    
    public String selectedType {get;set;}
    public String searchValue {get;set;}
    
    public List<SearchContactsModel> contactModelList {get;set;}
    private  boolean isAllow ;
    
    
    public SearchContactsCloneController(){
     
        contactModelList = new List<SearchContactsModel>();
        isAllow = false;
        
        fetchRecords();
    }
    
    public List<SelectOption> getSelectList(){
        
        List<SelectOption> options = new List<SelectOption>();
        
        Schema.DescribeFieldResult typeResult = Contact.Type__c.getDescribe();
        List<Schema.PicklistEntry> selectType = typeResult.getPicklistValues();
        
        options.add(new SelectOption('','Options'));
        for(Schema.PicklistEntry ple : selectType) {
            options.add(new SelectOption(ple.getLabel(), ple.getValue()));
        }       
        return options;
    }
    
    public void fetchRecords(){
        
        List<Contact> contactList = new List<Contact>();
        if(isAllow){
            contactModelList.clear();
            String nameEmailValue = '%' + searchValue + '%';
            contactList = [select Id, Name, Email, Phone, Account.Name, Type__c from Contact 
                           where Name like : nameEmailValue Or Email Like : nameEmailValue 
                           limit 20 ];  
            if(contactList.size() == 0){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No Record Found.'));
            }
        }else{
            contactList = [select Id,Name ,Email,Phone,Account.Name, Type__c from Contact limit 20];
        }
        
        for(Contact con : contactList){
            
            SearchContactsModel sc = new SearchContactsModel();
            sc.conObj = con;
            sc.isChecked = false;
            contactModelList.add(sc);
        }
    }
    
    public void searchRecords(){
        
        isAllow = true;
        fetchRecords();
    }
    
    public void save(){
        List<Contact> contactUpdateList = new List<Contact>();
        for(SearchContactsModel sm : contactModelList ){
            
            if(sm.isChecked){
                sm.conObj.Type__c = selectedType;
                contactUpdateList.add(sm.conObj);
                sm.isChecked = false;
            }
            
        }
        
        if(contactUpdateList.size() == 0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select at least one record')); 
        }else{
            update contactUpdateList;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Record is Updated Successfully.'));  
        } 
        
        
    }
    
    public Class SearchContactsModel{
        public  Contact conObj {get;set;}
        public  Boolean isChecked {get;set;}
    }
    
}