global Class CreateTaskThourghEmail implements Messaging.InboundEmailHandler{
	
		global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope){
		
			Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
			
			List<Contact> contactList = new List<Contact>();
			contactList = [SELECT Id, Email FROM Contact WHERE Email = : email.FromAddress];
			if(contactList.size() == 0 && contactList.isEmpty()){
			
				
				Integer index = email.FromName.IndexOf(' ');
				String firstName = email.FromName.subString(0,index);
				String lastName = email.FromName.subString(index);
				Contact contactObject = new Contact(FirstName=firstName,LastName=lastName,Email=email.FromAddress);
				contactList.add(contactObject);
				insert contactList;
			}
			Task newTask = new Task(Description = email.PlainTextBody,
			Priority='Normal',
			Status='Inbound Email by Jitendra Singh',
			Subject = email.Subject,
			IsReminderSet = true,
			ReminderDateTime = System.Today()+1,
			WhoId = contactList.get(0).Id
			);
			Insert newTask;
            result.success = true;
			return result ;


		}		
	


            	
	}