//
//  ListViewController.swift
//  reMIND
//
//  Created by David de Tena on 25/02/2017.
//  Copyright © 2017 David de Tena. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var taskManager = TaskManager.sharedInstance
    
    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - TableView DataSource & Delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! TaskCell
        
        // Get the proper task from taskManager
        let task = taskManager.tasks[indexPath.row]
        cell.lblTask.text = task["title"]
        
        // Sync task with view
        if let image = task["icon"]{
            cell.imgTask.image = UIImage(named: image);
        }
        else{
            cell.imgTask.image = UIImage(named: "img_no_icon")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let complete = UITableViewRowAction(style: .normal, title: "Done") { (action, indexPath) in
            
            // Remove task from table once action "Done" is pressed
            self.taskManager.tasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        // Background color for action "Done"
        complete.backgroundColor = #colorLiteral(red: 0.8, green: 0.9725490196, blue: 0.9529411765, alpha: 1)
        
        return [complete]
    }
    
    // MARK: - Actions
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "New task", message: "Task name", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nil)
        
        let alertAction = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            
            if let textFieldText = alertController.textFields?.first?.text{
                // Get the text typed by user inside AlertController's textField and save a new task
                self.taskManager.tasks.append(["title":textFieldText])
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                // Make title of selected task available in CollectionView
                let destinationVC = segue.destination as! IconsViewController
                let selectedTask = taskManager.tasks[indexPath.row]
                destinationVC.headerTitleString = selectedTask["title"]
                destinationVC.selectedTask = indexPath.row
                
                if let title = self.navigationItem.title{
                    destinationVC.title = title
                }
            }
        }
    }
}
