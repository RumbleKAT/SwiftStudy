//
//  SecondViewController.swift
//  LoginView
//
//  Created by yagom on 2017. 10. 16..
//  Copyright © 2017년 yagom. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK:- Properties
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var account: AccountInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.idLabel.text = self.account.id
        self.passwordLabel.text = self.account.password
    }
}
