import { LightningElement, api } from 'lwc';
export default class ParentOne extends LightningElement {
		message
		
		 msgforParent = 'Hello salesforce, This is pass from Parent to child through Attribute';
			buttonParentClick(event){
				console.log(',',event.detail);
				this.message = event.detail;
		}
}