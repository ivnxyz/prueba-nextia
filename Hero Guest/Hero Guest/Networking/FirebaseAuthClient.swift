//
//  FirebaseAuthClient.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/13/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import FirebaseAuth

class FirebaseAuthClient {
    
    let firebaseAuth = Auth.auth()
    
    // Función para iniciar sesión con un correo y contraseña
    func signInWith(email: String, password: String, completionHandler: @escaping(User?, Error?) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { (user, error) in
            // Manejar error (cuando el usuario ya tiene una cuenta)
            if let _ = error {
                self.firebaseAuth.signIn(withEmail: email, password: password, completion: { (user, signInError) in
                    completionHandler(user, signInError)
                })
            } else {
                // Enviar correo de verificación
                user?.sendEmailVerification(completion: { (emailVerificationError) in
                    // Llamar al completionHandler con un error
                    completionHandler(user, emailVerificationError)
                })
            }
        }
    }
    
}
