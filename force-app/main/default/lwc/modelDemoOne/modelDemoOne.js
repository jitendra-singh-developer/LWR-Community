import { LightningElement,track } from 'lwc';
export default class ModalPopupLWC extends LightningElement {
    //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
    @track isPartCasualModelOpen = false;
    @track str = 'slds-box boxPadding';
    
    @track  currentStep = 2;
    @track isStepOne = true;
    @track isStepTWo = false;
    @track isStepThree = false;
    isStepFour= false;
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isPartCasualModelOpen = true;
    }
    isPartCasualModelOpen() {
        // to close modal set isModalOpen tarck value as false
        this.isPartCasualModelOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isPartCasualModelOpen = false;
    }
    callFun(){
        console.log('Fun Called');
       /* let tempArr = this.str.split(' ');
        tempArr.forEach((element)=>{
            if(element != 'boxBorder'){
                this.str = this.str + element;
            }else{
                this.str   = this.str + ' boxBorder';
                
            }
        })*/
       // this.str   = this.str + ' boxBorder';
        this.currentStep = this.currentStep + 1;
       
       
        console.log('str'+ this.str);
    }
    handleOnStepClick(event){
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