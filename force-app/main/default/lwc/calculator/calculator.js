import { LightningElement } from 'lwc';
import {add,minus,multi,devide} from './calOperation'; 
export default class Calculator extends LightningElement {

 n1=null;
 n2=null;

 sum = null ;

 fetchN1(event){
        this.n1 = event.target.value;
 }

 fetchN2(event){
    this.n2 = event.target.value;
}
 
sum = add(this.n1,this.n2);

}
 /* add(){
   this.sum = (parseInt(this.n1) + parseInt(this.n2));
 }
 multi(){
    this.sum =(parseInt(this.n1) * parseInt(this.n2));
  }
  minus(){
    this.sum = (parseInt(this.n1) - parseInt(this.n2));
  }
  devide(){
     this.sum =(parseInt(this.n1) / parseInt(this.n2));
   }
   */