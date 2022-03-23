public class AccountContactDetailSobjectController {

    public String sObjObject {get;set;}
    String query {get;set;}
    
    public List<sObject> getRecord(){
        query = 'Select Id, Name , Phone from '+ sObjObject;
        return Database.query(query);
    }

    
}