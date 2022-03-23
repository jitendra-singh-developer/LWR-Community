import { LightningElement, api } from 'lwc';
export default class ChildDemoOne extends LightningElement {
		@api sendata ;
		message 
		fillMessaage(event){
				this.message = event.target.value;
					console.log('mesage', this.message);
				 event.target.value = null;
		}
		
		
		buttonClick(){
				this.message = this.template.querySelector('.demo').value;
				console.log('mesage', this.message);
				const myevent = new CustomEvent('message',{detail : this.message});
					this.template.querySelector('.demo').value = null;
				this.dispatchEvent(myevent);
			
		}
}