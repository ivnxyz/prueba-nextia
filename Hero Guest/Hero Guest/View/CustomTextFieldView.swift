//
//  CustomTextFieldView.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/12/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import UIKit

class CustomTextFieldView: UIView {
    
    // Propiedades
    private let iconImageViewSize: CGFloat = 25

    // Crear textField
    lazy var textField: UITextField = {
        let textField = UITextField()
        
        // Configurar textField
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.textColor = APP_SECONDARY_COLOR
        textField.tintColor = APP_MAIN_COLOR
        
        return textField
    }()
    
    // Crear imagen acompañando al textField
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        // Sólo para probar
        imageView.image = #imageLiteral(resourceName: "mail_icon")
        
        // Configurar imageView
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
