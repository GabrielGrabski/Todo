//
//  ViewController.swift
//  Todo
//
//  Created by Gabriel Grabski on 09/08/23.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    private var homeView: HomeView?
    private var viewModel: HomeViewModel?
    private var taskViewController: TaskViewController?
    private var homeService: HomeViewService?
    private var tasks: [Task] = []
    
    override func loadView() {
        homeView = HomeView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setup() {
        setupViewModel()
        setupHomeButtonDelegate()
        setupHomeTaskTableViewDelegate()
        setupTaskController()
        setupService()
    }
    
    private func setupViewModel() {
        viewModel = HomeViewModel()
    }
    
    private func setupHomeButtonDelegate() {
        homeView?.delegateButton(delegate: self)
    }
    
    private func setupHomeTaskTableViewDelegate() {
        homeView?.delegateTaskTableView(delegate: self, dataSource: self)
    }
    
    private func setupTaskController() {
        taskViewController = TaskViewController()
    }
    
    private func setupService() {
        homeService = HomeViewService()
    }
    
    private func reloadData() {
        homeService?.fetchTasks{ tasks in
            self.tasks = tasks
            DispatchQueue.main.async {
                self.homeView?.taskTableView.reloadData()
            }
        }
    }
    
}

extension HomeViewController: HomeButtonProtocol {
    
    func onTapAddTaskButton(_ sender: UIButton) {
        if let controller = taskViewController {
            controller.setupTask(task: Task())
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewModel?.getCell(tableView: tableView, indexPath: indexPath) as? HomeTaskTableViewCell else { return UITableViewCell() }
        let task = tasks[indexPath.row]
        cell.setupCellInfo(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.getCellHeight() ?? 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = taskViewController {
            let task = tasks[indexPath.row]
            controller.setupTask(task: task)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let task = tasks[indexPath.row]
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            self.homeService?.deleteTask(task.documentID ?? "")
            self.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.reloadData()
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "", children: [deleteAction])
        }
    }
}
