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
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        
        // Configurar imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "littleman_logo")
        
        return imageView
    }()
    
    lazy var recoverPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        
        // Configurar boton
        button.setTitle("¿Olvidaste tu contraseña?", for: .normal)
        button.setTitleColor(APP_GRAY_COLOR, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar vistas
        view.addSubview(textFieldsStackView)
        view.addSubview(logoImageView)
        view.addSubview(recoverPasswordButton)
        
        textFieldsStackView.addArrangedSubview(mailTextFieldView)
        textFieldsStackView.addArrangedSubview(passwordTextFieldView)
        
        // Configurar layout del stackView
        NSLayoutConstraint.activate([
            textFieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Configurar layout de los textFields
        NSLayoutConstraint.activate([
            mailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mailTextFieldView.heightAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            passwordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Configurar layout de logoImageView
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            logoImageView.bottomAnchor.constraint(equalTo: textFieldsStackView.topAnchor, constant: 10),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        // Configurar botón para recuperar contraseña
        NSLayoutConstraint.activate([
            recoverPasswordButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 50), // Arreglar esto
            recoverPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

