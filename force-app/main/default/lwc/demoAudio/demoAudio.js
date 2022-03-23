import { LightningElement, api, track } from 'lwc';

export default class DemoAudio extends LightningElement {
 
    @api mywidth = 50;
    @api myheight = 70;
    url;
    imagefolder = [];
    
    connectedCallback(){
        this.url = "https://picsum.photos/"+this.mywidth+'/'+this.myheight
        setTimeout(function(){
            window.location.reload();
         }, 10000);
    }

    @track selectedValue;
    handleChange(event){
        this.selectedValue =event.target.value;
    }
    refreshComponent(event){
        eval("$A.get('e.force:refreshView').fire();");
    }




}