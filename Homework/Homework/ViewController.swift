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
    var receiveData: String?
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.webView.goBack()
    }
    
    @IBAction func stop(_ sender: UIBarButtonItem) {
        self.webView.stopLoading()
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        self.webView.reload()
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        self.webView.goForward()
    }
    
    @IBAction func CloseWindow(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchGoogle(Param: self.receiveData!)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.delegate = self
        print("country : " + receiveData!)
    }
    
    func SearchGoogle(Param : String){
        print(Param)
        let quest = "https://www.google.com/search?query=" + Param
        print(quest)
        if let url = URL(string: quest){
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

