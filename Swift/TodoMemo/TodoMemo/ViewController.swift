//
//  ViewController.swift
//  TodoMemo
//
//  Created by yagom on 2017. 10. 18..
//  Copyright © 2017년 yagom. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.startReloadTableContents(_:)), for: UIControlEvents.valueChanged)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didReceiveUpdateTodoListNotification(_:)),
                                               name: didUpdateTodoListNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: IBAction
    @IBAction func touchUpEditBarButton(_ sender: UIBarButtonItem) {
        
        self.tableView.isEditing = !self.tableView.isEditing
        
        if self.tableView.isEditing {
            sender.title = "DONE"
        } else {
            sender.title = "EDIT"
        }
    }
    
    // MARK: Custom Methods
    @objc func startReloadTableContents(_ sender: UIRefreshControl) {
        self.tableView.reloadData()
        sender.endRefreshing()
    }
    
    // MARK: Receive Notification
    @objc func didReceiveUpdateTodoListNotification(_ notification: Notification) {
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        cell.textLabel?.text = todos[indexPath.row].title
        cell.detailTextLabel?.text = dateFormatter.string(from: todos[indexPath.row].due)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todos.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        saveCurrentTodo()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addViewController: AddTodoViewController = segue.destination as? AddTodoViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        guard let cellIndex: IndexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        addViewController.todoIndex = cellIndex.row
    }
}

