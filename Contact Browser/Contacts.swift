//
//  People.swift
//  Contact Browser
//
//  Created by Dennis Cherchenko on 9/15/16.
//  Copyright © 2016 Dennis Cherchenko. All rights reserved.
//

import Foundation
import Contacts

class Contacts {

    var contacts: [PersonInformation]?

    init() {
        initializeContacts()
    }

    public func initializeContacts() {
        
        let contactStore = CNContactStore()

        do {

            var temp: [PersonInformation] = []
            let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor])

            try contactStore.enumerateContacts(with: fetchRequest) { contact, stop in

                if (!contact.phoneNumbers.isEmpty) {

                    let person = PersonInformation.init(firstName: contact.givenName, lastName: contact.familyName, phoneNumber: contact.phoneNumbers[0].value.stringValue)
                    temp.append(person)

                }
            }

            contacts = temp

        }catch{
            print("ERROR")
        }
    }

}
