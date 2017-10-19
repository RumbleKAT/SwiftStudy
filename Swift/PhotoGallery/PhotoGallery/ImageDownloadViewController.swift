//
//  ImageDownloadViewController.swift
//  PhotoGallery
//
//  Created by 송명진 on 2017. 10. 19..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit

class ImageDownloadViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlField: UITextField!
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)
        indicator.backgroundColor = UIColor.lightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    func showActivityIndicator(){
        self.view.addSubview(self.indicator)
        
        let safeAreaLayoutGuide:UILayoutGuide = self.view.safeAreaLayoutGuide
        
        self.indicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.indicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true

        indicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    @IBAction func touchUpSyncDownloadButton(_ sender: UIButton){
        self.urlField.endEditing(true)
        self.showActivityIndicator()
        
        /*
         병렬처리 필수 보여주는 것을 실행하기 전에 다운로드가 실행
         */
        
        guard let urlString: String = self.urlField.text, urlString.isEmpty == false else{
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        do {
            let data = try Data(contentsOf:url)
            let image = UIImage(data: data)
            self.imageView.image = image
        }catch{
            print(error.localizedDescription)
        }
        
        hideAcitivityIndicator()
    }
    
    func hideAcitivityIndicator(){
        self.indicator.stopAnimating()
        self.indicator.removeFromSuperview()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    @IBAction func touchUpAsyncDownloadButton(_ sender: UIButton){ //비동기
        self.urlField.endEditing(true) //작업을 돌리고
        self.showActivityIndicator()

        guard let urlString: String = self.urlField.text, urlString.isEmpty == false else{
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }

        let downloadQueue  : DispatchQueue = DispatchQueue (label : "image_download" ) //메인 스레드 
        
        downloadQueue.async {
            
            defer{
                DispatchQueue.main.async{
                    self.hideAcitivityIndicator()
                }
            }
            
            do {
                let data = try Data(contentsOf:url)
                let image = UIImage(data: data)
                
                //무거운 작업은 여기까지 하고
                //화면에 보여지는 것은 main 스레드에서 보여짐
                
                DispatchQueue.main.async {  //main 스레드에 어싱크함 안드로이드 thread랑 같음 UI변경은 메인 스레드에서만
                    self.imageView.image = image
                }
            }catch{
                print(error.localizedDescription)
            }
            
        }
        /*
         DispatchQueue 수동으로 스레드를 만들어서 흐름을 만듬
         메인 스레드 외에 백그라운드에서 사용할 스레드 global
         async 작업을 보냄
         
         Grand Central Dispatch
         멀티코어와 다중 프로세스 환경에서의 다중처리를 위해 애플에서 개발한 기술
         
         */
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
