import { LightningElement ,api } from 'lwc';

export default class DaughterComponent extends LightningElement {

    

    handleClick(){

      const custEvent = new CustomEvent(
        'callpasstoparent', {
         detail : 'Miss You Bhaiya'
        });
    this.dispatchEvent(custEvent);


    }
}