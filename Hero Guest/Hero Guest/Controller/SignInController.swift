//
//  SignInController.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/12/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import UIKit

class SignInController: UIViewController {
    
    // MARK: - Elementos de UI
    
    lazy var mailTextFieldView: CustomTextFieldView = {
        let textFieldView = CustomTextFieldView(iconImage: #imageLiteral(resourceName: "mail_icon"), unactiveIconImage: #imageLiteral(resourceName: "mail_icon_gray"), placeholder: "Correo")
        
        // Configurar textFieldView
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        return textFieldView
    }()
    
    lazy var passwordTextFieldView: CustomTextFieldView = {
        let textFieldView = CustomTextFieldView(iconImage: #imageLiteral(resourceName: "lock_icon"), unactiveIconImage: #imageLiteral(resourceName: "lock_icon_gray"), placeholder: "Correo")
        
        // Configurar textFieldView
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        return textFieldView
    }()

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mailTextFieldView)
        view.addSubview(passwordTextFieldView)
        
        // Configurar elementos de UI
        NSLayoutConstraint.activate([
            mailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mailTextFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mailTextFieldView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextFieldView.topAnchor.constraint(equalTo: mailTextFieldView.bottomAnchor),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

}

