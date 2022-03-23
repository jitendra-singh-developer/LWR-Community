public class PopupAlertController1
{
    public Boolean displayPopup {get;set;}
    public PopupAlertController1()
    {
  		
    }
    public void showPopup()
    {
        displayPopup = true;
    }
    public void closePopup()
    {
         displayPopup = false;
    }
 
    public PageReference redirectPopup()
    {
    displayPopup = false;
   
    PageReference p=new Pagereference('/');
    p.setRedirect(true);
    return p;
    }
}