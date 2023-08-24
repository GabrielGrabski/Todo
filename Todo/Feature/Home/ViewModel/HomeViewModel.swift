//
//  HomeViewModel.swift
//  Todo
//
//  Created by Gabriel Grabski on 10/08/23.
//

import Foundation
import UIKit

class HomeViewModel {
    
    private var tasks: [Task] = []
    private var service: HomeViewService = HomeViewService()    
    
    public func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTaskTableViewCell.identifier, for: indexPath)
        as? HomeTaskTableViewCell
        setupCellColor(cell, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    public func getCellHeight() -> CGFloat {
        return 60
    }
    
    private func setupCellColor(_ cell: HomeTaskTableViewCell?, indexPath: IndexPath) {
        if isOddCell(indexPath) {
            cell?.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        } else {
            cell?.backgroundColor = .white
        }
    }
    
    private func isOddCell(_ indexPath: IndexPath) -> Bool {
        return indexPath.row % 2 == 0
    }
}
