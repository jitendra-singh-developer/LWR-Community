global class RouteStationsRourseController {
    
    public static final String CONSUMER_KEY = '3MVG9fe4g9fhX0E7yg9kFQMesp5g9fKkq.WEWTFBLT3pTm4Ikmiypl_dwmNZya7_I.0i1Z9Dj3meY14LuLE_n';
    public static final String CONSUMER_SECRET = '41B78717A8D964596FFAD50D86DD94BEE8AAF751985BDE8914AF090FC48D8A37';
    public static final String USERNAME = 'practice@ibirds.com';
    public static final String PASSWORD = 'ibirds123ObzGfScg77flp98VF5Nt8BZE';
   
    global static void sentRouteStationsToTargetObject(){
        
        List<Route_Station__c> routeStationList = [select Id, Name, Previous_Station__c, Main_Route__c from Route_Station__c];
        AccessTokenWrapper atw = generateToken();
        if(atw != null && atw.access_token != null){
            String requestBody = JSON.serialize(routeStationList);
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            request.setBody(requestBody);
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer'+ atw.access_token);
            request.setHeader('Authorization', 'OAuth '+ atw.access_token);  
            request.setHeader('Content-type', 'application/json');
            request.setHeader('Accept', 'application/json');
            request.setEndpoint('https://ibirds-6d-dev-ed.my.salesforce.com/services/apexrest/v1/RouteStationController/');
            HTTPResponse response = http.send(request);
            
        }
    }
    
     public static AccessTokenWrapper generateToken(){
        
        String requestBody = 'grant_type=password&client_id='+CONSUMER_KEY+'&client_secret='+CONSUMER_SECRET+'&username='+USERNAME+'&password='+PASSWORD;
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setBody(requestBody);
        request.setMethod('POST');
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HTTPResponse response =  Http.send(request);
        if(response.getStatusCode() == 200){
            return (AccessTokenWrapper) System.JSON.deserialize(response.getBody(), AccessTokenWrapper.class);
        }
        else{
            return null;
        }  
        
    }
    
    public class AccessTokenWrapper{
        
        public String access_token;
        public String id;
        public String instance_url;
        public String token_type;
        public String issued_at;
        public String signature;
    }   
}