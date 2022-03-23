public class NewController {
    @AuraEnabled
    public static Map<String,Object> retriveNews(){
        Http http = new Http();
        HttpRequest httpRequest = new HttpRequest();
       // httpRequest.setEndPoint('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ef030d9b488a4d55aaf6b55c57365650');
       httpRequest.setEndPoint('https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=ef030d9b488a4d55aaf6b55c57365650'); 
       httpRequest.setMethod('GET');
        
        Map<String,Object> newJsonData = new Map<String,Object>();
        String strResponse = null;
        try {
            HttpResponse response = http.send(httpRequest);
            if(response.getStatusCode() == 200){
                strResponse = response.getBody();
            }else{
                throw new CalloutException(response.getBody());
            }
        } catch (Exception ex) {

            throw ex;
            
        }
        if(!String.isBlank(strResponse)){
            newJsonData = (Map<String,Object>)JSON.deserializeUntyped(strResponse);

        }

        if(!newJsonData.isEmpty()){
            return newJsonData;
        }else{
            return null;
        }
    }
}