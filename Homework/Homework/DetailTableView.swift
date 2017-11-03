//
//  DetailTableView.swift
//  Homework
//
//  Created by 송명진 on 2017. 11. 2..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit

class DetailTableView: UIViewController {

    var receiveitem = [UserData]()
    var Saved:Bool?
    var RowIndex:Int?
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserTitle: UILabel!
    @IBOutlet weak var UserEmail: UILabel!
    @IBOutlet weak var UserCell: UILabel!
    @IBOutlet weak var UserCountry: UILabel!
    
    
    @IBAction func EditButton(_ sender: UIBarButtonItem) {
        
        if Saved == false{
            self.navigationItem.rightBarButtonItem! = UIBarButtonItem(title: "REMOVE", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailTableView.EditButton(_:)))
            
            let newFriend: UserData = self.receiveitem[0]
            datas.append(newFriend)
            Saved = true
            
        }else{
            self.navigationItem.rightBarButtonItem! = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,target: self, action: #selector(DetailTableView.EditButton(_:)))
        
            // Userdata의 primary key에 해당하는 cell 데이터를 기준으로 판단
            
            if(datas.capacity >= 0){
                print("Delete Data!")
                datas.remove(at: RowIndex!) //row index 찾기
            }
            //가장 최근의 것이 추가되었기 때문에 가장 마지막에 추가되는 것을 삭제한다.
            Saved = false
        }
        
        saveCurrentData()
        
        NotificationCenter.default.post(name: didUpdateTodoListNotification, object: nil)
    }
    
    
    func CheckPreviousData(){
        for data in 0..<datas.count{
            for index in 0..<receiveitem.count{
                if datas[data].cell == receiveitem[index].cell{
                    self.RowIndex = data
                    print("같은 사람이 존재합니다.")
                    self.Saved = true
                }
            }
        }
    }
    
    func TabBarStatus(){
        if Saved == true{
            self.navigationItem.rightBarButtonItem! = UIBarButtonItem(title: "REMOVE", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailTableView.EditButton(_:)))
        }else{
            self.navigationItem.rightBarButtonItem! = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,target: self, action: #selector(DetailTableView.EditButton(_:)))
        }
    }
    
    func changeIcon() {
        let addbtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(getter: UIDynamicBehavior.action)) //Use a selector
        navigationItem.rightBarButtonItem = addbtn
        //other stuff
    }
    
    @IBAction func touchUpSearchWeb(_ sender: UIButton){
        print("Call Web View")
        performSegue(withIdentifier: "WebViewShow", sender: self.receiveitem[0].nation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let item = nav.topViewController as! ViewController
        item.receiveData = receiveitem[0].nation
    }
    
    // MARK : - Image Load Async
    func loadData(){
        
        //load title of navigation
        self.navigationItem.title = receiveitem[0].name_title + ". " + receiveitem[0].name_last
        
        //load image async
        if let imageUrl = URL(string: receiveitem[0].picture_large){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf:imageUrl)
                if let data = data {
                    let image = UIImage(data : data)
                    DispatchQueue.main.async {
                        self.UserImage.image = image
                        self.UserImage.sizeToFit()
                    }
                }
            }
        }

        //set user's title
        self.UserTitle.text = receiveitem[0].name_title + ". " +
            receiveitem[0].name_first + " " + receiveitem[0].name_last
        
        
        //set user's email
        self.UserEmail.text = receiveitem[0].email
        self.UserCell.text = receiveitem[0].cell
        self.UserCountry.text = receiveitem[0].nation
        
    }
    
    func labelBold(){
        self.UserTitle?.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckPreviousData()
        TabBarStatus()
        labelBold()
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
