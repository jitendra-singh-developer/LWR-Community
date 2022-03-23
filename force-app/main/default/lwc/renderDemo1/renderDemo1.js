import { LightningElement } from 'lwc';
import renderHTML1 from './renderHTML1.html';
import renderHTML2 from './renderHTML2.html';
import renderDemo1 from './renderDemo1.html';
export default class RenderDemo1 extends LightningElement {
		
		person = 'Father'
		temp
	
		buttonClick(){
				this.person = this.temp;
				
		}
		
		personClick(event){
				this.temp = event.target.value;
				console.log('what happaning', this.temp)
		}
		
		render(){				
			return this.person === 'Father'? renderDemo1 : this.person === 'Son' ? renderHTML1 : this.person === 'Daughter' ? renderHTML2 : renderDemo1;
				
		}
}