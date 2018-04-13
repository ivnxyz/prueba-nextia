//
//  SignInTextField.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/12/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import UIKit

class SignInTextField: UITextField {
    
    private let bottomLineHeight: CGFloat = 1
    
    // Línea en la parte de abajo del textField
    lazy var bottomLine: UIView = {
        let view = UIView()
        
        // Configurar linea
        view.backgroundColor = APP_GRAY_COLOR
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Configurar colores
        self.textColor = APP_MAIN_COLOR
        self.tintColor = APP_MAIN_COLOR
        
        // Configurar linea
        addSubview(bottomLine)
        
        NSLayoutConstraint.activate([
            bottomLine.heightAnchor.constraint(equalToConstant: bottomLineHeight),
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
