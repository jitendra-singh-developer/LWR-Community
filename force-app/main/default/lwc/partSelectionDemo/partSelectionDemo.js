import { LightningElement,track, wire } from 'lwc';
import getWarrantyProductRecords from '@salesforce/apex/PartSelectionDemo.fetchWarrantyProductRecords';
export default class PartSelectionDemo extends LightningElement {
    //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
    @track isPartCasualModelOpen = false;
    @track str = 'slds-box boxPadding';
    
    @track  currentStep = 1;
    @track isStepOne = true;
    @track isStepTWo = false;
    @track isStepThree = false;
    @track isStepFour= false;
    @track warrantyProductList;


   

    connectedCallback(){
        console.log('productlist' , JSON.stringify(this.productList));
    }

    openModal() {
        // to open modal set isModalOpen tarck value as true
        
        getWarrantyProductRecords()
            .then(result => {
                this.warrantyProductList = result;
            })
            .catch(error => {
                this.error = error;
            });

      
        console.log('projwarrantyProductListducl', JSON.stringify(this.warrantyProductList))
        this.isPartCasualModelOpen = true;
        
    }
    closePartModelOpen() {
        // to close modal set isModalOpen tarck value as false
        this.isPartCasualModelOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isPartCasualModelOpen = false;
    }
    callFun(event){
        console.log('Fun Called');
    
    }

    handleOnStepClick(event){
        console.log('event', event.target.value);
        this.currentStep = event.target.value;
        if(this.currentStep == 1){
            this.isStepOne = true;
            this.isStepTWo = false;
            this.isStepThree = false;
            this.isStepFour = false;
        }else if(this.currentStep == 2){

            this.isStepOne = false;
            this.isStepTwo = true;
            this.isStepThree = false;
            this.isStepFour = false;
        }else if(this.currentStep == 3){

            this.isStepOne = false;
            this.isStepTWo = false;
            this.isStepThree = true;
            this.isStepFour = false;
            
        }else if(this.currentStep == 4){
            this.isStepOne = false;
            this.isStepTWo = false;
            this.isStepThree = false;
            this.isStepFour = true;
        }
    }
}