import { LightningElement } from 'lwc';

export default class ParentCountry extends LightningElement {

     value = '';

    get options() {
        return [
            { label: 'India', value: 'India' },
            { label: 'China', value: 'China' },
            { label: 'Russia', value: 'Russia' },
              { label: 'America', value: 'America' },
            { label: 'Japan', value: 'Japan' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }


}