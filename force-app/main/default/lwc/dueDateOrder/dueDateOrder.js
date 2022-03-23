import { LightningElement,track, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getDueDateOrders from '@salesforce/apex/DueDateOrderController.fetchDueDateOrders';
import sentMailToVendor from '@salesforce/apex/DueDateOrderController.sentMailToVendor'; 
import { ShowToastEvent } from 'lightning/platformShowToastEvent';  
export default class dueDateOrder extends LightningElement {

    @api recordId;
    accountId = this.recordId;
    
    
    dueOrderFile;

    dueOrderList= null;
    columns = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Orde Number', fieldName: 'OrderNumber' },
        { label: 'Order Start Date', fieldName: 'EffectiveDate' },
        { label: 'Order Due Date', fieldName: 'Due_Date__c' },
        { label: 'Amount', fieldName: 'Amount__c' },
        { label: 'Status', fieldName: 'Status' },
        { label: 'Comment',type :'Text' ,value:' ' }
        
    ];

    
    
   
    @wire(getDueDateOrders,{recordId : '$recordId'})
    wiredData({ error, data }) {
      if (data) {
        this.dueOrderList = data;
        console.log('Data is --->', data);
        console.log('recordId 3'+ this.recordId);
      } else if (error) {
        console.error('Error:', error);
      }
    }
   
 
     @track isModalOpen = false;
     openModal() {
     
        this.isModalOpen = true;
     }
     closeModal() {
      
         this.isModalOpen = false;
     }

    submitDetails() {
           
           
    
            console.log('!!!!! send to vender'+ this.dueOrderList + 'hello dekh bhai');
            if(this.dueOrderList != null){

              sentMailToVendor({dueOrderList : this.dueOrderList})
              .then(result => {
                  console.log('chal rha hai'+ result);
                  if(result == 'Success'){

                  
                      const evt = new ShowToastEvent({
                          title: 'Success',
                          message: 'Email Successfully Sent To Vendor',
                          variant: 'Success',
                          mode: 'dismissable'
                      });
                      this.dispatchEvent(evt);
                  }else if(result == 'error'){

                    const evt = new ShowToastEvent({
                      title: 'Error',
                      message: 'Something went wrong',
                      variant: 'error',
                      mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);


                  }
                  
              })
              .catch(error => {
                 console.log('error me chal rha hai');
              });

            }
            
        
         this.isModalOpen = false;
        }
}