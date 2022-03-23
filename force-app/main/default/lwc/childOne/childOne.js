import { LightningElement, api } from 'lwc';
export default class ChildOne extends LightningElement {
	  message = 'Hello Lwc Kese ho, This message is pass from Child to parent using Custom Event !!!';
		@api parentmessage
		
		buttonClick(){
			
				const myevent = new CustomEvent('message',{detail : this.message},
																			 bubbles = 'true',
																			 composed = 'true');
				this.dispatchEvent(myevent);
			
		}
		
}