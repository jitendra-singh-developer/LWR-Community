public inherited sharing class ContactRecordsController {
   
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
       
        return [Select Id, Name, Email, Phone, OtherCity from Contact ];

    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getCitiesList(){
       
        List<Contact> cityList =  [Select Id, OtherCity from Contact];
        List<Contact> cities = new List<Contact>();
        for(Contact city : cityList){

            if(!cities.contains(city)){
                cities.add(city);
            }
        }
        return cities;

    }

}