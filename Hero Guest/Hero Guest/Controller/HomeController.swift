//
//  HomeController.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/13/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    private let textFieldHeight: CGFloat = 60
    private let textFieldHorizontalMargin: CGFloat = 30
    
    // MARK: - Elementos de UI
    
    lazy var mailTextFieldView: CustomTextFieldView = {
        let textFieldView = CustomTextFieldView(iconImage: #imageLiteral(resourceName: "mail_icon"), unactiveIconImage: #imageLiteral(resourceName: "mail_icon_gray"), placeholder: "Correo", keyboardType: UIKeyboardType.emailAddress)
        
        // Configurar textFieldView
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        return textFieldView
    }()
    
    lazy var nameTextFieldView: CustomTextFieldView = {
        let textFieldView = CustomTextFieldView(iconImage: #imageLiteral(resourceName: "user_icon"), unactiveIconImage: #imageLiteral(resourceName: "user_icon_gray"), placeholder: "Nombre", keyboardType: UIKeyboardType.default)
        
        // Configurar textFieldView
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        return textFieldView
    }()
    
    lazy var phoneNumberTextFieldView: CustomTextFieldView = {
        let textFieldView = CustomTextFieldView(iconImage: #imageLiteral(resourceName: "phone_icon"), unactiveIconImage: #imageLiteral(resourceName: "phone_icon_gray"), placeholder: "Teléfono", keyboardType: UIKeyboardType.default)
        
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
        
        // Colocar vistas
        view.addSubview(textFieldsStackView)
        
        // Colocar StackView
        textFieldsStackView.addArrangedSubview(mailTextFieldView)
        textFieldsStackView.addArrangedSubview(nameTextFieldView)
        textFieldsStackView.addArrangedSubview(phoneNumberTextFieldView)
        
        // Configurar layout del stackView
        NSLayoutConstraint.activate([
            textFieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Configurar layout de mailTextFieldView
        configureTextFieldConstraints(textFieldView: mailTextFieldView)
        
        // Configurar layout de nameTextFieldView
        configureTextFieldConstraints(textFieldView: nameTextFieldView)
        
        // Configurar layout de phoneTextFieldView
        configureTextFieldConstraints(textFieldView: phoneNumberTextFieldView)
    }
    
    
    // MARK: - Helper
    
    // Configurar el layout de un textField
    func configureTextFieldConstraints(textFieldView: CustomTextFieldView) {
        NSLayoutConstraint.activate([
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: textFieldHorizontalMargin),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -textFieldHorizontalMargin),
            textFieldView.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }

}
