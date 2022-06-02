@isTest
public with sharing class GetContactsControllerTest {

    @testSetup
    static void setup() {
        List<Contact> testContacts = new List<Contact>();
        for(Integer i = 0; i < 2; i++) {
            Contact contacts = new Contact(
                FirstName = 'FirstName' + i,
                LastName = 'LastName' + i
            );
            testContacts.add(contacts);
        }
        insert testContacts;
    }

    @isTest 
    static void getContacts_returnContacts_contactsWasReceived() {
        List<Contact> newContacts = [ SELECT Id, LastName, FirstName, CreatedDate FROM Contact ];

        Test.startTest();
        List<Contact> returnedContacts = GetContactsController.getContacts();
        Test.stopTest();
        
        System.assertEquals(newContacts, returnedContacts, 'Contacts were not received');
    }

    @isTest 
    static void getContacts_returnContacts_contactsNotLoaded() {
        List<Contact> newContacts = [
            SELECT Id, LastName, FirstName, CreatedDate FROM Contact
            WHERE FirstName = 'FirstNameContact'
        ];

        Test.startTest();
        Integer returnedContacts = GetContactsController.getContacts().size();
        Test.stopTest();
        
        System.assertNotEquals(newContacts.size(), returnedContacts, 'Contacts are loaded');
    }

    @IsTest
    public static void getContacts_findByName(){

        Test.startTest();        
        GetContactsController.contactSearch = 'FirstNameContact';
        List<Contact> searchContactTest = getContactsController.contacts;
        Test.stopTest();

        List<Contact> testlistContact = [
            SELECT Id, FirstName, LastName, CreatedDate
            FROM Contact 
            WHERE FirstName 
            LIKE :'FirstNameContact'
        ];        
        System.assertEquals(searchContactTest, testlistContact, 'receipted incorrect count of contacts');
    }

    @IsTest
    public static void getContacts_findByName_emptySearch(){

        Test.startTest();        
        GetContactsController.contactSearch = '';
        List<Contact> searchContactTest = getContactsController.contacts;
        Test.stopTest();

        List<Contact> testlistContact = [
            SELECT Id, FirstName, LastName, CreatedDate 
            FROM Contact 
            WHERE FirstName 
            LIKE :'FirstNameContact'
        ];        
        System.assertNotEquals(searchContactTest, testlistContact, 'filter works incorrectly');
    }
}
