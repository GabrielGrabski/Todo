//
//  CreateTaskViewModel.swift
//  Todo
//
//  Created by Gabriel Grabski on 14/08/23.
//

import Foundation
import UIKit
import FirebaseFirestore

class TaskViewModel {
    
    private weak var createTaskView: TaskView?
    private weak var createTaskViewController: TaskViewController?
    private let database = Firestore.firestore()
    
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
    
    public func createTask(task: Task) {
        database.collection("tasks").addDocument(data: [
            "id": task.id ?? UUID().uuidString,
            "Title": task.title ?? "",
            "Description": task.description ?? ""
        ])
    }
    
    public func saveTask(task: Task, completion: (() -> ())? = nil) {
        database.collection("tasks").whereField("id", isEqualTo: task.id ?? "").getDocuments { snapshot, error in
            if (task.title == "" || task.title == nil) || (task.description == "" || task.description == nil) {
                completion?()
                return
            }
            
            if let document = snapshot?.documents.first {
                document.reference.updateData([
                    "Title": task.title!,
                    "Description": task.description!
                ])
            } else {
                self.createTask(task: task);
            }
            
            completion?()
        }
    }
    
    public func hideKeyboard() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            scene.windows.first?.endEditing(true)
        }
    }
}
