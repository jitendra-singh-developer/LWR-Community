public class testComponentController {
    public Integer i {get;set;}
    public String temp {get;set;}
    public boolean isTrue {get;set;}
    public testComponentController(){
        System.debug('Contructor 1st call');
       	temp = 'Constructor is Called';
        isTrue = true;
        i = 50;
	}
    public void init() {
		i = 10;
        
        	temp = 'Method is Called';
        System.debug('init 1st call');
    }
}