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
}
