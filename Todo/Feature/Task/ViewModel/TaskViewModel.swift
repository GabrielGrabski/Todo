//
//  CreateTaskViewModel.swift
//  Todo
//
//  Created by Gabriel Grabski on 14/08/23.
//

import Foundation
import UIKit

class TaskViewModel {
    
    private weak var createTaskView: TaskView?
    private weak var createTaskViewController: TaskViewController?
    
    public func setupViewModel(createTaskView: TaskView?, createTaskViewController: TaskViewController) {
        self.createTaskView = createTaskView
        self.createTaskViewController = createTaskViewController
    }
    
    public func onShowKeyboard() {
        createTaskView?.hideKeyboardButton.isHidden = false
    }
    
    public func onHideKeyboard() {
        createTaskView?.hideKeyboardButton.isHidden = true
    }
    
    public func saveTask(task: Task) {
        list.append(task)
        createTaskViewController?.navigationController?.popViewController(animated: true)
        clearTextFields()
    }
    
    public func hideKeyboard() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            scene.windows.first?.endEditing(true)
        }
    }
    
    private func clearTextFields() {
        createTaskView?.descriptionTextField.text = ""
        createTaskView?.titleTextField.textField.text = ""
    }
}
