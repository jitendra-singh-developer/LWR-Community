public class TestDataFactory {
    
    public static Account createAccount(Boolean isInsert){
        
        Account accountObj = new Account(
            Name = 'Burlington Textiles Corp of America',
            Type = 'Prospect',
            Phone = '(336) 222-7000',
            Total_Contact__c = 9,
            Account_Phase__c = 'First Phase' );
        if(isInsert){
            insert accountObj;
        }
        return accountObj;
        
    }
    public static Opportunity createOpportunity(Boolean isInsert,Account accountObj){
        
        Opportunity opportunityObj = new Opportunity(
            AccountId = accountObj.Id,
            Name = 'app demo',
            StageName = 'Qualification',
            Probability = 10,
            closeDate = System.today(),
            Type = 'Existing Customer - Replacement',
            ForecastCategoryName = 'Pipeline',
            Stage_Type__c = '25',
            Discount__c = 15
        );
        if(isInsert){
            insert opportunityObj;
        }
        return opportunityObj;
        
        
    }
    
    public static Order insertOrder(Boolean isInsert,Account accountObj,Opportunity opportunityObj){
        
        Order orderObject = new Order(
            AccountId = accountObj.Id,
            OpportunityId = opportunityObj.Id,
            EffectiveDate = System.today(),
            Amount__c = 500,
            Status = 'Draft');
        if(isInsert){
            insert orderObject;
        }
        return orderObject;
    }
    public static Product2 createProduct(Boolean isInsert){
        
        Product2 productObject = new Product2(
            Name = 'Zean Mobile',
            ProductCode = 'ZN2525',
            IsActive = true
        );
        if(isInsert){
            insert productObject;
        }
        return productObject;
    }
    
    public static PricebookEntry createPriceBookEntry(Boolean isInsert,Product2 productObject,Id priceBookId){
        
        PricebookEntry priceBookEnteryObject = new PricebookEntry(
            IsActive = true,
            Product2Id = productObject.Id,
            UnitPrice = 120,
            Pricebook2Id = priceBookId,
            UseStandardPrice = false
        );
        if(isInsert){
            insert  priceBookEnteryObject;
        }
        return priceBookEnteryObject;
    }
    
    public static OrderItem createOrderProduct(Boolean isInsert,Product2 productObject,PricebookEntry priceBookEnteryObject,Order orderObject){
        
        OrderItem orderProductObject = new OrderItem(
            orderId = orderObject.Id,
            Product2Id = productObject.Id,
            ListPrice = priceBookEnteryObject.UnitPrice,
            UnitPrice = priceBookEnteryObject.UnitPrice,
            Quantity = 2,
            PricebookEntryId = priceBookEnteryObject.Id
        );
        if(isInsert){
            insert orderProductObject;
        }
        return orderProductObject;
        
    }
    
    public static void deleteOrder(Order orderObject){
        orderObject.Status = 'Draft';
        update orderObject;
        delete orderObject;
    }
    
    public static List<EMDR_Code_Choice__c> insertEMDRCodeChoice(){
        return null;
    } 
    
    public static MIR__c createMIR(Id accountId,Boolean isInsert){
        MIR__c mIRObject = new MIR__c(Account__c = accountId,
                                      Code_1__c = '',
                                      Code_2__c = '',
                                      Code_3__c = '',
                                      Code_4__c = '',
                                      Code1_1__c = '',
                                      Code1_2__c = '',
                                      Code1_3__c = '',
                                      Code1_4__c = ''
                                      
                                     );
        if(isInsert){
            insert mIRObject;
        }
        return mIRObject;
    }
    
    public static EMDR__c createEMDR(Id accountId,Boolean isInsert){
        EMDR__c eMDRObject = new EMDR__c(Account__c = accountId,
                                         Code_1__c = '',
                                         Code_2__c = '',
                                         Code_3__c = '',
                                         Code_4__c = '',
                                         Code1_1__c = '',
                                         Code1_2__c = '',
                                         Code1_3__c = '',
                                         Code1_4__c = ''
                                         
                                        );
        if(isInsert){
            insert eMDRObject;
        }
        return eMDRObject;
    }
    
    public static Code__c createCode(String objectName,Boolean isInsert){
        
        Code__c codeObject = new Code__c(Name = objectName,
                                         isActive__c = true,
                                         Select_Section__c= 'Section A');
        if(isInsert){
            insert codeObject ;
        }
        return codeObject;
    }
    
    public static EMDR_Code__c createEMDRCode(String objectName,Boolean isInsert){
        EMDR_Code__c eMDRCodeObject = new EMDR_Code__c(Name = objectName,
                                                       isActive__c = true,
                                                       Select_Section__c= 'Section A');
        if(isInsert){
            insert eMDRCodeObject ;
        }
        return eMDRCodeObject;
    }
    
    public static EMDR_Code_Choice__c createEMDRCodeChoice(Id eMDRCodeObjectId,Id eMDRObjectId,Boolean isInsert){
        EMDR_Code_Choice__c eMDRCodeChoiceObject = new EMDR_Code_Choice__c(EMDR__c = eMDRObjectId,
                                                                           EMDR_Code__c = eMDRCodeObjectId,
                                                                           Select_Code_Number__c = '1'
                                                                          );
        if(isInsert){
            insert eMDRCodeChoiceObject;
        }
        
        
        return eMDRCodeChoiceObject;
    }
    
      public static List<EMDR_Code_Choice__c> createEMDRCodeChoices(Id eMDRCodeObjectId,Id eMDRObjectId,Boolean isInsert){
          List<EMDR_Code_Choice__c> eMDRCodeChoiceList = new List<EMDR_Code_Choice__c>();
          for(Integer index = 1;index<9;index++){
              
                 EMDR_Code_Choice__c eMDRCodeChoiceObject = new EMDR_Code_Choice__c(EMDR__c = eMDRObjectId,
                                                                           EMDR_Code__c = eMDRCodeObjectId,
                                                                           Select_Code_Number__c = String.valueOf(index)
                                                                        );
              	 eMDRCodeChoiceList.add(eMDRCodeChoiceObject);
              
          }
        if(isInsert){
            insert eMDRCodeChoiceList;
        }
        
        
        return eMDRCodeChoiceList;
    }
    
    
    public static MIR_Code_Choice__c createMIRCodeChoice(Id codeObjectId,Id mIRObjectId,Boolean isInsert){
        MIR_Code_Choice__c mIRCodeChoiceObject = new MIR_Code_Choice__c(MIR__c = mIRObjectId,
                                                                        Code__c = codeObjectId,
                                                                        Select_Code_Number__c = '4'
																		);
        
        if(isInsert){
            insert mIRCodeChoiceObject;
        }
        
        
        return mIRCodeChoiceObject;
    }
    
        public static List<MIR_Code_Choice__c> createMIRCodeChoices(Id codeObjectId,Id mIRObjectId,Boolean isInsert){
          List<MIR_Code_Choice__c> mIRCodeChoiceList = new List<MIR_Code_Choice__c>();
          for(Integer index = 1;index<9;index++){
              
                 MIR_Code_Choice__c mIRCodeChoiceObject = new MIR_Code_Choice__c(MIR__c = mIRObjectId,
                                                                           Code__c = codeObjectId,
                                                                           Select_Code_Number__c = String.valueOf(index)
                                                                        );
              	 mIRCodeChoiceList.add(mIRCodeChoiceObject);
              
          }
        if(isInsert){
            insert mIRCodeChoiceList;
        }
        
        
        return mIRCodeChoiceList;
    }
        
        }