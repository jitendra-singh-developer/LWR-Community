/*****************
Org A (Source Org) 
*****************/

public class SH_AccountCreateAPI {
    //Write below clientId, clientSecret, username, password (combination of password and security token) from Org B (Target Org)
    private static String clientId = '3MVG9fe4g9fhX0E5mVZ0e98twL1c_nVdwjxnFWZdlBwii27ysUtFt1Nz_KffVH25a_Go2hjw7ZYM3SSH0uWvp';
    private static String clientSecret = 'C25FB9A3F56C2816DF86CB35E9E05D2757FC64AB4FE4D7274510FFC6E1ABE65A';
    private static String username = 'itszean25@gmail.com';
    private static String password = 'TheZean2Org';
    
    public class resWrapper
    {
        public String id;
        public String access_token;
    }
    public class accountWrap{
        public string case_region;
        public String wName;
        public String wPhone;
        public accountWrap(String name,String phone)
        {
            this.wName =name;
            this.wPhone =phone;
        } 
    }
    public String getRequestToken(SH_AccountCreateAPI accnt){
        String reqbody = 'grant_type=password'+'&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        Http h1 = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://ibirdssoftwareservices-5e-dev-ed.lightning.force.com/services/oauth2/token');
        HttpResponse res = h1.send(req);
        resWrapper response = (resWrapper)JSON.deserialize(res.getBody(),resWrapper.class);
        System.debug('response--->>>'+response);
        return response.access_token;
    }
    @future(callout=true)
    public static void createAccountMethod(Set<id> accIdSet){
        SH_AccountCreateAPI accnt = new SH_AccountCreateAPI();
        String accessToken;
        String JSNBody;
        accessToken = accnt.getRequestToken(accnt);
        List<Account> accList = new List<Account>();
        if(accessToken != null) {
            //Set Endpoint URL Of the Target Org Webservice Class
            String endPoint = 'https://ibirdssoftwareservices-5e-dev-ed.lightning.force.com/services/apexrest/v1/accountRecordCreate/';  
            For(Account acc:[SELECT Id, Name, Phone FROM Account WHERE Id IN: accIdSet]){
                accList.add(acc);
                if(accList.size() > 0)
                {
                    accountWrap accObj = new accountWrap(accList[0].name ,accList[0].phone );
                     JSNBody = JSON.serialize(accObj);
                }  
                    Http h2 = new Http();
                    HttpRequest req1 = new HttpRequest();
                    req1.setHeader('Authorization','Bearer ' + accessToken);
                    req1.setHeader('Content-Type','application/json');
                    req1.setHeader('accept','application/json');
                    req1.setMethod('POST');
                    req1.setBody(JSNBody);
                    System.debug('body--->>'+JSNBody);
                    req1.setEndpoint(endPoint);
                    HttpResponse res1 = h2.send(req1);
                    
                }
            }
            
        }
    }