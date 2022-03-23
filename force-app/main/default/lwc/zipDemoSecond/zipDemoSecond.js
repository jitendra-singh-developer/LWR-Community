import { LightningElement } from 'lwc';

export default class ZipDemoSecond extends LightningElement {

    handleClick() {
        var zip = new JSZip();
        zip.file("hello.txt", "Hello World\n");
        var messages = zip.folder("messages");
        messages.file("message.txt","Hello World, This is message form wapgee!");
        zip.generateAsync({type:"blob"})
          .then(function(zip) {
          saveAs(zip, "archive.zip");
        });
      }

}