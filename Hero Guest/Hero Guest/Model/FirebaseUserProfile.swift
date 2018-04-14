//
//  FirebaseUserProfile.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/14/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import Foundation

class FirebaseUserProfile {
    
    // Atributos
    
    let email: String
    let firstName: String?
    let lastName: String?
    let phoneNumber: String?
    
    // Init
    
    init(email: String, firstName: String?, lastName: String?, phoneNumber: String?) {
        self.firstName = firstName
        self.email = email
        self.phoneNumber = phoneNumber
        self.lastName = lastName
    }
}
