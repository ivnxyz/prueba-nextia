//
//  HomeController.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/13/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeController: UIViewController {
    
    private let textFieldHeight: CGFloat = 60
    private let textFieldHorizontalMargin: CGFloat = 30
    
    // MARK: - Elementos de UI
    
    lazy var mailTextFieldView: CustomTextFieldView = {
        let textFieldView = CustomTextFieldView(iconImage: #imageLiteral(resourceName: "mail_icon"), unactiveIconImage: #imageLiteral(resourceName: "mail_icon_gray"), placeholder: "Correo", keyboardType: UIKeyboardType.emailAddress, isTextFieldEnabled: false)
        
        // Configurar textFieldView
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        return textFieldView
    }()
    
    lazy var firstNameTextFieldView: CustomTextFieldView = {
        let textFieldView = CustomTextFieldView(iconImage: #imageLiteral(resourceName: "user_icon"), unactiveIconImage: #imageLiteral(resourceName: "user_icon_gray"), placeholder: "Nombre", keyboardType: UIKeyboardType.default)
        
        // Configurar textFieldView
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        return textFieldView
    }()
    
    lazy var lastNameTextFieldView: CustomTextFieldView = {
        let textFieldView = CustomTextFieldView(iconImage: #imageLiteral(resourceName: "user_icon"), unactiveIconImage: #imageLiteral(resourceName: "user_icon_gray"), placeholder: "Apellido", keyboardType: UIKeyboardType.default)
        
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
    
    lazy var updateProfileButton: UIButton = {
        let button = UIButton(type: .system)
        
        // Configurar botón
        button.setTitle("Actualizar perfil", for: .normal)
        button.setTitleColor(APP_MAIN_COLOR, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // Cliente de la base de datos
    lazy var firebaseDatabaseClient: FirebaseDatabaseClient = {
        let databaseClient = FirebaseDatabaseClient()
        return databaseClient
    }()

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar tabGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        // Colocar vistas
        view.addSubview(textFieldsStackView)
        view.addSubview(updateProfileButton)
        
        // Colocar StackView
        textFieldsStackView.addArrangedSubview(mailTextFieldView)
        textFieldsStackView.addArrangedSubview(firstNameTextFieldView)
        textFieldsStackView.addArrangedSubview(lastNameTextFieldView)
        textFieldsStackView.addArrangedSubview(phoneNumberTextFieldView)
        
        // Configurar layout del stackView
        NSLayoutConstraint.activate([
            textFieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Configurar layout de mailTextFieldView
        configureTextFieldConstraints(textFieldView: mailTextFieldView)
        
        // Configurar layout de nameTextFieldView
        configureTextFieldConstraints(textFieldView: firstNameTextFieldView)
        configureTextFieldConstraints(textFieldView: lastNameTextFieldView)
        
        // Configurar layout de phoneTextFieldView
        configureTextFieldConstraints(textFieldView: phoneNumberTextFieldView)
        
        // Configurar layout del botón para actualizar el perfil del usuario
        NSLayoutConstraint.activate([
            updateProfileButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor),
            updateProfileButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            updateProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Agregar botón para cerrar sesión
        let signOutButton = UIBarButtonItem(title: "Cerrar sesión", style: UIBarButtonItemStyle.plain, target: self, action: #selector(signOut))
        signOutButton.tintColor = APP_MAIN_COLOR
        navigationItem.rightBarButtonItem = signOutButton
        
        // Agregar target al botón de actualizar perfil
        updateProfileButton.addTarget(self, action: #selector(self.updateUserProfile(_:)), for: .touchUpInside)
        
        // Obtener usuario
        if let user = Auth.auth().currentUser {
            firebaseDatabaseClient.getUserData(user) { (userProfile, error) in
                // Mostrar datos del usuario
                guard let userProfile = userProfile else {
                    ErrorHandler.handle(error, from: self)
                    return
                }
                
                // Mostrar datos
                self.mailTextFieldView.set(text: userProfile.email)
                
                // Estos datos pueden no mostrarse ya que son opcionales, pero el usuario podrá agregar sus datos y actualizar su perfil
                
                if let firstName = userProfile.firstName {
                    self.firstNameTextFieldView.set(text: firstName)
                }
                
                if let lastName = userProfile.lastName {
                    self.lastNameTextFieldView.set(text: lastName)
                }
                
                if let phoneNumber = userProfile.phoneNumber {
                    self.phoneNumberTextFieldView.set(text: phoneNumber)
                }
            }
        }
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
        _ = firstNameTextFieldView.resignFirstResponder()
        _ = lastNameTextFieldView.resignFirstResponder()
        _ = phoneNumberTextFieldView.resignFirstResponder()
    }
    
    @objc func updateUserProfile(_ sender: UIButton) {
        let firstName = firstNameTextFieldView.getText()
        let lastName = lastNameTextFieldView.getText()
        let phone = phoneNumberTextFieldView.getText()
        
        // Actualizar perfil del usuario
        if let user = Auth.auth().currentUser {
            firebaseDatabaseClient.updateUserData(user, firstName: firstName, lastName: lastName, phone: phone)
        }
    }
    
    // Cerrar sesión
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
            // Regresar a la pantalla de inicio
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            present(controller, animated: false, completion: nil)
        } catch let error {
            ErrorHandler.handle(error, from: self)
        }
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
        let keyboardHeight = getKeyboardHeight(notification: notification) - textFieldsStackView.frame.height/2
        
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
