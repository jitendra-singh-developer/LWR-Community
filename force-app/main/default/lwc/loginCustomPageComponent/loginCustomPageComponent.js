import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import getParam from '@salesforce/apex/CustomLoginController.getParam';
export default class LoginCustomPageComponent extends LightningElement {

    currentPageReference = null; 
    urlStateParameters = null;
 
    /* Params from Url */
    urlId = null;
    urlLanguage = null;
    urlType = null;
    contactName = null;
 
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
          this.urlStateParameters = currentPageReference.state;
          getParam({ param :  this.urlStateParameters.product })
          .then(result => {
              console.log('result'+ result);
              this.contactName = result.Name;
          })
          .catch(error => {
              this.error = error;
              console.log(this.error);
          });
            }
          console.log('hello',this.urlStateParameters);
          this.setParametersBasedOnUrl();
       }
    
 
    setParametersBasedOnUrl() {
       this.urlId = this.urlStateParameters.id || null;
       this.urlLanguage = this.urlStateParameters.lang || null;
       this.urlType = this.urlStateParameters.type || null;
    }

}