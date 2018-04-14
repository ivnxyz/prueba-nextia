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
    
    // Crear referencia a la base de datos
    let usersReference = Database.database().reference().child("users")
    
    func getUserData(_ user: User, completionHandler: @escaping(FirebaseUserProfile?, Error?) -> Void) {
        usersReference.child(user.uid).observe(.value) { (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                // Obtener datos
                guard let phoneNumber = data["phoneNumber"] as? String, let name = data["name"] as? String, let email = user.email else {
                    completionHandler(nil, FirebaseError.notEnoughtData)
                    return
                }
                
                // Crear perfil del usuario
                let profile = FirebaseUserProfile(name: name, email: email, phoneNumber: phoneNumber)
                completionHandler(profile, nil)
            } else {
                // El usuario no tiene datos en la base de datos
                guard let email = user.email else {
                    completionHandler(nil, FirebaseError.userHasNoEmail)
                    return
                }
                
                // Crear perfil del usuario
                let profile = FirebaseUserProfile(email: email)
                completionHandler(profile, nil)
            }
        }
    }
    
    // Actualizar los datos de la foto de perfil
    func updateUserData(_ user: User, name: String, phone: String) {
        
        let data = ["name": name, "phoneNumber": phone]
        
        // Publicar cambios en Firebase
        usersReference.child(user.uid).updateChildValues(data)
    }
    
}
