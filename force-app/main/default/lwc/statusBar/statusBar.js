import { LightningElement, wire, api} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getProjectObj from '@salesforce/apex/StatusBarController.getProjectObj';
import status from '@salesforce/schema/Project__c.Status__c';
export default class StatusBar extends LightningElement {


@api recordId;

@wire(getRecord, { recordId: '$recordId', fields : status })
projectStatus

get selectedPath(){
    return getFieldValue(this.projectStatus.data, status);

}



    
    






}