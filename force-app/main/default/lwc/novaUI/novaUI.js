import { LightningElement, track } from 'lwc';

export default class NovaUI extends LightningElement {


    //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
    @track isModalOpen = false;
    @track mobileTemplate = false;
    @track webTemplate = false;
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
        if(window.screen.width < 768){
            this.mobileTemplate = true; 
        }else{
            this.webTemplate = true;
        }
        
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
        this.webTemplate = false;
        this.mobileTemplate = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        this.webTemplate = false;
        this.mobileTemplate = false;
    }

 

}