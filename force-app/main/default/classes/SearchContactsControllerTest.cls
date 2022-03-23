@isTest
public class SearchContactsControllerTest {
	@isTest
    static void firstMethod(){
        SearchContactsController scc = new SearchContactsController();
        Contact contact = new Contact(FirstName = 'jitendra ' ,LastName = 'Singh', Email = 'jitendra@gmail.com');
        insert contact ;
        scc.searchValue = 'a@';
        scc.search();
        scc.searchValue = 'jite';
        scc.search();        
    }   
}