//
//  TaskView.swift
//  Todo
//
//  Created by Gabriel Grabski on 12/08/23.
//

import UIKit

class TaskView: UIView {
    
    private weak var delegate: TaskProtocol?
    
    lazy var hideKeyboardButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = "OK"
        btn.tintColor = .black
        btn.isHidden = true
        btn.target = self
        btn.action = #selector(onTapHideKeyboardButton)
        return btn
    }()
    
    lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Title"
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Description"
        label.textAlignment = .left
        return label
    }()
    
    lazy var titleTextField: CustomTextField = {
        let field = CustomTextField()
        return field
    }()
    
    lazy var descriptionTextField: UITextView = {
        let field = UITextView()
        field.font = .systemFont(ofSize: 20)
        field.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        field.layer.cornerRadius = 8
        field.clipsToBounds = true
        field.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return field
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.darkGray, for: .disabled)
        button.backgroundColor = .darkGray
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(onTapSaveTaskButton), for: .touchUpInside)
        return button
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
    
    public func delegateCreateTask(_ delegate: TaskProtocol) {
        self.delegate = delegate
    }
    
    @objc private func onTapHideKeyboardButton(_ sender: UIButton) {
        delegate?.onTapHideKeyboardButton(sender)
    }
    
    @objc private func onTapSaveTaskButton(_ sender: UIButton) {
        delegate?.onTapSaveTaskButton(sender)
    }
    
    private func addElements() {
        addSubview(titleTextLabel)
        addSubview(titleTextField)
        addSubview(descriptionTextLabel)
        addSubview(descriptionTextField)
        addSubview(saveButton)
    }
    
}

extension TaskView {
    
    private func configConstraints() {
        configTitleTextFieldConstraints()
        configTitleTextLabelConstraints()
        configDescriptionTextFieldConstraints()
        configDescriptionTextLabelConstraints()
        configSaveButtonConstraints()
    }
    
    private func configTitleTextFieldConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
    }
    
    private func configTitleTextLabelConstraints() {
        titleTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleTextField.snp.top).inset(-5)
            make.leading.equalTo(titleTextField.snp.leading)
        }
    }

    private func configDescriptionTextLabelConstraints() {
        descriptionTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionTextField.snp.top).inset(-5)
            make.leading.equalTo(descriptionTextField.snp.leading)
        }
    }
    
    private func configDescriptionTextFieldConstraints() {
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(50)
            make.leading.equalTo(titleTextField.snp.leading)
            make.trailing.equalTo(titleTextField.snp.trailing)
            make.bottom.equalTo(saveButton.snp.top).offset(-20)
        }
    }
    
    private func configSaveButtonConstraints() {
        saveButton.snp.makeConstraints { make in
            make.leading.equalTo(titleTextField.snp.leading)
            make.trailing.equalTo(titleTextField.snp.trailing)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
