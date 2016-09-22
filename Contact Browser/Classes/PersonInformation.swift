//
//  PersonInformation.swift
//  Contact Browser
//
//  Created by Dennis Cherchenko on 9/16/16.
//  Copyright © 2016 Dennis Cherchenko. All rights reserved.
//

import Foundation

struct PersonInformation {

    let firstName: String
    let lastName: String
    let phoneNumber: String

    var fullName: String {
        return firstName + " " + lastName
    }

    init(firstName: String, lastName: String, phoneNumber: String){
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
}
