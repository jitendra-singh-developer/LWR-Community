public class AttachmentMangamentController {
    
    public List<SelectOption> objectOptions {get;set;}
    public List<SelectOption> objectCopyOptions {get;set;}
    public List<String> objects {get;set;}
    public List<String> copyObjects {get;set;}
    public List<Attachment> attachmentList {get;set;}
    public List<Attachment> sAttachmentList {get;set;}
    public List<Attachment> copyAttachmentIdList {get;set;}
    public List<Account> accounts {get;set;}
    public List<Contact> contacts {get;set;}
    public List<Opportunity> opportunities {get;set;}
    public List<showAttachmentModel> sAttachmentModels {get;set;}
    public List<showObjectListModel> showObjectListModels {get;set;}
    public List<ID> objectsListModels {get;set;}
    
    public String imageContentJPEG {get;set;}
    public String selectedObject {get;set;}
    public String selectedCopyObject {get;set;}
    public String name {get;set;}
    public String imageContentTXT {get;set;}
    public String imageContentPNG {get;set;}
    public String defaultName {get;set;}
    
    public boolean isAttach {get;set;}
    public boolean iscontact {get;set;}
    public boolean isAccount {get;set;}
    public boolean isOpportunity {get;set;}
    public boolean isObjects {get;set;}
    public boolean disableback {get;set;} 
    public boolean isView {get;set;}
    public boolean makeSearchTrue ;
    public boolean makeAllAttachTrue {get;set;}
    public boolean objectCheckedBox {get;set;}
    
    public id checkedAccountRecordID {get;set;}
    public Id preFileId {get;set;}
    public Id copyAttach {get;set;}
    
    public Map<Id,Attachment> attachMap {get;set;}
    
    public AttachmentMangamentController()
    {
        defaultName = 'txtFile';
        imageContentJPEG = 'image/jpeg';
        imageContentTXT = 'text/plain';
        imageContentPNG = 'image/png';
      
        objectCheckedBox = false;
        isAttach = false;
        iscontact = false;
        isOpportunity = false;
        isAccount = false;
        isObjects = false;
        makeAllAttachTrue = false;
        makeSearchTrue = false;
        isView = false;
        disableback = false;
        
        copyAttachmentIdList = new List<Attachment>();
        showObjectListModels = new List<showObjectListModel>();
        objectsListModels = new List<ID>();
        sAttachmentModels = new List<showAttachmentModel>();
        sAttachmentList = new List<Attachment>();
        attachmentList = new List<Attachment>();
        
        loadobjects(); 
    }
    
    public void loadobjects(){
        
        objects = new List<String>{'--None--','Account','Contact','Opportunity'};      
        loadobjectData();
    }
    public void loadobjectData(){
        
        objectOptions = new List<selectOption>();
        for(String  obj: objects){
            objectOptions.add(new SelectOption(obj , obj));
        }
    }
    public void loadCopyobjects(){
        
        copyObjects = new List<String>{'--None--','Account','Contact','Opportunity'};      
        loadCopyobjectData();
    }
    public void loadCopyobjectData(){
        
        objectCopyOptions = new List<selectOption>();
        for(String  obj: copyobjects){
            objectCopyOptions.add(new SelectOption(obj , obj));
        }
    }
    public void makeAllTrue(){
        
        for(showAttachmentModel sAtt : sAttachmentModels){
            if(makeAllAttachTrue){   
                sAtt.ischecked = true;
                copyAttach = sAtt.attach.Id;
                oncheckedAttach();
              
				               
            }
            else{
                sAtt.ischecked = false;
                copyAttach = sAtt.attach.Id;
                oncheckedAttach();
            }
            
        }
    }
    public void showAttachment(){
        isAttach = true;
        isObjects = false;
        isAccount = false;
        isOpportunity = false;
        iscontact = false;
        
        if('Account' == selectedobject){
             List<Attachment> attachList = new List<Attachment>();
            sAttachmentModels = new List<showAttachmentModel>();
            accounts = [select Id , Name from Account ];
            for(Account acc: accounts){
                
                attachmentList = [Select Id ,Name , ContentType,Body from Attachment Where parentId =  : acc.Id];
                  attachList.addAll(attachmentList);
                for(Attachment at: attachmentList){
                    showAttachmentModel sm = new showAttachmentModel();
                    sm.Attach = at;
                    sm.ischecked = false;
                    
                    sAttachmentModels.add(sm);    
                }   
            }
               attachMap = new Map<Id,Attachment>(attachList);
        }
        else if('Contact' == selectedObject)
        {
             List<Attachment> attachList = new List<Attachment>();
            sAttachmentModels = new List<showAttachmentModel>();
            contacts = [select Id , Name from Contact ];
            for(Contact acc: contacts){
                
                attachmentList = [Select Id ,Name , ContentType ,Body from Attachment Where parentId =  : acc.Id];
                  attachList.addAll(attachmentList);
                for(Attachment at: attachmentList){
                    showAttachmentModel sm = new showAttachmentModel();
                    sm.Attach = at;
                    sm.ischecked = false;
                    sAttachmentModels.add(sm);
                    
                    
                }
                
            }
            
              attachMap = new Map<Id,Attachment>(attachList);  
        }
        else if('Opportunity' == selectedObject){
            List<Attachment> attachList = new List<Attachment>();
            sAttachmentModels = new List<showAttachmentModel>();
            opportunities = [select Id , Name from Opportunity ];
            for(Opportunity acc: opportunities) {
                
                attachmentList = [Select Id ,Name , ContentType, Body from Attachment Where parentId =  : acc.Id];
                attachList.addAll(attachmentList);
                for(Attachment at: attachmentList){
                    showAttachmentModel sm = new showAttachmentModel();
                    
                    sm.Attach = at;
                    sm.ischecked = false;
                    sAttachmentModels.add(sm);
                    
                    
                }
                
            }
            attachMap = new Map<Id,Attachment>(attachList);
        }
        else{
            isAttach = false; 
        }
        
    }
    public void oncheckedAttach(){
        
       
        Attachment att = attachMap.get(copyAttach);
     
        if(copyAttachmentIdList.contains(att)){
            System.debug('Remove part');
            Integer indexofNum = copyAttachmentIdList.indexOf(att);
            copyAttachmentIdList.remove(indexofNum);
            /* for(showAttachmentModel sAttachlist :sAttachmentModels){
                if(!sAttachlist.ischecked){
                    makeAllAttachTrue= false;
                    break;
                }
            }*/
           
        }
        else{
              System.debug('Add part');
            boolean isTrue = true;
            copyAttachmentIdList.add(att);  
            /*for(showAttachmentModel sAttachlist :sAttachmentModels){
                if(!sAttachlist.ischecked){
                   istrue = false;
                   
                }
                makeAllAttachTrue = istrue;
            }*/
        }
      System.debug('copy Attachment list '+ copyAttachmentIdList);
    }
    public void copyFunction()
    {
        loadCopyobjects();
        /* for(showAttachmentModel smd : sAttachmentModels)
{
if(smd.ischecked)
{
isObjects = true;
copyAttachmentIdList.add(smd.attach);
System.debug('id '+ smd.attach.id);
}
} */
        
        if(!copyAttachmentIdList.isEmpty()){
            isObjects = true;
        }
        if(!isObjects){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Please Check at least One File for Copy')); 
        }
        name = null;        
    }
    public void closeWindow(){ isObjects = false; }
    public void showObjectList(){
        
        objectCheckedBox = false;
        String firstname ;
        showObjectListModels = new List<showObjectListModel>();
        System.debug('show reuslut'+ selectedCopyObject);
        if('Account' == selectedCopyObject ){
    	 isAccount = true;
         iscontact = false;
         isopportunity = false;
         if(makeSearchTrue){
             List<Account> accountList = new List<Account>();
             if(name != null && name != ' ' ){
                 firstname = '%'+name+'%';
                 accountList = [select id, Name ,Email__c ,Phone from Account Where Name Like : firstname ]; 
             }
             else{
                 accountList = [select id, Name ,Email__c ,Phone from Account ];
             }
             
             for(Account ac : accountList){
                 showObjectListModel slm = new showObjectListModel();
                 slm.accountObject = ac;
                 slm.ischeckedbox = false;
                 
                 showObjectListModels.add(slm);    
             } 
         }
         
        }
        else if('Contact' == selectedCopyObject ){
            iscontact = true;
            isAccount = false;
            isopportunity = false;
            List<Contact> contactList = new List<Contact>();
            if(makeSearchTrue){
                if(name != null && name != ' '){
                    firstname = '%'+name+'%';
                    contactList = [select id, Name ,Email ,Phone from Contact Where Name Like : firstName]; 
                }
                else{
                    contactList = [select id, Name ,Email ,Phone from Contact];  
                }
                
                for(Contact ac : contactList){
                    showObjectListModel slm = new showObjectListModel();
                    slm.contactObject = ac;
                    slm.ischeckedbox = false;
                    
                    showObjectListModels.add(slm);    
                }
            }
            makeSearchTrue = false;
        }
        else if('Opportunity' == selectedCopyObject)
        {
            isOpportunity = true;
            isAccount = false;
            iscontact = false;
            List<Opportunity> opportunityList = new List<Opportunity>();
            if(makeSearchTrue){
                if(name != null && name != ' '){
                    firstname = '%'+name+'%';
                    opportunityList = [select id, Name , Amount , CloseDate from Opportunity where Name Like : firstName];  
                }
                else{
                    opportunityList = [select id, Name , Amount , CloseDate from Opportunity];
                }
                
                for(Opportunity ac : opportunityList){
                    showObjectListModel slm = new showObjectListModel();
                    slm.opportunityObject = ac;
                    slm.ischeckedbox = false;
                    
                    showObjectListModels.add(slm);     
                }
            }
        }
        else{
            isOpportunity = false;
            isAccount = false;
            iscontact = false; 
        }
        makeSearchTrue = false;
    }
    
    public void makeRecord() {
        
        System.debug('hello make object true method');
        for(showObjectListModel sobj : showObjectListModels ){
            if(objectCheckedBox)
            {
                sobj.ischeckedbox = true;
                System.debug('hello bro whats up'+ sobj);
                if('Account' == selectedCopyObject ){
                    
                checkedAccountRecordID = sobj.accountObject.Id;
                }
                else if('Contact' == selectedCopyObject ){
                      checkedAccountRecordID = sobj.contactObject.Id;  
                }
                else if('Opportunity' == selectedCopyObject){
                     checkedAccountRecordID = sobj.opportunityObject.Id;  
                }
                onCheckedObject();
                    
            }
            else{
                 sobj.ischeckedbox = false;
                  if('Account' == selectedCopyObject ){
                    
                checkedAccountRecordID = sobj.accountObject.Id;
                }
                else if('Contact' == selectedCopyObject ){
                      checkedAccountRecordID = sobj.contactObject.Id;  
                }
                else if('Opportunity' == selectedCopyObject){
                     checkedAccountRecordID = sobj.opportunityObject.Id;  
                }
                onCheckedObject();
            }
        } 
      
    }
    
    public void onCheckedObject(){
        
        
        
        if(objectsListModels.contains(checkedAccountRecordID)){
            Integer indexofObject = objectsListModels.indexOf(checkedAccountRecordID);
            objectsListModels.remove(indexofObject); 
           /* for(showObjectListModel sAttachlist :showObjectListModels){
                if(!sAttachlist.ischeckedbox){
                    objectCheckedBox = false;
                    break;
                }
            }*/
            
        }
        else{
            
            objectsListModels.add(checkedAccountRecordID);  
           // showObjectListModel slm = new showObjectListModel();
           // slm.ischeckedbox = true;
           // showObjectListModels.add(slm);
           // System.debug('in else part ::::::::');
            //  boolean isTrue = true;
            
            /*for(showObjectListModel sAttachlist :showObjectListModels){
                if(!sAttachlist.ischeckedbox){
                   istrue = false;
                   
                }
                objectCheckedBox = istrue;
            }*/
        }
        
        System.debug('objectLIstModels'+ objectsListModels);
    }
    
    public PageReference attachFile()
    {
        System.debug('object list '+ objectsListModels );
        System.debug('Attachment list '+ copyAttachmentIdList);
        List<Attachment> attachmentUploadList = new List<Attachment>();
        isObjects = false;
        
        for(Id soMod : objectsListModels){
            
            for(Attachment att : copyAttachmentIdList){
                Attachment attachment = new Attachment();
                System.debug('att' + att);
                attachment.Body = att.Body;
                attachment.Name = att.Name;
                attachment.ContentType = att.ContentType;
                attachment.ParentId = soMod;  
                attachmentUploadList.add(attachment);     
            }
        }
        for(showAttachmentModel sObj : sAttachmentModels)
        {
            sobj.ischecked = false;
        }
        
        try{
            insert attachmentUploadList;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Input value cannot be null'));
            return null;  
        }
        
        if(attachmentUploadList.isEmpty()){
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Record List is Empty....!!!')); 
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.CONFIRM, 'Successfully Copied File!')); 
        }
        return null;
        
    }
    
    public void showFile() {  isView = true; }
        
    public void closePreview() {  isView = false; }
      
    public void searchRecord(){
        makeSearchTrue = true;
        showObjectList();
    }
    
    public Class showAttachmentModel{
        public boolean ischecked {get;set;}
        public Attachment attach {get;set;} 
        public String fileExt {get;set;}
    }
    public class showObjectListModel{
        public boolean ischeckedbox {get;set;}
        public Account accountObject {get;set;}
        public Contact contactObject {get;set;}
        public Opportunity opportunityObject {get;set;}
        
        public showObjectListModel() {
            accountObject = new Account(); 
            contactObject = new Contact();
            opportunityObject = new Opportunity();
        }
          
    }
}