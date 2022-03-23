import { LightningElement, track, wire, api } from 'lwc';
import getCodeList from '@salesforce/apex/CodesUpdateController.fetchCodes';
import selectedObjectList from '@salesforce/apex/CodesUpdateController.fetchObjectList';
import { getRecord } from 'lightning/uiRecordApi';
import updateCodeRecords from '@salesforce/apex/CodesUpdateController.updateCodeRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CodesUpdateButton extends LightningElement {

    @api recordId;
    objectRecordList;
    sectionAData = [];
    codeList;
    sectionAList;
    sectionBList;
    recordList;
    @track sectionValue;
    @track value;
    @track selectSection;
    @track sectionAComboboxValue;
    @track sectionBComboboxValue;
    @track isModalOpen = false;
    @track isDisable = true;
    @track isOpenNextModal = false;
    @track selectObject = false;
    @track isNextDisable = true;
    @track isShowCombobox = true;
    @track isShowRecords = false;
    @track isRecordNextButtonDisable = true;
    @track isCodeUpdateModelOpen = false;
    @track isCodeUpdateButtonDisable = true;

    columns = [

        { label: 'MRI Name', fieldName: 'Name', type: 'Auto Number' },
        { label: 'Account Name', fieldName: 'Account__c' }
    ];

    openModal() {
        this.isShowCombobox = true;
        this.selectObject = true;
        this.isCodeUpdateModelOpen = false;
        this.isShowRecords = false;
    }

    closeModal() {
        this.selectObject = false;
    }
    get options() {
        return [
            { label: '-None-', value: '' },
            { label: 'MIR', value: 'MIR__c' },
            { label: 'KMDR', value: 'KMDR__c' }
        ];
    }

    get sectionABoxList() {
        var returnOptions = [];
        returnOptions.push({ label: '--None--', value: '' });
        try {
            for (let i = 0; i < this.sectionAList.length; i++) {

                returnOptions.push({ label: this.sectionAList[i].Name, value: this.sectionAList[i].Name });
            }
        } catch (Exception) {

        }
        return returnOptions;
    }

    get sectionBBoxList() {
        var returnOptions = [];
        returnOptions.push({ label: '--None--', value: '' });
        try {
            for (let i = 0; i < this.sectionBList.length; i++) {
                returnOptions.push({ label: this.sectionBList[i].Name, value: this.sectionBList[i].Name });
            }
        } catch (Exception) {

        }
        return returnOptions;
    }

    getData(event) {
        var removeIndex;
        var isDelete = false;

        if (this.sectionAData.length === 0) {
            this.sectionAData[0] = { code: event.target.value, codeName: event.target.title }
        } else {
            for (let i = 0; i < this.sectionAData.length; i++) {
                if (this.sectionAData[i].codeName === event.target.title) {
                    removeIndex = i;
                    isDelete = true;
                }
            }
            if(isDelete) 
            this.sectionAData.splice(removeIndex, 1); 
            this.sectionAData[this.sectionAData.length] = { code: event.target.value, codeName: event.target.title }
        }
        if (this.sectionAData.length > 0) {
            this.isCodeUpdateButtonDisable = false;
        }
        else {
            this.isCodeUpdateButtonDisable = true;
        }
    }

    nextProcess() {
        this.isModalOpen = true;
        var selectedObject = this.value;
        var accountId = this.recordId;
        this.isShowRecords = true;
        this.isShowCombobox = false;
        selectedObjectList({ objectName: selectedObject, recordId: accountId })
            .then(result => {
                console.log('result ==>' + result);
                this.objectRecordList = result;
            })
            .catch(error => {
                console.log('Coding eroor' + error);
            });
    }
    handleChange(event) {
        this.value = event.detail.value;

        if (this.value != '') {
            this.isNextDisable = false;
        } else {
            this.isNextDisable = true;
        }
    }

    getSelectedName(event) {
        var temperaryVar = 'empty';
        var selectedRecords = this.template.querySelector("lightning-datatable").getSelectedRows();
        this.isDisable = true;
        temperaryVar += selectedRecords;

        if (selectedRecords != null) {
            this.isDisable = false;
        }
        if (temperaryVar === 'empty') {
            this.isDisable = true;
        }
    }

    getSelectedRecords(event) {
        var temperaryVar = 'empty';
        var selectedRecords = this.template.querySelector("lightning-datatable").getSelectedRows();
        temperaryVar += selectedRecords;
        if (selectedRecords != null) {
            this.isRecordNextButtonDisable = false;
        }

        if (temperaryVar === 'empty') {
            this.isRecordNextButtonDisable = true;
        }
    }

    updateCodes() {

        var recordList = this.recordList;
        var recordDetails = JSON.stringify(this.sectionAData);
        updateCodeRecords({ recordList: recordList, recordDetails: recordDetails })
            .then(result => {
                console.log('result ==>' + result);
                this.selectObject = false;
                if (result === 'success') {
                    const evt = new ShowToastEvent({
                        title: 'Success',
                        message: 'Record Updated Successfully',
                        variant: 'success',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
                }
                if (result === 'error') {

                    const evt = new ShowToastEvent({
                        title: 'Error',
                        message: 'Something Went Wrong',
                        variant: 'error',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
                }
            })
            .catch(error => {
                console.log('Coding eroor2' + error);
            });
    }
    recordBackButton() {
        this.isShowRecords = false;
        this.isShowCombobox = true;
    }
    codeUpdateBackButton() {
        this.isShowRecords = true;
        this.isCodeUpdateModelOpen = false;
    }
    showCodeUpdateModel() {
        var selectedRecords = this.template.querySelector("lightning-datatable").getSelectedRows();
        this.recordList = selectedRecords;
        this.isShowRecords = false;
        getCodeList()
            .then(result => {
                console.log('result ==>' + result);
                this.codeList = result;
                this.sectionAList = this.codeList.filter(item => {
                    return item.Select_Section__c === 'Section A';

                })
                var tempVar = JSON.stringify(this.sectionAList);
                this.sectionBList = this.codeList.filter(item => {
                    return item.Select_Section__c === 'Section B';

                })
                this.codeList = result;
            })
            .catch(error => {
                console.log('Coding eroor1' + error);
            });
        this.isCodeUpdateModelOpen = true;
    }
}