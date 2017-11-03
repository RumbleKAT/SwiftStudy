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
    
    // MARK : - 구글에 해당 파라미터를 검색하는 메서드
    
    func SearchGoogle(Param : String){
        let quest = "https://www.google.com/search?query=" + Param
        print(quest)
        if let url = URL(string: quest){
            let request = URLRequest(url:url)
            webView.loadRequest(request)
        }
        //Parameter가 nil 값이 아닐 경우 webView를 호출
    }
    
    /*
     P.S. 저번에 배웠던 WKWebView는 Xcode에서 실행이 안되서 이전 버전인 UIWebView를 사용하였습니다.
     */

}

