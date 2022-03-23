import { LightningElement, wire } from 'lwc';
import getAccount from '@salesforce/apex/AccountRecordsController.getAccount';
import getAccountList from '@salesforce/apex/AccountRecordsController.getAccountList';
export default class AccountRecords extends LightningElement {

  @wire(getAccount)
  accountName;

  @wire(getAccountList)
  accountListObj;
  

}