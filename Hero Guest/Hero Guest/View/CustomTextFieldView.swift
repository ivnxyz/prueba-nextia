//
//  CustomTextFieldView.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/12/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import UIKit

protocol CustomTextFieldViewDelegate {
    func textFieldEditingDidChange(_ customTextFieldView: CustomTextFieldView)
}

class CustomTextFieldView: UIView {
    
    // Propiedades
    private let iconImageViewSize: CGFloat = 20
    private let iconImage: UIImage
    private let unactiveIconImage: UIImage
    var identifier = ""
    var isTextEmpty = true
    var delegate: CustomTextFieldViewDelegate?
    
    // Crear textField
    lazy var textField: SignInTextField = {
        let textField = SignInTextField()
        
        // Configurar textField
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControlEvents.editingChanged)
        
        return textField
    }()
    
    // Crear imagen acompañando al textField
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        // Configurar imageView
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Init
    
    private init(frame: CGRect, iconImage: UIImage, unactiveIconImage: UIImage) {
        self.iconImage = iconImage
        self.unactiveIconImage = unactiveIconImage
        super.init(frame: frame)
    }
    
    // Inicializar con un frame opcional
    convenience init(frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0),
                     iconImage: UIImage,
                     unactiveIconImage: UIImage,
                     placeholder: String,
                     isSecureTextEntity: Bool = false,
                     keyboardType: UIKeyboardType = .default,
                     isTextFieldEnabled: Bool = true) {
        self.init(frame: frame, iconImage: iconImage, unactiveIconImage: unactiveIconImage)
        
        // Configurar valores
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecureTextEntity
        textField.keyboardType = keyboardType
        textField.autocorrectionType = .no
        textField.isEnabled = isTextFieldEnabled
        iconImageView.image = unactiveIconImage
        
        // Colocar vistas
        addSubview(textField)
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: iconImageViewSize),
            iconImageView.widthAnchor.constraint(equalToConstant: iconImageViewSize),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFieldEditingDidChange(_ textField: UITextField) {
        // Cambiar el icono acompañando a la imagen
        if let text = textField.text, text != "" {
            iconImageView.image = iconImage
            isTextEmpty = false
        } else {
            iconImageView.image = unactiveIconImage
            isTextEmpty = true
        }
        
        // Llamar al delegado
        delegate?.textFieldEditingDidChange(self)
    }
    
    // MARK: - Helper
    
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func set(text: String) {
        textField.text = text
        iconImageView.image = iconImage
    }
    
    func getText() -> String? {
        return textField.text
    }
    
}
