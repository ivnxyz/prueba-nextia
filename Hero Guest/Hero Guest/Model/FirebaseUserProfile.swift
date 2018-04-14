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
    let name: String?
    let phoneNumber: String?
    
    // Init
    
    init(email: String, name: String?, phoneNumber: String?) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
