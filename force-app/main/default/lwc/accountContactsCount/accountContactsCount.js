import { LightningElement , wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountContactCountController.getAccountCountList';
export default class AccountContactsCount extends LightningElement {
 
    
    accountListObj
    
    isChecked = true;

    @wire(getAccountList)
    wiredData({ error, data }) {
      if (data) {
        console.log('Data', {...data});
        this.accountListObj = data;
      } else if (error) {
        console.error('Error:', error);
      }
    }
    
    checkedClick(event){
     this.isChecked = event.target.checked;
    }
    

   

}