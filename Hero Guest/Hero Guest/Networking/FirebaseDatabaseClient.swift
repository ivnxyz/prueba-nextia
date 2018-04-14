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
    private let nameKey = "name"
    
    // Crear referencia a la base de datos
    let usersReference = Database.database().reference().child("users")
    
    func getUserData(_ user: User, completionHandler: @escaping(FirebaseUserProfile?, Error?) -> Void) {
        usersReference.child(user.uid).observe(.value) { (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                // Obtener datos
                let phoneNumber = data[self.phoneNumberKey] as? String
                let name = data[self.nameKey] as? String
                
                guard let email = user.email else {
                    completionHandler(nil, FirebaseError.userHasNoEmail)
                    return
                }
                
                
                // Crear perfil del usuario
                let profile = FirebaseUserProfile(email: email, name: name, phoneNumber: phoneNumber)
                completionHandler(profile, nil)
            } else {
                // El usuario no tiene datos en la base de datos
                guard let email = user.email else {
                    completionHandler(nil, FirebaseError.userHasNoEmail)
                    return
                }
                
                // Crear perfil del usuario
                let profile = FirebaseUserProfile(email: email, name: nil, phoneNumber: nil)
                completionHandler(profile, nil)
            }
        }
    }
    
    // Actualizar los datos de la foto de perfil
    func updateUserData(_ user: User, name: String?, phone: String?) {
        
        let data = [nameKey: name, phoneNumberKey: phone] as [String : AnyObject]
        
        // Publicar cambios en Firebase
        usersReference.child(user.uid).updateChildValues(data)
    }
    
}
