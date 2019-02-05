//
//  AddTodoViewController.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController, AddTodoViewProtocol {
    
    enum TextFieldType {
        case title
        case category
    }
    
    @IBOutlet weak var addViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    var categoryPicker = UIPickerView()
    
    var presenter: AddTodoPresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(AddTodoViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddTodoViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        categoryPicker.delegate = self
        categoryTextField.inputView = categoryPicker
//        setupToolbarAsAccessoryViewFor(textField: categoryTextField)
    }
    
    deinit {
        Swift.print("[AddTodoViewController] deinit")
    }
    
    // MARK: IBAction
    
    @IBAction func addTodoButtonDidPress(_ sender: UIButton) {
        presenter?.addTodo(with: titleTextField.text)
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
        case .category:
            categoryTextField.becomeFirstResponder()
            break
        case .title:
            titleTextField.becomeFirstResponder()
            break
        }
    }
}

// MARK: UITextFieldDelegate

extension AddTodoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField { categoryTextField.becomeFirstResponder() }
        if textField == categoryTextField {
            view.resignFirstResponder()
            presenter?.addTodo(with: titleTextField.text)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty  { return true }
        guard let text = textField.text, text.count < 20 else { return false }
        if textField == categoryTextField && text.count > 0 { return false }
        return true
    }
}

// MARK: RelativeToKeyboardHandling
extension AddTodoViewController {
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            guard addViewBottomConstraint.constant == 0 else { return }
            addViewBottomConstraint.constant += keyboardSize.height
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            addViewBottomConstraint.constant = 0
        }
    }
}

// MARK: UIPickerViewDelegate, UIPickerViewDataSource

extension AddTodoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter?.todoPriorities.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter?.todoPriorities[row].visual
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = presenter?.todoPriorities[row].visual
        presenter?.todoItemPriority = presenter?.todoPriorities[row]
    }
}

// MARK: Helper

extension AddTodoViewController {

    private func setupToolbarAsAccessoryViewFor(textField: UITextField) {
        textField.inputAccessoryView = nil
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeInputView(button:)))
        toolBar.items = [closeButton]
        toolBar.setItems([closeButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    
    @objc private func closeInputView(button: UIBarButtonItem) {
        self.view.endEditing(true)
    }
}
