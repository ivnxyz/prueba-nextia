//
//  FirebaseError.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/14/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import Foundation

enum FirebaseError: Error {
    case userHasNoEmail
}

extension FirebaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userHasNoEmail:
            return "El usuario no tiene un correo registrado"
        }
    }
}
