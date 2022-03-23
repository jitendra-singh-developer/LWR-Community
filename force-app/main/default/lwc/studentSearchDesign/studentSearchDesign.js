import { LightningElement } from 'lwc';
import  pubsub from 'c/pubsub';

export default class StudentSearchDesign extends LightningElement {

    value ;

    message;

   
    handleClick(event)
    {
        this.value = event.target.value;
        this.message = this.value;
        console.log("Publish show : ", this.message);
        pubsub.publish("show", this.message);
    }

    get options(){

        return [
            {label : 'Ajmer', value : 'Ajmer'},
            {label : 'Jaipur' , value : 'Jaipur' },
            { label : 'Paris' , value : 'Paris'},
            {label : 'New York' , value : 'New York' }
        ];

    }

    

}