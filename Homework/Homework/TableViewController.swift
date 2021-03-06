//
//  TableViewController.swift
//  Homework
//
//  Created by 송명진 on 2017. 10. 30..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var itemList = [UserData]()
    var nameList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        self.downloadWithURL()
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.startReloadTableContents(_:)), for: UIControlEvents.valueChanged)
    
        
    }
    // MARK: - Indicator 생성 객체
    lazy var indicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)
        indicator.backgroundColor = UIColor.blue
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    // MARK: - Download JSON 메서드
    
    /*
     NSURL 형식으로 url 변수를 저장하고 api 메서드 호출
     Json 데이터를 URLSession.shared.dataTask로 NSDictionary 형태로 저장
     DispatchQueue를 통해 비동기적으로 받은 데이터를 UI 테이블 뷰에 추가함
     */
    
    func downloadWithURL(){
        let url = NSURL(string: "https://randomuser.me/api/?results=20&inc=name,picture,nat,cell,email,id")
        
        self.itemList.removeAll()
        
        var downloadTask = URLRequest(url: (url as URL?)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData,
                                      timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary{
                let result = jsonObj!.value(forKey: "results")as? [AnyObject]
                
                for item in result!{
                    
                    var nameObj: Name?
                    var pictureObj: Picture?
                    
                    if let name = item["name"] as? [String : Any]{
                        let title = name["title"] as! String
                        let first = name["first"] as! String
                        let last = name["last"] as! String
                        nameObj = Name(title: title, first: first , last: last)
                    }
                    
                    if let picture = item["picture"] as? [String : Any]{
                        let large = picture["large"] as! String
                        let medium = picture["medium"] as! String
                        let thumbnail = picture["thumbnail"] as! String
                        pictureObj = Picture(large: large, medium: medium, thumbnail: thumbnail)
                    }
                    
                    let cell = item["cell"] as! String
                    let email = item["email"] as! String
                    let nation = item["nat"] as! String
                    
                   let temp = UserData(N: nameObj!, p: pictureObj!,e: email,c: cell, n: nation)
                    self.itemList.append(temp)
                    
                    DispatchQueue.main.async { // Correct
                        self.tableView.reloadData()
                    }
                }
            }
            
        }).resume()
    }
    
    // MARK : - TableViewCell to DetailView
    /*
     테이블 뷰 셀을 클릭하면 해당 테이블의 Row가 deselect되고 DetailView로 performSegue를 통해서 해당 row의 데이터를 전달한다.
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "DetailView", sender: self.itemList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = segue.destination as! DetailTableView
        item.receiveitem = [sender as! UserData]
        item.Saved = false
    }
    

    // MARK : - Set TableView row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;
    }
    
    // MARK: Display count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    // MARK: Display TableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! TableViewCell

        cell.friend_Name.text = self.itemList[indexPath.row].name_title + ". " + self.itemList[indexPath.row].name_first + " " + self.itemList[indexPath.row].name_last
        cell.friend_Email.text = self.itemList[indexPath.row].email
        
        if let imageUrl = URL(string: self.itemList[indexPath.row].picture_medium){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.friend_Image.image = image
                    }
                }
            }
        }
        cell.sizeToFit();
        self.tableView.rowHeight = cell.frame.height
        
        cell.friend_Name.text = self.itemList[indexPath.row].name_title + ". " + self.itemList[indexPath.row].name_first + " " + self.itemList[indexPath.row].name_last
        cell.friend_Email.text = self.itemList[indexPath.row].email
        
        cell.friend_Name.sizeToFit()
        cell.friend_Email.sizeToFit()
        
        return cell
    }
    
    // MARK: ReloadTable
    @objc func startReloadTableContents(_ sender: UIRefreshControl) {
        self.downloadWithURL()
        self.tableView.reloadData()
        sender.endRefreshing()
    }

    
    //MARK - : "Show Indicator"
    func showActivityIndicator(){
        self.view.addSubview(self.indicator)
        
        let safeAreaLayoutGuide:UILayoutGuide = self.view.safeAreaLayoutGuide
        
        self.indicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.indicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        indicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    //MARK - : "hide Indicator"
    func hideAcitivityIndicator(){
        self.indicator.stopAnimating()
        self.indicator.removeFromSuperview()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }


}
