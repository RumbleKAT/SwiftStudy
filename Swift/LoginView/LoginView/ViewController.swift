//
//  ViewController.swift
//  LoginView
//
//  Created by yagom on 2017. 10. 16..
//  Copyright © 2017년 yagom. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK:- Properties
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK:- Method
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idField.delegate = self
        self.passwordField.delegate = self
    }
    
    // MARK: IBAction
    @IBAction func tapRootView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        /*
        self.idField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
         */
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let second: SecondViewController = segue.destination as? SecondViewController else { return }
        
        guard let id: String = idField.text, id.isEmpty == false else {
            print("아이디를 입력하세요")
            return
        }
        
        guard let password: String = passwordField.text, password.isEmpty == false else {
            print("패스워드를 입력하세요")
            return
        }
        
        let account: AccountInfo = AccountInfo(id: id, password: password)
        second.account = account
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

