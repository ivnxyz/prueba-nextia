//
//  FirebaseDatabaseClient.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/14/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase

class FirebaseDatabaseClient {
    
    private let phoneNumberKey = "phoneNumber"
    private let firstNameKey = "firstName"
    private let lastNamekey = "lastName"
    
    // Crear referencia a la base de datos
    let usersReference = Database.database().reference().child("users")
    
    func getUserData(_ user: User, completionHandler: @escaping(FirebaseUserProfile?, Error?) -> Void) {
        usersReference.child(user.uid).observe(.value) { (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                // Obtener datos
                let phoneNumber = data[self.phoneNumberKey] as? String
                let firstName = data[self.firstNameKey] as? String
                let lastName = data[self.lastNamekey] as? String
                
                guard let email = user.email else {
                    completionHandler(nil, FirebaseError.userHasNoEmail)
                    return
                }
                
                
                // Crear perfil del usuario
                let profile = FirebaseUserProfile(email: email, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
                completionHandler(profile, nil)
            } else {
                // El usuario no tiene datos en la base de datos
                guard let email = user.email else {
                    completionHandler(nil, FirebaseError.userHasNoEmail)
                    return
                }
                
                // Crear perfil del usuario
                let profile = FirebaseUserProfile(email: email, firstName: nil, lastName: nil, phoneNumber: nil)
                completionHandler(profile, nil)
            }
        }
    }
    
    // Actualizar los datos de la foto de perfil
    func updateUserData(_ user: User, firstName: String?, lastName: String?,phone: String?) {
        
        let data = [firstNameKey: firstName, lastNamekey: lastName,phoneNumberKey: phone] as [String : AnyObject]
        
        // Publicar cambios en Firebase
        usersReference.child(user.uid).updateChildValues(data)
    }
    
}
