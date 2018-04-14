//
//  ErrorHandler.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/13/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import UIKit

class ErrorHandler {
    
    static func handle(_ error: Error?, from viewController: UIViewController) {
        if let error = error {
            // Crear una alerta con el mensaje de error
            let alertController = UIAlertController(
                title: "Oops!",
                message: error.localizedDescription,
                preferredStyle: .alert
            )
            
            // Añadir botón OK a la alerta
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(alertAction)
            
            // Presentar el error
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}
