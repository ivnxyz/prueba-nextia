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
                print("Mostrando datos...")
                print(data)
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
    
}
