/**
Name        : SearchContactsController
Date        : 2 Feb, 2021
Author      : Jitendra Singh
Description : This controller is about searching contacts through nameand email and updation of type field when user select selectType and checked the
on checkbox and click on save button.And i add a new coloum that is Detail it take commandlink .first , last , next , previous
button to custom pagination and sorting on click on colunm wise .

*/
public class SearchContactsController {
    
    public String selectedType {get;set;}
    public String searchValue {get;set;}
    public Integer pageSize {get;set;}
    public String fieldName {get;set;}
    public String orderName {get;set;}
    
    
    private Integer startIndex ;
    private Integer modelListSize ;
    public  String storeFieldName {get;set;}
    private Integer endIndex;
    private String fieldOrderName ;
    
    
    
    public List<ContactModel> contactModelList {get;set;}
    public List<ContactModel> showContactModelList {get;set;}
    
    
    public SearchContactsController(){
        showContactModelList = new List<ContactModel>();
        contactModelList = new List<ContactModel>();
        pageSize = 5;
        startIndex = 0;
        endIndex =  5;
        orderName = 'ASC';
        fieldName = 'Name';
        fetchRecords();  
    }
    
    public List<SelectOption> getPageSizeList(){
        List<SelectOption> sizeOption = new List<SelectOption>();
        sizeOption.add(new SelectOption('5','5'));
        sizeOption.add(new SelectOption('10','10'));
        sizeOption.add(new SelectOption('15','15'));
        sizeOption.add(new SelectOption('20','20'));
        return sizeOption;
    }
    
    public List<SelectOption> getSelectList(){
        
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult typeResult = Contact.Type__c.getDescribe();
        List<Schema.PicklistEntry> selectType = typeResult.getPicklistValues();
        
        options.add(new SelectOption('','--None--'));
        for(Schema.PicklistEntry ple : selectType) {
            options.add(new SelectOption(ple.getLabel(), ple.getValue()));
        }       
        return options;
    }
    List<Contact> contactList = new List<Contact>();
    public void fetchRecords(){
        
        String query = 'select Id, Name, Email, Phone, Account.Name, Type__c from Contact';
        if(String.isNotBlank(searchValue)){
            contactModelList.clear();
            String nameEmailValue = '\'%' + searchValue   + '%\'';
            query = query + ' where Name like  '+  nameEmailValue +  +' Or Email Like  '+ nameEmailValue +' limit 100 '; 
            System.debug('my query : ' + query);
            contactList = Database.query(query);
            
        }else {
            
            if(fieldName == storeFieldName){
                orderName = 'DESC';
                storeFieldName = null;
            }
            else{
                orderName = 'ASC';
                storeFieldName = fieldName;
            }
            
            String fieldOrderName = fieldName +'  '+ orderName;
            query = query + ' order by '+ fieldOrderName  + ' limit 100';
            contactList = Database.query(query);
            
        }
        addContactModelList(contactList);
        
    }
    public void addContactModelList(List<Contact> contactList){
        
        contactModelList.clear();
        for(Contact con : contactList){
            
            ContactModel sc = new ContactModel();
            sc.contactRecord = con;
            sc.isChecked = false;
            contactModelList.add(sc);
              
        }
        modelListSize = contactModelList.size();
        startIndex = 0;
        
        if(modelListSize == 0)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Record Found'));
        addTemporaryList(contactModelList);
    }
    public void addTemporaryList(List<ContactModel> contactModelList){
        
        showContactModelList.clear();
        if(startIndex + pageSize > modelListSize){
            Integer lastRecords = math.mod(modelListSize,pageSize);
            endIndex = startIndex + lastRecords ;
        }
        for(Integer i = startIndex; i < (endIndex);  i++){
            showContactModelList.add(contactModelList.get(i));   
        }
    }
    
    
    public void searchRecords(){
        fetchRecords();
    }
    public void changeSize(){
        fetchRecords();
    } 
    public void sortList(){
        fetchRecords();        
    }
    
    public void first(){
        startIndex = 0;
        endIndex = startIndex + pageSize;
        addTemporaryList(contactModelList);
    }
    
    public void previous(){
        
        if(startIndex >= pageSize ){
            startIndex = startIndex - pageSize;
            endIndex = startIndex + pageSize;
            addTemporaryList(contactModelList);
        }  
    }
    public void next(){
        
        if(endIndex < modelListSize){
            startIndex = endIndex; 
            endIndex = startIndex + pageSize;
            addTemporaryList(contactModelList); 
        }   
    }
    public void last(){
        
        Integer recordSet = (modelListSize/pageSize);
        Integer lastRecords = math.mod(modelListSize , pageSize);
        if(lastRecords == 0){
            startIndex = modelListSize - pageSize;
            endIndex = modelListSize;
        }
        else{
            startIndex = recordSet*pageSize;
            endIndex = lastRecords + startIndex;
            
        }
        addTemporaryList(contactModelList);
    }
    public void detail(){ }
    public void save(){
        List<Contact> contactUpdateList = new List<Contact>();
        for(ContactModel sm : contactModelList ){
            
            if(sm.isChecked){
                sm.contactRecord.Type__c = selectedType;
                contactUpdateList.add(sm.contactRecord);
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
    public Class ContactModel{
        public   Contact contactRecord {get;set;}
        public   Boolean isChecked {get;set;}
    }
    
}