//
//  SelectedItemViewController.swift
//  Homework
//
//  Created by 송명진 on 2017. 11. 2..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit

class SelectedItemViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

   
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func TouchUPEdit(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        
        if self.tableView.isEditing {
            sender.title = "DONE"
        } else {
            sender.title = "EDIT"
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didReceiveUpdateTodoListNotification(_:)),
                                               name: didUpdateTodoListNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Receive Notification 변화를 감지하는 메서드 
    @objc func didReceiveUpdateTodoListNotification(_ notification: Notification) {
        self.tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "GoDetailView", sender: datas[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = segue.destination as! DetailTableView
        item.receiveitem = [sender as! UserData]
        item.Saved = true
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    // MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "BestFriendCell") as! BestFriendTableViewCell
     
         print(indexPath.row)
     
         cell.friend_name.text = datas[indexPath.row].name_title + ". " + datas[indexPath.row].name_first + " " + datas[indexPath.row].name_last
         cell.friend_Email.text = datas[indexPath.row].email
        
        
     
         if let imageUrl = URL(string: datas[indexPath.row].picture_medium){
         DispatchQueue.global().async {
             let data = try? Data(contentsOf: imageUrl)
                 if let data = data{
                     let image = UIImage(data: data)
                         DispatchQueue.main.async {
                             cell.imageShow.image = image
                         }
                     }
                 }
             }
             cell.sizeToFit();
             self.tableView.rowHeight = cell.frame.height
     
            cell.friend_name.sizeToFit()
            cell.friend_Email.sizeToFit()

         return cell
     }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            datas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        default:
            return
        }
    }
    
    // MARK : - Swap item list
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
          datas.swapAt(sourceIndexPath.row, destinationIndexPath.row)
          saveCurrentData()
    }
    
    
    

}
