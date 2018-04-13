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
    
    lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        
        // Configurar stackView
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar stackView
        view.addSubview(textFieldsStackView)
        
        textFieldsStackView.addArrangedSubview(mailTextFieldView)
        textFieldsStackView.addArrangedSubview(passwordTextFieldView)
        
        // Configurar layout del stackView
        NSLayoutConstraint.activate([
            textFieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Configurar layout de los textFields
        NSLayoutConstraint.activate([
            mailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mailTextFieldView.heightAnchor.constraint(equalToConstant: 70)
        ])

        NSLayoutConstraint.activate([
            passwordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

}

