import { LightningElement, api } from 'lwc';

export default class RichTextAreaComponent extends LightningElement {
    @api placeholder ;
    @api value;
    @api label ;
    @api required ;
}