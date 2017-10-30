//
//  TableViewController.swift
//  Homework
//
//  Created by 송명진 on 2017. 10. 30..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    var username = [name]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - JSON Http Request
    
    public func GetData(){
        let url = URL(string: "https://randomuser.me/api/?results=20&inc=name,picture,nat,cell,email,id")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print ("ERROR")
            }
            else{
                if let content = data{
                    do{
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSObject
                        
                        /*
                        if let results = myJson["results"] as? NSObject
                        {
                        }
 
                        guard let item = myJson.value as? NSObject else{
                            return
                        }
                        username.append(name(t: item["title"], f: item["first"], l: item["last"]))
                        */
                    }
                    catch{
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCellTableViewCell
        //cell.cellimage.image =
        /*
         이미지를 받아오는 부분
         */
        return cell
    }
}
