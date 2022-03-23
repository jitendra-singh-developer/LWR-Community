import {
    LightningElement
} from 'lwc';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';
export default class Notification extends LightningElement {
    showErrorToast() {
            const evt = new ShowToastEvent({
                title: 'Application Error',
                message: 'Something went wrong ',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
        }
}