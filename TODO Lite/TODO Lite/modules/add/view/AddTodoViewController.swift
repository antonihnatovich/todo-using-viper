//
//  AddTodoViewController.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController, AddTodoViewProtocol {
    var presenter: AddTodoPresenterProtocol?
    
    enum TextFieldType {
        case title
        case categoy
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(AddTodoViewController.keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddTodoViewController.keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        Swift.print("[AddTodoViewController] deinit")
    }
    
    // MARK: IBAction
    
    @IBAction func addTodoButtonDidPress(_ sender: UIButton) {
        presenter?.addTodo(with: titleTextField.text, and: categoryTextField.text)
    }
    
    @IBAction func closeButtonDidPress(_ sender: UIButton) {
        dismissSelf()
    }
}

// MARK: AddTodoViewProtocol

extension AddTodoViewController {
    
    func dismiss() {
        dismissSelf()
    }
    
    func showError(for textFieldType: AddTodoViewController.TextFieldType) {
        switch textFieldType {
        case .categoy:
            categoryTextField.becomeFirstResponder()
            break
        case .title:
            titleTextField.becomeFirstResponder()
            break
        }
    }
}

extension AddTodoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField { categoryTextField.becomeFirstResponder() }
        if textField == categoryTextField {
            view.resignFirstResponder()
            presenter?.addTodo(with: titleTextField.text, and: categoryTextField.text)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, text.count < 20 else { return false }
        return true
    }
}

// MARK: RelativeToKeyboardHandling
extension AddTodoViewController {
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}
