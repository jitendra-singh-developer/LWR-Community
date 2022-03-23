public class CustomController
{
    Public String tempVar {get;set;}
    Public CustomController(){
        System.debug('Hii there !!!');
        tempVar = 'Last call Constructor';
	}
public void doActionMethod()
  {  
    System.debug('Hello world');
       tempVar = 'Last call DoActionMethod';
  }
}