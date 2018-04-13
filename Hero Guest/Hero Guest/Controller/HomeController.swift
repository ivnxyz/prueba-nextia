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
        
        // Configurar tabGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        // Observar notificaciones del teclado
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Dejar de observar notificaciones del teclado
        deregisterFromKeyboardNotifications()
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
    
    // Ignorar los campos de texto
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        _ = mailTextFieldView.resignFirstResponder()
        _ = nameTextFieldView.resignFirstResponder()
        _ = phoneNumberTextFieldView.resignFirstResponder()
    }

}

extension HomeController {
    
    // Observar cuando el teclado aparece o desaparece
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    // Dejar de observar notificaciones del teclado
    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // Responder a la notificación del teclado
    @objc func keyboardWillShow(notification: Notification) {
        // Centrar las entradas de texto
        let keyboardHeight = getKeyboardHeight(notification: notification) - textFieldsStackView.frame.height
        
        // Animar view
        UIView.animate(withDuration: 0.1) {
            self.view.frame = CGRect(x: 0, y: -keyboardHeight, width: self.view.frame.width, height: self.view.frame.height)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        // Animar view
        UIView.animate(withDuration: 0.1) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.layoutIfNeeded()
        }
    }
    
    // Calcular el alto del teclado usando la notificación
    func getKeyboardHeight(notification: Notification) -> CGFloat {
        guard let userInfo = notification.userInfo else {
            return 0
        }
        guard let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
            return 0
        }
        return keyboardSize.height
    }
    
}
