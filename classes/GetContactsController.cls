public with sharing class GetContactsController {
    public static String contactSearch {get; set;}
    public static List<Contact> contacts { get { return getContacts();} }       
    
    public static List<Contact> getContacts() {       
        if (contactSearch == null) {                    
            return [
                SELECT FirstName, LastName, Email, MobilePhone, CreatedDate, AccountId
                FROM Contact                
                ORDER BY CreatedDate DESC 
                LIMIT 10           
            ];
        } else {
            String getSearchContact= '%' + contactSearch + '%';            
            return [
                SELECT FirstName, LastName, Email, MobilePhone, CreatedDate, AccountId
                FROM Contact
                WHERE FirstName 
                LIKE :getSearchContact              
                ORDER BY CreatedDate DESC            
            ];
        }        
    }   
}