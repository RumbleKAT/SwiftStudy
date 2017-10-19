//
//  AddTodoViewController.swift
//  TodoMemo
//
//  Created by yagom on 2017. 10. 18..
//  Copyright © 2017년 yagom. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {

    // MARK:- Properties
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var dueField: UITextField!
    var datePicker: UIDatePicker!
    var todoIndex: Int?
    
    // MARK: - Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeDatePicker()
        
        if let index: Int = todoIndex {
            let todo: TodoInfo = todos[index]
            
            self.titleField.text = todo.title
            self.dueField.text = dateFormatter.string(from: todo.due)
        }
    }
    
    // MARK: Custom Methods
    func initializeDatePicker(){
        
        self.datePicker = UIDatePicker()
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
        
        let toolbar: UIToolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "취소", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.touchUpCancelBarButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.touchUpDoneBarButton))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.dueField.inputAccessoryView = toolbar
        self.dueField.inputView = self.datePicker
    }
    
    @objc func touchUpDoneBarButton(){
        self.view.endEditing(true)
    }
    
    @objc func touchUpCancelBarButton(){
        self.view.endEditing(true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        self.dueField.text = dateFormatter.string(from: sender.date)
    }

    // MARK: IBAction
    @IBAction func touchUpAddButton(_ sender: UIButton) {
        
        guard let title: String = self.titleField.text, title.isEmpty == false else {
            print("please input title")
            return
        }
        
        guard let dueText: String = self.dueField.text, dueText.isEmpty == false else {
            print("please input due")
            return
        }
        
        guard let due: Date = dateFormatter.date(from: dueText) else {
            print("wrong date string")
            return
        }
        
        let newTodo: TodoInfo = TodoInfo(title: title,
                                         due: due)
        
        
        if let index: Int = self.todoIndex {
            todos[index] = newTodo
        } else {
            todos.append(newTodo)
        }
        
        saveCurrentTodo()

        NotificationCenter.default.post(name: didUpdateTodoListNotification, object: nil)
        
        self.navigationController?.popViewController(animated: true)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
