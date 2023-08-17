//
//  HomeTaskCellView.swift
//  Todo
//
//  Created by Gabriel Grabski on 12/08/23.
//

import Foundation
import UIKit

class HomeTaskCellView: UIView {
    
    lazy var todoTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .natural
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        configConstratins()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(todoTitleLabel)
    }
}

extension HomeTaskCellView {
    
    private func configConstratins() {
        configTodoTitleLabelConstraints()
    }
    
    private func configTodoTitleLabelConstraints() {
        todoTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
    }
}
