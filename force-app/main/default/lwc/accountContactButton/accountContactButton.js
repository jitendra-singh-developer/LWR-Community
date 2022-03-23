import { LightningElement,track,api,wire } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import addFilesToAccount from '@salesforce/apex/AccountContactButtonController.addFilesToAccount';
import getContactRecords from '@salesforce/apex/AccountContactButtonController.fetchContacts';
import contactFilesList from '@salesforce/apex/AccountContactButtonController.showAttachments';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class AccountContactButton extends LightningElement {

    

    @track isDisableNextButton = true;
    @track isDisableAddToAccountButton = true;

    contactList
    selectedContactFiles
    recordSet ;

    @track isShowFiles=false;
 
    columns = [
       
        { label: 'Contact Name', fieldName: 'Name' },
        { label: 'Owner Name', fieldName: 'Contact.Owner.Name' }
      
        
    ];

    filesColumn = [
        { label: 'Title', fieldName: 'Title' },
        { label:'File Size',fieldName:'ContentSize' }
        
      
        
    ];
    
    @api recordId;
    

    showFiles(){
        var selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows(); 
        contactFilesList({ contactList: selectedRecords })
        .then(result => {
           console.log('result ==>'+ result);
           this.selectedContactFiles = result;
           this.openFiles();
       
        })
        .catch(error => {
            console.log('Coding eroor'+ error);
        });
        this.isModalOpen = false;
    }

    getSelectedName(event){
        var temperaryVar = 'empty';
        var selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows();
        console.log('its calling2'+ selectedRecords);
        this.isDisableNextButton = true;
        this.isDisableAddToAccountButton = true;
        temperaryVar += selectedRecords;
       
        if(selectedRecords != null){
            this.isDisableNextButton = false;
            this.isDisableAddToAccountButton = false;
        }

        if(temperaryVar === 'empty'){
            this.isDisableNextButton = true; 
            this.isDisableAddToAccountButton = true;
            
        }
    }

    addToAccount(){

        var selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows();
        var accountId = this.recordId;
        addFilesToAccount({ contentVersionList: selectedRecords, recordId: accountId })
        .then(result => {

           console.log('result me hai bhai4'+ result);

           if(result==='success'){

            
            const evt = new ShowToastEvent({
                title: 'Success',
                message: 'Files successfully Added to Account',
                variant: 'Success',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);

           }else if(result==='error'){
            const evt = new ShowToastEvent({
                title: 'Error',
                message: 'Please select at least one files',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
           }
           this.closeFiles();
        })
        .catch(error => {
            console.log('eroor'+ error);
        });

    }
    
    
    @wire(getContactRecords, { recordId: '$recordId' } )
    getContacts ({error, data}) {
        if (error) {
            console.log('this is eroror');
        } else if (data) {
            console.log('this is data'+ data);
            this.contactList  = data; 
        }
    }

    openFiles(){
        this.isShowFiles = true;
        this.isDisableAddToAccountButton = true;
    }

    closeFiles(){
         this.isShowFiles = false;
    }

    @track isModalOpen = false;
    openModal() {
        this.isDisableNextButton = true;
        this.isModalOpen = true;
     }
     closeModal() {
      
         this.isModalOpen = false;
         
     }

   

}