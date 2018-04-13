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
        let textFieldView = CustomTextFieldView()
        
        // Configurar textFieldView
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        return textFieldView
    }()

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mailTextFieldView)
        
        // Configurar elementos de UI
        NSLayoutConstraint.activate([
            mailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mailTextFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mailTextFieldView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

}

