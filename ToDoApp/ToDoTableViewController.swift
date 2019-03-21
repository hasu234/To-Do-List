//
//  ToDoTableViewController.swift
//  ToDoApp
//
//  Created by Hasmot Ali Hasu on 11/24/18.
//  Copyright © 2018 vitex vegundo. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, TodoCellDelegate {

    
    var todoItems:[ToDoItems]!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func loadData(){
        todoItems = [ToDoItems]()
        todoItems = DataManager.loadAll(type: ToDoItems.self).sorted(by: {
            $0.createdAt < $1.createdAt
        })
        tableView.reloadData()
    }
    
    @IBAction func addNewToDo(_ sender: Any) {
        let addAlart = UIAlertController(title: "New ToDo", message: "Enter A Title", preferredStyle: .alert)
        addAlart.addTextField { (textfield: UITextField) in
            textfield.placeholder = "ToDo Item Title"
        }
        addAlart.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action: UIAlertAction) in
            guard let title = addAlart.textFields?.first?.text else {return}
            let newTodo = ToDoItems(title: title, completed: false, createdAt: Date(), itemIdeantifier: UUID())
            newTodo.saveItem()
            self.todoItems.append(newTodo)
            let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0), section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
        }))
        addAlart.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(addAlart, animated: true, completion: nil)
    }
    func didRequestDelete(_ cell: ToDoTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            todoItems[indexPath.row].deleteItem()
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    func didRequestComplate(_ cell: ToDoTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            var todoItem = todoItems[indexPath.row]
            todoItem.markAsCompleted()
            cell.todoLabel.attributedText = stext(todoItem.title)
            
        }
    }
    func stext (_ text:String) -> NSAttributedString {
        let stString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        stString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, stString.length))
        return stString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell
        
        cell.delegate = self

        let todoItem = todoItems[indexPath.row]
        // Configure the cell...
        cell.todoLabel.text = todoItem.title
        
        if todoItem.completed {
            cell.todoLabel.attributedText = stext(todoItem.title)
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
