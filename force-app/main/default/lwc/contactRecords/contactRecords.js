import { LightningElement ,wire , track } from 'lwc';
import getContactList  from '@salesforce/apex/ContactRecordsController.getContactList';
import getCitiesList  from '@salesforce/apex/ContactRecordsController.getCitiesList';


export default class ContactRecords extends LightningElement {
    
    

   contactList ;
   contacts;

    @wire(getContactList, {})
    contactData ({error, data}) {
        if (error) {
            console.log('ye to error hai bhai')
        } else if (data) {
            this.contactList = data;
            this.contacts = data;
        }
    }

    

    value = 'All City';

    @wire(getCitiesList)
    cities;

    get options() {
       
        return [
            { label: 'Ajmer', value: 'Ajmer' },
            { label: 'Jaipur', value: 'Jaipur' },
            { label: 'Kota', value: 'Kota' },
            { label: 'Jodhpur', value: 'Jodhpur' },
            {label: 'Lawrence', value: 'Lawrence'},
            {label: 'Paris', value: 'Paris'},
        ];
       

    }

     @track columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email' },
        { label: 'Phone', fieldName: 'Phone' },
        { label: 'City', fieldName: 'OtherCity' }
       
    ];

    handleChange(event) {
        this.value = event.target.value;
        this.contactList = this.contacts.filter(item => {
            console.log(item.OtherCity);
            return item.OtherCity === this.value;

        })
        
    }

}