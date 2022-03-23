public class CountyMultipleController {
 	
    public List<Country__c> countries {get;set;}
    public List<Country__c> states {get;set;}
    public LIst<Country__c> cities {get;set;}
    
    public List<String> stateList {get;set;}
    public List<String> cityList {get;set;}
    
    public List<Country__c> countryList {get;set;}
    
    public List<SelectOption> countryOptions {get;set;}
    public List<SelectOption> stateOptions {get;set;}
    public List<SelectOption> cityOptions {get;set;}
    
    public String selectedCountry {get;set;}
    public String selectedState {get;set;}
    public String selectedCity {get;set;}
    
    public Map<String,List<String>> stateMap {get;set;}
    public Map<String,List<String>> cityMap {get;set;}
    
    public CountyMultipleController()
    {
        stateList = new List<String>();
        countryList = new List<Country__c>();
        countries = new List<Country__c>();
        loadCountryData();
	}
    public void loadCountryData()
    {
        countries = [Select Name from Country__c];
         loadCountry();
    }
    public void loadCountry()
    {
        countryOptions = new List<SelectOption>();
           for(Country__c country : countries)
        {
            if(!countryOptions.contains(new SelectOption(country.Name , country.Name)))
            {
            countryOptions.add(new SelectOption(country.Name , country.Name));
            }
        }
    }
    public void loadStateData()
    {
        states = [Select State__c from Country__c Where Name = : selectedCountry];
        for(Country__c state : states)
        {
            stateList.add(state.state__c);
        }
        stateMap = new Map<String , List<String>>();
        stateMap.put(selectedCountry, stateList);
        
        
    }
    public void loadCityData()
    {
        cities = [Select City__c from Country__c Where State__c = : selectedState ];
        for(Country__c city : cities)
        {
            cityList.add(city.City__c);
        }
        cityMap = new Map<String , List<String>>();
        cityMap.put(selectedState, cityList);
    }
    public void fetchState()
    {
        
    }
    public void save()
    {
        
    }
}