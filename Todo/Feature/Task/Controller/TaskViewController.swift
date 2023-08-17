//
//  TaskViewController.swift
//  Todo
//
//  Created by Gabriel Grabski on 12/08/23.
//

import UIKit

class TaskViewController: UIViewController {
    
    private var taskView: TaskView?
    private var viewModel: TaskViewModel?
    private var homeController: HomeViewController?
    
    override func loadView() {
        taskView = TaskView()
        homeController = HomeViewController()
        view = taskView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TaskViewModel()
        viewModel?.setupViewModel(createTaskView: taskView, createTaskViewController: self)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = taskView?.hideKeyboardButton
    }
    
    deinit {
        killObservers()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        viewModel?.onShowKeyboard()
    }
    
    @objc private func keyboardWillDisapear(_ notification: Notification) {
        viewModel?.onHideKeyboard()
    }
    
    public func setupTask(task: Task) {
        taskView?.titleTextField.textField.text = task.title
        taskView?.descriptionTextField.text = task.description
    }
    
    private func setup() {
        addKeyboardObservers()
        delegateCreateTaskProtocol()
    }
    
    private func addKeyboardObservers() {
        addKeyboardWillAppearObserver()
        addKeyboardWillDisappearObserver()
    }
    
    private func delegateCreateTaskProtocol() {
        taskView?.delegateCreateTask(self)
    }
    
    private func addKeyboardWillAppearObserver() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
    }
    
    private func addKeyboardWillDisappearObserver() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillDisapear),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
    }
    
    private func killObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension TaskViewController: TaskProtocol {
    
    func onTapSaveTaskButton(_ sender: UIButton) {
        let title = taskView?.titleTextField.textField.text ?? ""
        let description = taskView?.descriptionTextField.text ?? ""
        viewModel?.saveTask(task: Task(title: title, description: description))
    }
    
    func onTapHideKeyboardButton(_ sender: UIButton) {
        viewModel?.hideKeyboard()
    }
}
