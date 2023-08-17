//
//  ViewController.swift
//  Todo
//
//  Created by Gabriel Grabski on 09/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    public var homeView: HomeView? = HomeView()
    private var viewModel: HomeViewModel?
    private var taskViewController: TaskViewController?
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        reloadTasks()
    }
    
    private func setup() {
        setupViewModel()
        setupHomeButtonDelegate()
        setupHomeTaskTableViewDelegate()
        setupTaskController()
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
    
    public func reloadTasks() {
        self.homeView?.taskTableView.reloadData()
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
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewModel?.getCell(tableView: tableView, indexPath: indexPath) as? HomeTaskTableViewCell else { return UITableViewCell() }
        let task = viewModel?.loadCurrentTask(indexPath) ?? Task()
        cell.setupCellInfo(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.getCellHeight() ?? 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = taskViewController {
            controller.setupTask(task: viewModel?.loadCurrentTask(indexPath) ?? Task())
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
