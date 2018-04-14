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
    
    let name: String
    let email: String
    let phoneNumber: String
    
    // Init
    
    init(name: String, email: String, phoneNumber: String) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    convenience init(email: String) {
        self.init(name: "", email: email, phoneNumber: "")
    }
}
