//
//  ViewController.swift
//  Homework
//
//  Created by 송명진 on 2017. 10. 29..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        //UIWebView로 작업
    }
    
    func SearchGoogle(Param : String){
        if let url = URL(string: "https://www.google.com/search?" + Param){
            let request = URLRequest(url:url)
            webView.loadRequest(request)
        }
        //Parameter가 nil 값이 아닐 경우 webView를 호출
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

