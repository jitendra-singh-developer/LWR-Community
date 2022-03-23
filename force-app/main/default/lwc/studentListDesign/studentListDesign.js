import { LightningElement , wire } from 'lwc';
import pubsub from 'c/pubsub';
import getStudnetList from '@salesforce/apex/StudentListDesignController.getStudnetList';

export default class studentListDesign extends LightningElement {
  
    
    
    catchMessage;

    showSubscribe(){
        pubsub.subscribe("show", message => {
                console.log("Catch Message : ", message);
                this.catchMessage = message;
        });
    }

    @wire(getStudnetList)
    studentList;

    

    studentProfiles;

    connectedCallback()
    {
        console.log('Heloo htis  is callback');
        
    }

   
    
    showStudentProfile()
    {
         
        this.showSubscribe();
        console.log(this.studentList)
    
        this.studentProfiles = studentList.data.filter(item => {
             
            return item.City__c === this.catchMessage;
        })
        pubsub.publish("showProfile", this.studentProfile);  
        
    }


}