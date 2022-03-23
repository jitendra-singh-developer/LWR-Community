/*
Name        : GetParamFromTargetOrg
Date        : 19 March, 2021
Author      : Jitendra Singh
Description : This is a controller which is used to get value reqest from another org (Rest API)
and return result according to their requirement.
*/

@RestResource(urlMapping='/v1/getparameterfromtargetorg/*')
global class GetParameterFromTargetOrg{
    
    @Httppost
    global static SendResponseWrapper sendResponse(){
        RestRequest  req = RestContext.request;
        String requestBody = RestContext.request.requestBody.toString();
        System.debug('Request &&&&&&&&&&&&&&&7'+ requestBody);
        
        
        
        String cities = requestBody;
        
        
        TargeOrgObjectWrapper customObject = (TargeOrgObjectWrapper) JSON.deserialize(requestBody, TargeOrgObjectWrapper.class);
        System.debug('costomObject'+ customObject);
        String fromCity = customObject.place;
        String toCity = customObject.destination;
        System.debug('costomObject'+ fromCity);
        System.debug('costomObject'+ toCity);
        
        
        String routeName = '';
        Integer distance = 0;
        String routeDistanceValue = routeName+','+distance;
        
        if(fromCity != '' && toCity != ''){
            
            
            List<Route_Station__c> routeStationCities = [select Id, Name, Previous_Station__r.Name, Main_Route__r.Name, Distance__c 
                                                         from Route_Station__c where Name = : fromCity or Name = : toCity Order 
                                                         by CreatedDate];
            
            
            if(routeStationCities.size() > 2 ){
                
                
                Boolean isAllow = false;
                List<Route_Station__c> routeStations = new List<Route_Station__c>();
                for(Route_Station__c  route: routeStationCities){
                    if(routeStations.size() > 0){
                        if(routeStations.get(0).Main_Route__r.Name == route.Main_Route__r.Name){
                            routeStations.add(route);
                            isAllow = true;
                            break;
                        }
                        else{
                            routeStations.clear();
                            routeStations.add(route);
                            isAllow = false;
                        }
                    }else{
                        routeStations.add(route);
                        isAllow = false;
                    }    
                }
                if(fromCity == toCity){
                    routeName = routeStations.get(0).Main_Route__r.Name;
                }
                
                if(isAllow){
                    routeName = routeStations.get(0).Main_Route__r.Name; 
                    distance = fetchDistance(routeName, fromCity , toCity);
                    
                }
                
                
                routeDistanceValue = routeName +','+ distance;
                
            }
            
            //
            else if(routeStationCities.size() == 0 || (routeStationCities.size() == 2 && 
                                                       (routeStationCities.get(0).Main_Route__r != routeStationCities.get(1).Main_Route__r))){
                                                           routeDistanceValue = routeName+','+distance;
                                                           
                                                       }
            
            //
            else if(routeStationCities.size() == 1){
                if(fromCity == toCity){
                    routeName = routeStationCities.get(0).Main_Route__r.Name;
                    routeDistanceValue = routeName +','+ distance;     
                }else{
                    routeDistanceValue = routeName +','+ distance;   
                }
                
            }
            
            //
            else if(routeStationCities.size() == 2 && (routeStationCities.get(0).Main_Route__r == routeStationCities.get(1).Main_Route__r)){
                routeName = routeStationCities.get(0).Main_Route__r.Name;
                distance = fetchDistance(routeName, fromCity , toCity);    
            }
            
        }
        SendResponseWrapper sendResponceObject = new SendResponseWrapper(distance,routeName);
        System.debug('SendObject'+ sendResponceObject);
        String  sendResponce = JSON.serialize(sendResponceObject);
        System.debug('SendResponce'+ sendResponce);
        String demo = 'hello response';
        return sendResponceObject;    
        
    }
    //
    public static Integer fetchDistance(String routeName, String fromCity, String toCity){
        Integer distance = 0;
        String endCity;
        Boolean isTrue = false;
        
        List<Route_Station__c> routeStations = [select Id, Name, Previous_Station__r.Name, Main_Route__r.Name, Distance__c 
                                                from Route_Station__c Where Main_Route__r.Name = : routeName Order by createdDate];
        
        for(Route_Station__c route : routeStations){
            if(route.Previous_Station__r.Name == fromCity || route.Previous_Station__r.Name == toCity){
                if(route.Previous_Station__r.Name == fromCity){ 
                    endCity = toCity;  
                }else{
                    endCity = fromCity;
                }
                isTrue = true;
            }
            if(isTrue){
                distance = (Integer)(distance + route.Distance__c);  
            } 
            if(route.Name == endCity  ){ 
                break;
            }
        }
        return distance;
    } 
    global class SendResponseWrapper{
        public Decimal distance;
        public String route;
        public SendResponseWrapper(Decimal tempDistance, String tempRoute){
            distance = tempDistance;
            route = tempRoute;
        }
        
    }  
    
    
    global class TargeOrgObjectWrapper{
        public String place;	//Ajmer
        public String destination;	//Jaipur
    }
}