//
//  CreateTaskProtocol.swift
//  Todo
//
//  Created by Gabriel Grabski on 14/08/23.
//

import Foundation
import UIKit

protocol TaskProtocol: AnyObject {
    
    func onTapHideKeyboardButton(_ sender: UIButton)
    
    func onTapSaveTaskButton(_ sender: UIButton)
}
