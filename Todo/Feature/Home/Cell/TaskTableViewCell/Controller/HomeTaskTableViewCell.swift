//
//  HomeTaskTableViewCell.swift
//  Todo
//
//  Created by Gabriel Grabski on 10/08/23.
//

import UIKit

class HomeTaskTableViewCell: UITableViewCell {
    
    public static let identifier: String = String(describing: HomeTaskTableViewCell.self)
    var homeTaskCellView: HomeTaskCellView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCellInfo(task: Task) {
        homeTaskCellView?.todoTitleLabel.text = task.title ?? ""
    }
    
    private func setup() {
        homeTaskCellView = HomeTaskCellView()
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        contentView.addSubview(homeTaskCellView!)
    }
}

extension HomeTaskTableViewCell {
    
    private func configConstraints() {
        configHomeTaskCellViewConstraints()
    }
    
    private func configHomeTaskCellViewConstraints() {
        homeTaskCellView?.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
