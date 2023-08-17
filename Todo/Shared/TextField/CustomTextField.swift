//
//  CustomTextField.swift
//  Todo
//
//  Created by Gabriel Grabski on 12/08/23.
//

import UIKit

class CustomTextField: UIView {
    
    lazy var textField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 20)
        field.textColor = .black
        field.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = leftPaddingView
        field.leftViewMode = .always
        
        field.clipsToBounds = true
        field.layer.cornerRadius = 8
        field.keyboardType = .default
        
        return field
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(textField)
    }
}

extension CustomTextField {
    
    private func configConstraints() {
        configCustomTextFieldConstraints()
    }
    
    private func configCustomTextFieldConstraints() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
