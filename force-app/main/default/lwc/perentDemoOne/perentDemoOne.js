import { LightningElement , api } from 'lwc';
export default class PerentDemoOne extends LightningElement {
    message='Or bhai' ;
		tempMessage ;
		messageFromChild ;
		fillMessage(event){
				this.tempMessage = event.target.value; 
				
				
		}
		buttonClick(){
				this.message += this.tempMessage;
				
				this.template.querySelector('.input1').value = null;
		}
		
		buttonParentClick(event){
				console.log(',',event.detail);
				this.messageFromChild += event.detail;
		}
}