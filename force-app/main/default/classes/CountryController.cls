public class CountryController {
    
    public List<SelectOption> CountryOptions {get;set;}
    public String SelectedCountry {get;set;}
    public List<SelectOption> stateOptions {get;set;}
    public String selectedState {get;set;}
    public List<SelectOption> CityOptions {get;set;}
    public List<String> Countries {get;set;}
    
    public Map<String,List<String>> StateMap;
    public List<String> City {get;set;}
    public Map<String,List<String>> CityMap;
    public String selectedCity {get;set;}
    
    public CountryController()
    {
        loadCountryData();
        loadStateData();
      
    }
    private void loadCityData()
    {
        CityMap = new Map<String,List<String>>();
        CityMap.put('Rajasthan', new List<String>{'Ajmer','Jaipur','Alwar','Bikaner','Pali'});
        CityMap.put('Uttar Pradesh', new List<String>{'Agra','Aligarh','Allahabad','Amethi','Azamgarh'});
        CityMap.put('Madhay Pradesh', new List<String>{'Bhopal','Indore','Jabalpur','Ujjain','Sagar'});
        CityMap.put('Maharashtra', new List<String>{'Mumbai','Pune','Nagpur','Kohlapur','Thane'});
        CityMap.put('Punjab', new List<String>{'Amritsar','Ludhuyana','Jhalandar','Patiyala','Pathankot'});
        CityMap.put('California', new List<String>{'Los Anjlos','San Fransisco','Freshsho','Oakland','San Jose'});
        CityMap.put('Florida', new List<String>{'Miami','Orlando','Thampa','Neples','Sarasota'});
        CityMap.put('Virginia', new List<String>{'Richmand','Virginia Beach','Norfolk','Roanoke','Alexandria'});
        CityMap.put('Alaska', new List<String>{'Anchorage','Juneau','Sitka','North Pole','Homer'});
        CityMap.put('Texas', new List<String>{'Houston','Austin','San Entonio','Texes City','Ford Worth'});
        CityMap.put('Bashkortostan', new List<String>{'Los Anjlos','San Fransisco','Freshsho','Oakland','San Jose'});
        CityMap.put('Buryat', new List<String>{'Miami','Orlando','Thampa','Neples','Sarasota'});
        CityMap.put('Chechnya', new List<String>{'Richmand','Virginia Beach','Norfolk','Roanoke','Alexandria'});
        CityMap.put('Dagestan', new List<String>{'Anchorage','Juneau','Sitka','North Pole','Homer'});
        CityMap.put('Ingushetia', new List<String>{'Houston','Austin','San Entonio','Texes City','Ford Worth'});
        CityMap.put('Hokkaidō', new List<String>{'Los Anjlos','San Fransisco','Freshsho','Oakland','San Jose'});
        CityMap.put('Aomori', new List<String>{'Miami','Orlando','Thampa','Neples','Sarasota'});
        CityMap.put('Iwate', new List<String>{'Richmand','Virginia Beach','Norfolk','Roanoke','Alexandria'});
        CityMap.put('Miyagi', new List<String>{'Anchorage','Juneau','Sitka','North Pole','Homer'});
        CityMap.put('Yamagata', new List<String>{'Houston','Austin','San Entonio','Texes City','Ford Worth'});
        selectedState = '';
    }
    private void loadStateData()
    {
        StateMap = new Map<String,List<String>>();
        StateMap.put('India', new List<String>{'Rajasthan','Uttar Pradesh','Madhay Pradesh','Maharashtra','Punjab'});
        StateMap.put('USA', new List<String>{'California','Florida','Virginia','Alaska','Texas'});
        StateMap.put('Russia', new List<String>{'Bashkortostan','Buryat','Chechnya','Dagestan','Ingushetia'});
        StateMap.put('Japan', new List<String>{'Hokkaidō','Aomori','Iwate','Miyagi','Yamagata'});
        
        selectedState = '';
    }
    private void loadCountryData()
    {
        countries = new List<String>{ '--None--','India','USA',
            'Russia','Japan'};
        loadCountries();
    }
    private void loadCountries()
    {
        CountryOptions = new List<selectOption>();
        for(String country : Countries)
        {
            CountryOptions.add(new SelectOption(country , country));
        }
        
        SelectedCountry = '';
       	 
    }
    
    
    public void fetchState()
    {   
        loadCityData();
        List<String> States = StateMap.get(selectedCountry);
        StateOptions = new List<selectOption>();
        if(StateMap.containsKey(selectedCountry))
        {
            for(String State : States)
            {
                StateOptions.add(new SelectOption(state , state));
            }
        }
        else
        {
            selectedState = '';
            fetchCity();
        }
     
    }
    public void fetchCity()
    {
        List<String> Cities = CityMap.get(selectedState);
        CityOptions = new List<selectOption>();
        if(CityMap.containsKey(selectedState))
        {
            for(String City :  Cities)
            {
                CityOptions.add(new SelectOption(city , city));
            }
        }
    }
    
}