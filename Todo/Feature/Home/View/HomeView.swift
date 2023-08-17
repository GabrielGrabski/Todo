//
//  HomeView.swift
//  Todo
//
//  Created by Gabriel Grabski on 09/08/23.
//

import UIKit

class HomeView: UIView {
    
    private weak var buttonDelegate: HomeButtonProtocol?
    
    lazy var headerStack: UIStackView = {
       let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 0
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Todo App"
        label.textColor = .black
        return label
    }()
    
    lazy var addTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.addTarget(self, action: #selector(onTapAddTaskButton), for: .touchUpInside)
        return button
    }()
    
    lazy var taskTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.register(HomeTaskTableViewCell.self, forCellReuseIdentifier: HomeTaskTableViewCell.identifier)
        return table
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
    
    public func delegateTaskTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        taskTableView.delegate = delegate
        taskTableView.dataSource = dataSource
    }
    
    public func delegateButton(delegate: HomeButtonProtocol) {
        self.buttonDelegate = delegate
    }
    
    @objc private func onTapAddTaskButton(_ sender: UIButton) {
        buttonDelegate?.onTapAddTaskButton(sender)
    }
    
    private func addElements() {
        addSubview(headerStack)
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(addTaskButton)
        addSubview(taskTableView)
    }
}

extension HomeView {
    
    private func configConstraints() {
        configHeaderStackConstraints()
        configTaskTableViewConstraints()
    }
    
    private func configHeaderStackConstraints() {
        headerStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func configTaskTableViewConstraints() {
        taskTableView.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
