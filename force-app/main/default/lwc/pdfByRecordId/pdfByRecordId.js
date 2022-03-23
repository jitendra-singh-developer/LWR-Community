import { LightningElement, api, track, wire } from 'lwc';
import getRelatedFilesByRecordId from '@salesforce/apex/PDFViewerController.getRelatedFilesByRecordId';

export default class PdfByRecordId extends LightningElement {
    // Current record ID. *recordId* is a reserved identifier
    @api recordId= "0035g000002rEeSAAU"
    // Declare to pass heightInRem to the child component in markup
    @api heightInRem;
    @track error;
    // Specify which file for child component to render
    @track fileID;
    pdfFiles = [];

    url

    @wire(getRelatedFilesByRecordId, { recordId: '$recordId' })
    wiredFieldValue({ error, data }) {
        if (data) {
            this.pdfFiles = data;
            this.error = undefined;
            // Save the first related PDF's file ID to fileID            
            const fileIDs = Object.keys(data);
            this.fileID =  fileIDs.length ? fileIDs[0] : undefined; 

            this.url = '/sfc/servlet.shepherd/document/download/'+this.fileID;
        } else if (error) {
            this.error = error;
            this.pdfFiles = undefined; 
            this.fileID = undefined; 
        }
    }

    // Maps file ID and title to tab value and label
    get tabs() {
        if (!this.fileID) return [];

        const tabs = [];
        const files = Object.entries(this.pdfFiles);
        for (const [ID, title] of files) {
            tabs.push({
                value: ID,
                label: title
            });
        }        
        return tabs;
    }

    // event handler for each tab: onclick tab, change fileID
    setFileID(e) {
        this.fileID = e.target.value;
    }
}