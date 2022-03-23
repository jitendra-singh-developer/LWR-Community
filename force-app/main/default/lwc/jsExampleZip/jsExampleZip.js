import { LightningElement } from "lwc";
import jszip from "@salesforce/resourceUrl/JSZip";
import { loadScript } from "lightning/platformResourceLoader";

export default class StaticTest extends LightningElement {
  connectedCallback() {
    console.log("jsZip? ", jszip);
    loadScript(this, jszip ).then(() => {
      console.log("Script loadedz...");
    });
  }

  createZip(){
    console.log('zip call hui');
    zip = new JSZip();
    zip.file("Hello.txt", "Hello World\n");
    console.log('zip call hui');
    zip.generateAsync({type:"blob"})
    .then(function(content) {
        // see FileSaver.js
        saveAs(content, "example.zip");
        console.log('yhaa bhi.......');
    });
 }
}