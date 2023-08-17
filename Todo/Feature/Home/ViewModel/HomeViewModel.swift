//
//  HomeViewModel.swift
//  Todo
//
//  Created by Gabriel Grabski on 10/08/23.
//

import Foundation
import UIKit

var list: [Task] = [
    Task(title: "Mercado", description: "Teste \n Teste"),
    Task(title: "Topicos ADS", description: "Teste \n Teste"),
    Task(title: "Topicos Historia", description: "Teste \n Teste"),
    Task(title: "Teste", description: "Teste \n Teste"),
]

class HomeViewModel {

    public func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTaskTableViewCell.identifier, for: indexPath)
        as? HomeTaskTableViewCell
        setupCellColor(cell, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    public func getCellHeight() -> CGFloat {
        return 60
    }
    
    public func getNumberOfRows() -> Int {
        return list.count
    }
    
    public func loadCurrentTask(_ indexPath: IndexPath) -> Task {
        return list[indexPath.row]
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
