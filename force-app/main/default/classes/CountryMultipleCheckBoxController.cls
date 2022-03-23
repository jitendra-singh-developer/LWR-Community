public class CountryMultipleCheckBoxController {
    public Country__c country {get;set;}
    public boolean isAllChecked {get;set;}
    public List<CountryModel> countryModels {get;set;}
    public boolean isContactTrue {get;set;}
    public List<Country__c> countryList {get;set;}
    public Id sDelId {get;set;}
    public List<Country__c> delObjList {get;set;}
    public List<Integer> indNum {get;set;}
    public CountryMultipleCheckBoxController()
    {
        isContactTrue = false;
        indNum = new List<Integer>();
        delObjList = new List<Country__c>();
        isAllChecked = false;
     	countryModels = new List<CountryModel>();
        country = new Country__c();
        countryList = [select Id, Name , State__c , City__c from Country__c ];
        Integer i=0;
        for(Country__c cou: countryList)
        {
            CountryModel cm = new CountryModel();
            cm.conObj = cou;
            cm.ischecked = false;
            cm.srNum = ++i;
            countryModels.add(cm);
        }
    }
    
    public void save()
    {
      isContactTrue = true;
        insert country;
      // PageReference pg = new PageReference('/apex/CountryMultipleCheckboxPage');
      // pg.setRedirect(true);
     //  return pg;
	}
    public void deleta()
    {
        for(CountryModel con : countryModels)
        {
            if(con.conObj.id == sDelId)
            {
                delObjList.add(con.conObj);
                indNum.add(con.srNum - 1);
                System.debug('hello bro whats up');
                
            }
        }
     
        for(Integer ind : indNum)
        {
           
            countryModels.remove(ind);
           
        }
    }
    public void edita()
    {
        
    }
    public void editMul()
    {
        
    }
    public void delMul()
    {
        
    }
    public void submit()
    {
        delete delObjList;
    }
    public class CountryModel
    {
        public Country__c conObj {get;set;}
        public boolean ischecked {get;set;}
        public Integer srNum {get;set;}
    }
}