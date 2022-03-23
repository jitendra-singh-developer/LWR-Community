import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class CompA extends LightningElement {
    message = "Carry Upload New Video ....!!!";
    handleClick()
    {
        console.log("Publish show : ", this.message);
        pubsub.publish("show", this.message);
    }
}