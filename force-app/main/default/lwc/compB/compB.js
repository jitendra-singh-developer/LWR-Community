import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class CompB extends LightningElement {
    connectedCallback()
    {
        this.showSubscribe();
    }
    
    catchMessage = "";

    showSubscribe(){
        pubsub.subscribe("show", message => {
                console.log("Catch Message : ", message);
                this.catchMessage = message;
        });
    }
}