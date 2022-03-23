public class actionpollerDemoController {
public  Integer seconds{get;set;}
  public actionpollerDemoController(){
   seconds = 0;
  }
 
  public void callMethod(){
    seconds = seconds + 1;
  }
}