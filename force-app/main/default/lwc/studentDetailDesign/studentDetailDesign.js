import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class StudentDetailDesign extends LightningElement {

    connectedCallback()
    {
        this.showSubscribe();
        
    }
    
    studentsProfile ;

    showProfileSubscribe(){
        pubsub.subscribe("show", studentProfile => {
                console.log("Catch Message : ", studentProfile);
                this.studentProfile = studentProfile;
        });
    }

}