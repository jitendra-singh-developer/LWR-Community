public class StudentDomUpgradeController {
    
    public List<StudentModel> studentModels {get;set;}  
    public List<Student__c> checkedList ;
    public List<Attachment> attachmentList;
    public List<Student__c> studentList {get;set;}
    public List<Student__c> idiesList;
    public Map<Id,Attachment> attachmentMap;
    public Map<Id,Student__c> studentMap ;
    public StudentDomUpgradeController()
    {
        Integer i=0;
        idiesList = new List<Student__c>();
        attachmentList = new List<Attachment>();
        studentModels = new List<StudentModel>();
        checkedList = new List<Student__c>();
        studentList = [Select Id, First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c,Married__c,WifeName__c,Husband_Name__c
                       From Student__c];
        studentMap = new Map<Id,Student__c>([Select Id, First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c,Married__c,WifeName__c,Husband_Name__c
                       From Student__c]);
        Set<Id> idiesSet = new Set<Id>();
       for(Student__c stList : studentList)
       {
           idiesSet.add(stList.id);
		}
  		
        //System.debug('idies list '+ idiesList);
        attachmentList = [select Id , parentId from Attachment where parentId in : idiesSet order by createdDate ];
        attachmentMap = new Map<Id,Attachment>([select Id , parentId from Attachment where parentId in : idiesSet order by createdDate ]);
        // System.debug('$$$$$$'+ attachmentList);
        
        
        for(Attachment con : attachmentList)
        {
             StudentModel cm = new StudentModel();
             // cm.isImage = false ;
         
                 	cm.attach = con; 
                    cm.isImage = true;  
                
            		cm.srNo = ++i;
            		cm.ischecked = false;
            		
            
            		studentModels.add(cm);
            
        }
        for(Student__c conn : studentList)
        {
              StudentModel cm = new StudentModel();
              cm.con = conn;
              studentModels.add(cm);
             
        }
        
       /*
        for(Student__c con : studentList)
        {
            StudentModel cm = new StudentModel();
              cm.isImage = false ;
            if(attachmentMap.get(con.Id) != null)
            {
                 	cm.attach = con.Id ; 
                    cm.isImage = true;  
                    break;
                
            }
            System.debug('System print '+  attachmentMap.get(con.Id));
            cm.con = con;
            cm.srNo = ++i;
            cm.ischecked = false;
            
            
            studentModels.add(cm);
        }*/
        
      /*  for(Student__c con : studentList )
        {
            
            StudentModel cm = new StudentModel();
            cm.isImage = false ;
            for(Attachment att : attachmentList)
            {
                if(con.id == att.ParentId)
                {
                    // System.debug('parentId' + con.id +' '+ att.ParentId);
                    cm.attach = att; 
                    cm.isImage = true;  
                    break;
               
                   
                }
                
            }
            
            cm.con = con;
            cm.srNo = ++i;
            cm.ischecked = false;
            
            
            studentModels.add(cm);
            
            
            /* 
cm.isImage = false ;
if(con.attachments.size() != 0)
{
cm.attach = con.attachments[0];
cm.isImage = true;  
}

cm.con = con;
cm.srNo = ++i;
cm.ischecked = false;


studentModels.add(cm);*/
            
            
      //  } 
    } 
    
    public Class StudentModel
    {
        public Boolean ischecked {get;set;}
        public Integer srNo {get;set;}
        public Student__c con {get;set;}
        public boolean isImage {get;set;}
        public Attachment attach {get;set;}
        public Attachment attachment {get;set;}
       
        
        public StudentModel()
        {
            attachment = new Attachment();
        }
            
    }
     
    public PageReference save()
    {
        List<Attachment> uploadList = new List<Attachment>();
        for(StudentModel sm : studentModels)
        {
            
            
            if(sm.ischecked)
            {
          
                sm.attachment.ParentId = sm.con.Id;
                sm.attachment.ContentType = 'image/jpeg/';
  
                checkedList.add(sm.con);
                uploadList.add(sm.attachment);     
            }
            
        }
        
        upsert checkedList;
        upsert uploadList;
        PageReference pg = new PageReference('/apex/StudentDomUpgrade');
        pg.setRedirect(True);
        return pg;
        
    }
    
    public void addRow()
    {
        
    }
    
    
    
    
    
    
    
    
    
    
}