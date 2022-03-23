import { LightningElement, track } from 'lwc';

export default class FatherComponent extends LightningElement {

    @track message='hello4';

    passToParent(event){
        this.message = event.detail;
        console.log(this.message);
    }

}