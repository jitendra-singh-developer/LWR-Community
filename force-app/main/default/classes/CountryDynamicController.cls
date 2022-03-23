public class CountryDynamicController {
    Public List<Country__c> countries {get;set;}
    public List<Country__c> states {get;set;}
    public List<Country__c> cities {get;set;}
     
    public List<SelectOption> countryOptions {get;set;}
    public String selectedCountry {get;set;}
    public List<SelectOption> stateOptions {get;set;}
    public String selectedState {get;set;}
    public List<SelectOption> cityOptions {get;set;}
    //public List<String> Countries {get;set;}
    
    public Map<String,List<String>> StateMap;
    public List<String> City {get;set;}
    public Map<String,List<String>> CityMap;
    public String selectedCity {get;set;}
    
    public CountryDynamicController()
    {	
        countries = new List<Country__c>();
        loadCountryData();
     
        
	}
    public void loadCityData(String selectedState)
    {
        cities = [Select City__c From Country__c Where State__c = : SelectedState];
        System.debug('&&&&'+ cities);
	}
    public void loadStateData(String selectedCountry)
    {
        states = [Select State__c From Country__c Where Name = : selectedCountry];
        System.debug('&&&&'+ states);
	}
    public void fetchState()
    {
        loadStateData(selectedCountry);
        List<String> statesList = new List<String>();
       // List<String> StatesList = StateMap.get(selectedCountry);
        System.debug('&&&&&'+ statesList);
        for(Country__c state : states)
        {
            if(!statesList.contains(state.State__c))
            {
            	statesList.add(state.State__c);    
            }
            //statesList.add(state.State__c);
            
        }
       
        stateOptions = new List<selectOption>();
        cityOptions = new List<selectOption>();
      
            for(String state : statesList)
            {
                stateOptions.add(new SelectOption(state , state));
            }
        
       
          
           

	}
     public void fetchCity()
    {
         loadCityData(selectedState);
        List<String> cityList = new List<String>();
       // List<String> StatesList = StateMap.get(selectedCountry);
        System.debug('&&&&&'+ cityList);
        for(Country__c city : cities)
        {
            if(!CityList.contains(city.City__c))
            {
                CityList.add(city.City__c);   
            }
          
            
        }
       
        cityOptions = new List<selectOption>();
      
            for(String city : cityList)
            { 
               // if(!cityOptions.contains(city))
                cityOptions.add(new SelectOption(city , city));
            }
	}
    public void loadCountryData()
    {
        countries = [Select Name from Country__c];
        loadCountries();
    }
    public void loadCountries()
    {
          countryOptions = new List<selectOption>();
        for(Country__c country : countries)
        {
            if(!countryOptions.contains(new SelectOption(country.Name , country.Name)))
            {
            countryOptions.add(new SelectOption(country.Name , country.Name));
            }
        }
        
      
    }
    
}