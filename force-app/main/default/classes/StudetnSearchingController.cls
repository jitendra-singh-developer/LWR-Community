public class StudetnSearchingController {
    
            public List<Student__c> students {get;set;}
            public String firstName {get;set;}
            // public Date DateofBirth   {get;set;}
            public String Operator {get;set;}
            // public Date value {get;set;}
            String name='';
            Public String condition {get;set;}
            public Student__c con {get;set;}
            public Student__c don {get;set;}
            String queryPart='' ;
            
    
    
    
    public StudetnSearchingController()
    {
        students = new List<Student__c>();
        students = [Select First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c From Student__c];
        con = new Student__c();
        don = new Student__c();
        // hasNoRecord = false ;
    }
    
    public void mySave()
    {
       /* try
        {
            upsert students;
        }
        catch(Exception e)
        {
            Apexpages.addMessages(e);        
        }*/
        
         if(!students.isEmpty()){
            upsert students;
        }
        
    }
    public void mySearch()
    {
        name = '%'+ firstName + '%';
        date data = don.Date_of_Birth__c;
        //  queryPart = 'Select First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c From Student__c Where';
        //  queryPart = queryPart +' First_Name__c Like : '+ ' name' ;
        // queryPart = queryPart + condition +' Date_of_Birth__c '+ Operator +' '+ 'don.Date_of_Birth__c';
        //System.debug(queryPart);=
        students = Database.query('Select First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c From Student__c Where First_Name__c Like : name '+ condition +' Date_of_Birth__c ' + Operator +' :'+  ' data'  );
        
        //hasNoRecord =  !students.isEmpty();
        /* switch on Operator{
when '=' {
if(condition == 'AND')
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
AND Date_of_Birth__c =: don.Date_of_Birth__c];

}
else
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
OR Date_of_Birth__c =: don.Date_of_Birth__c];
}
}
when '>' {
if(condition == 'AND')
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
AND Date_of_Birth__c >: don.Date_of_Birth__c];

}
else
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
OR Date_of_Birth__c >: don.Date_of_Birth__c];
}
}
when '<' {
if(condition == 'AND')
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
AND Date_of_Birth__c <: don.Date_of_Birth__c];

}
else
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
OR Date_of_Birth__c <: don.Date_of_Birth__c];
}
}
when '<=' {
if(condition == 'AND')
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
AND Date_of_Birth__c <=: don.Date_of_Birth__c];

}
else
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
OR Date_of_Birth__c <=: don.Date_of_Birth__c];
}
}
when '>=' {
if(condition == 'AND')
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
AND Date_of_Birth__c >=: don.Date_of_Birth__c];

}
else
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
OR Date_of_Birth__c >=: don.Date_of_Birth__c];
}
}
when '<>' {
if(condition == 'AND')
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
AND Date_of_Birth__c <>: don.Date_of_Birth__c];

}
else
{
students = [SELECT Id,First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c
FROM Student__c
WHERE First_Name__c Like: name
OR Date_of_Birth__c <>: don.Date_of_Birth__c];
}
}
}*/
        
    }
    
}