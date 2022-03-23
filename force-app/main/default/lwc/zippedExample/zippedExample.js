/* eslint-disable no-console */
import { api, LightningElement } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ZIP from '@salesforce/resourceUrl/Zipper';

//zip.TextReader(text)

export default class CoastalZip extends LightningElement {

    @api header
    

    renderedCallback() { // invoke the method when component rendered or loaded
        
        Promise.all([
            loadScript(this, ZIP + '/gildas-lormeau-zip.js-3e79208/WebContent/zip.js'),
            loadScript(this, ZIP + '/gildas-lormeau-zip.js-3e79208/WebContent/inflate.js'),
            loadScript(this, ZIP + '/gildas-lormeau-zip.js-3e79208/WebContent/deflate.js'),
        ])
        .then(() => { 
            this.error = undefined; // scripts loaded successfully
           
            // eslint-disable-next-line no-undef
            this.Zip = zip  
            this.Zip.useWebWorkers = false

            this.initialize();
        })
        .catch(error => this.handleError(error))
    }

    async initialize(){

        console.dir('initialized this.Zip => ')
        console.dir(this.Zip)

    }

    handleClick(){

        // create the blob object storing the data to compress
        const data = new Blob([ this.getText() ], {
            type : "text/plain"
        })

        // creates a zip storing the file "lorem.txt" with blob as data
        // the zip will be stored into a Blob object (zippedBlob)
        this.zipBlob("lorem.txt", data, zippedBlob => {
            
            const a = document.createElement("a")
            console.log('zip file'+ a);
            //a.href = "data:text/csv;base64," + btoa(csv)
            a.href = URL.createObjectURL(zippedBlob);
            a.download = `CoastalZipper-${new Date().getTime()}`
            console.log('zip file'+ a.click);
            var zipfile = a.click();
            console.log('zipfile'+zipfile);

            // unzip the first file from zipped data stored in zippedBlob
            this.unzipBlob(zippedBlob, unzippedBlob => {
                // logs the uncompressed Blob
                console.log('unzipped Blob => ');
                console.log(unzippedBlob);
            });
        })
    }

        
    zipBlob(filename, blob, callback) {
        // use a zip.BlobWriter object to write zipped data into a Blob object
        this.Zip.createWriter(new this.Zip.BlobWriter("application/zip"), zipWriter => {
        // use a BlobReader object to read the data stored into blob variable
        
        zipWriter.add(filename, new this.Zip.BlobReader(blob), function() {
            // close the writer and calls callback function
            zipWriter.close(callback);
        });
        }, onerror);
    }
    
    unzipBlob(blob, callback) {
        // use a zip.BlobReader object to read zipped data stored into blob variable
        this.Zip.createReader(new this.Zip.BlobReader(blob), zipReader => {
            
            // get entries from the zip file
            zipReader.getEntries(function(entries) {
                // get data from the first file
                entries[0].getData(new this.Zip.BlobWriter("text/plain"), function(data) {
                    // close the reader and calls callback function with uncompressed data as parameter
                    zipReader.close();
                    callback(data);
                });
            })
        }, onerror);
    }
    
    onerror(message) {
        
        this.toast('', message, 'error')
    }

    toast(title = this.header, message, variant) {
        
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant,
            })
        )
    }

    getText(){
        return `route distance.html//--

        <template>
            <div class="carddiv">
                <div class="slds-grid slds-gutters">
                    <div class="icon-group slds-col slds-m-left_large">
                        <lightning-icon icon-name="utility:travel_and_places" class="util-icon slds-m-left_xx-small" onclick={fatchVehicle} title="60"></lightning-icon>
                        <lightning-icon icon-name="custom:custom36" class="slds-m-left_medium"  onclick={fatchVehicle} title="80" ></lightning-icon>
                        <lightning-icon icon-name="utility:trail" class="util-icon slds-m-left_medium"  onclick={fatchVehicle} title="10"></lightning-icon>
                        <lightning-icon icon-name="custom:custom80" class="slds-m-left_medium"  onclick={fatchVehicle} title="20"></lightning-icon>
                        <lightning-icon icon-name="custom:custom20" class="slds-m-left_medium"  onclick={fatchVehicle} title="700"></lightning-icon>
                    </div>
                </div>
                <div class="slds-grid slds-gutters">
                    <div class="slds-col slds-m-left_large slds-m-right_large">
                        <lightning-input type="text"  placeholder="Choose starting point" value={fromCity} onchange={fillFromCity}>
                        </lightning-input>
                    </div>
                </div>
        
                <div class="slds-grid slds-gutters">
                    <div class="slds-col slds-m-left_large slds-m-right_large">
                        <lightning-input type="text"  placeholder="Choose destination" value={toCity} onchange={fillToCity}>
                        </lightning-input>
                    </div>
                </div>
                <div class="slds-grid slds-gutters">
                    <div class="slds-col slds-m-left_large slds-m-right_large">
                        <button class="button-css slds-button slds-button_neutral slds-m-top_medium" onclick={searchClick} >Search</button>
                    </div>
                </div>
        </div>
        </template>
        
        
        //--------------------------------------------------------------------------
        
        RouteDistance.js
        
        import { LightningElement, track} from 'lwc';
        import getRouteStations from '@salesforce/apex/SendRequestToAnotherOrg.sendRequest';
        import pubsub from 'c/pubsub';
        //publisher
        export default class RouteDistance extends LightningElement{
        
            fromCity;
            toCity;
            vehicleSpeed;
            iconValue;
            distanceValue;
            route;
            spinnerVar = false;
            @track ruteObj = {
                speed     : this.vehicleSpeed,
                distance  : this.distanceValue,
                iconType  : this.iconValue,
                routeName : this.route,
                spinnerValue: this.spinnerVar
            }
        
            //Search button click functionP
            searchClick(){
               
                getRouteStations({place:this.fromCity , destination: this.toCity }).then(data => {
        
                    let index = data.indexOf(',');
                    this.ruteObj.routeName = data.substring(1,index);
                    this.ruteObj.distance = data.substring(index+1,data.length-1);
                    this.ruteObj.speed = 60;
                    this.ruteObj.iconType = 'utility:travel_and_places';
                    this.ruteObj.spinnerValue = true;
                    //publish
                    pubsub.publish("show", this.ruteObj);
        
                }).catch(error => {
                        console.log('Error',error);
                });
            }
        
            fatchVehicle(event){
                this.ruteObj.speed = event.target.title;
                this.ruteObj.iconType = event.target.iconName;
                //publish
                pubsub.publish("show", this.ruteObj);
            }
            
            //Fill from city
            fillFromCity(event){
                this.fromCity = event.target.value.trim();
            }
        
            //Fill to city
            fillToCity(event){
                this.toCity = event.target.value.trim();
            }
        }
        
        
        //-------------------------------------------------------------------------------
        
        routedetails.html
        
        
        <template>
            
            <lightning-card if:true={distance}>
                <div class="slds-grid slds-gutters">
                    <div class="slds-col slds-m-left_large ">
                        <lightning-icon icon-name={iconType} class="slds-m-left_xx-small"></lightning-icon>
                    </div>
                    <div class="slds-col slds-m-left_x-large" if:true={route}>
                        <span style="font-size:20px;color:#1A73E8;">via {route}</span>
                    </div>
                    <div class="slds-col slds-m-left_xx-large" if:true={route} >
                        <span if:true={hours} style="color:#f87814;font-size:15px;"><b> {hours} h </b></span> 
                        <span style="color:#f87814;font-size:15px;"><b>{minute} min</b></span>
                    </div>
                </div>
                <div class="slds-grid slds-gutters ">
                    <div class="slds-col slds-m-left_xx-large">
                    </div>
                    <div class="slds-col">
                        {detail}
                    </div>
                    <div class="slds-col"  if:true={route}>
                        <b>{distance} Km</b>
                    </div>
                </div>
            </lightning-card>
        </template>
        
        
        RouteDetails.js
        
        //--------------------------------------------------------------------------------------------------
        import { LightningElement} from 'lwc';
        import pubsub from 'c/pubsub';
        //subscribe
        export default class RouteDetails extends LightningElement {
        
            connectedCallback()
            {
                this.showSubscribe();
            }
            
            speed; 
            distance;
            route = '';
            hours;
            minute;
            iconType;
            detail = '';
            spinnerVar;
        
            showSubscribe(){
        
                pubsub.subscribe("show", ruteObj => {
                        this.speed = ruteObj.speed;
                        this.route = ruteObj.routeName;
                        
                        if(ruteObj.routeName == ''){
                            this.detail = 'Route not found.';  
                        }else{
                            this.detail = 'Fastest route despite the usual traffic'; 
                        }
                        this.distance = ruteObj.distance;
                        this.iconType = ruteObj.iconType;
                        this.spinnerVar = ruteObj.spinnerValue;
                    
                });
            }
            
            renderedCallback(){
                this.hours = parseInt(this.distance / this.speed);
                this.minute = parseInt(((this.distance % this.speed) * 60) / this.speed);
                
            }
        }
        //------------------------------------------------------------------------------------------
        
        
        routeDistance.css
        
        
        .carddiv{
            background:#1a73e8;
            height:240px;
        }
        .icon-group{
            margin-top:20px;
        }
        .util-icon{
          background:white;
        }
        .button-css:hover{
          background:rgb(232, 238, 237);
        }
        lightning-icon{
          
           color:white;
           border-radius: 61px;
           width:45px;
           padding-top:7px;
           padding-left:6.5px;
           height:45px;
           
        }
        lightning-icon:hover {
            cursor: pointer;
        }
        
        .search-button:hover{
            background-color: white;
        }
        
        
        //-----------------------------------------------------------------------------------------------
        
        
        routeDetails.css
        
        
          lightning-icon{
             border :1px solid black;
             border-radius: 61px;
             width:45px;
             padding-top:7px;
             padding-left:6.5px;
             height:45px;
             
          }
          
         //----------------------------------------------------------------------------------------------- 
        
        
        
        controller//---------------
        
        
        /*
                Name       : sendParametersToAnoutherOrg
                Date       : 19 march 2021
                Author     : Rahul Vaishnav
                Discretion : Send request to another org and get the route name and distance. 
        */
        global with sharing class SendRequestToAnotherOrg {
        
            public static final String CONSUMER_KEY = '3MVG9fe4g9fhX0E5rRIp31ux1xc.qVkxQkbWg7oK7FDWva6qMZ9A6IaRFlvGDKXwQSvfZwSpwKY2mD0R5_yZC';
            public static final String CONSUMER_SECRET = '0EFBF5790F8A8C9A06C796B16026035A81D001C3674F8CE48F540BC5DDA88233';
            public static final String USERNAME = 'jitendrasingh1304082@gmail.com';
            public static final String PASSWORD = 'ibirds123SIlUkv4eVv6Zvlpec889UKWZU';
               
            
            @AuraEnabled(cacheable = true)
            global static String sendRequest(String place, String destination){
        
                  String routeDetails;
                AccessTokenWrapper atw = generateToken();
                if(atw != null){
                    HTTP http = new HTTP();
                    HTTPRequest request = new HTTPRequest();
                    String citysNames = place + ',' + destination;
                    request.setBody(citysNames);
                    request.setMethod('POST');
                    request.setHeader('Authorization', 'Bearer' + atw.access_token);
                    request.setHeader('Authorization', 'OAuth ' + atw.access_token);  
                    request.setHeader('Content-type', 'application/json');
                    request.setHeader('Accept', 'application/json');
                    request.setEndpoint('https://ibirdssoftwareservices8-dev-ed.my.salesforce.com/services/apexrest/v1/GetParameterFromTargetOrg/');
                    HTTPResponse response = http.send(request);
                   
                    routeDetails = response.getBody();
                  
                }
                 return routeDetails;
          
            }
            
             public static AccessTokenWrapper generateToken(){
                
                String requestBody = 'grant_type=password&client_id=' + CONSUMER_KEY + '&client_secret=' + CONSUMER_SECRET + '&username=' + USERNAME + '&password=' + PASSWORD;
                HTTP http = new HTTP();
                HTTPRequest request = new HTTPRequest();
                request.setBody(requestBody);
                request.setMethod('GET');
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
        }`
    }
}