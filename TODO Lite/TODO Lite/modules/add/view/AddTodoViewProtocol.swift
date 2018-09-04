//
//  AddTodoViewProtocol.swift
//  TODO Lite
//
//  Created by Anton Developer on 9/4/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation
import UIKit

protocol AddTodoViewProtocol: class {
    var presenter: AddTodoPresenterProtocol? { get set }
    
    func showError(for textFieldType: AddTodoViewController.TextFieldType)
    func dismiss()
}

extension AddTodoViewProtocol where Self: UIViewController {
    
    func dismissSelf(animated: Bool = false) {
        self.dismiss(animated: animated, completion: nil)
    }
}
