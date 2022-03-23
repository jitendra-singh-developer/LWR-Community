public class ProfileImageController {
    public Contact contact {get;set;}
	public ProfileImageController(ApexPages.StandardController pi)
    {
      ID accId = pi.getId();
        System.debug('ids'+ accId);
      contact = new Contact(AccountId = accId);
	}
    public PageReference save()
    {
        insert contact;
        PageReference pg = new PageReference('/apex/ProfileImagePage');
        pg.setRedirect(True);
        return pg;
	}
}