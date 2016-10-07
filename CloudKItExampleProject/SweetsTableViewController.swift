//
//  SweetsTableViewController.swift
//  CloudKItExampleProject
//
//  Created by student3 on 10/7/16.
//  Copyright © 2016 John Hersey High School. All rights reserved.
//

import UIKit
import CloudKit

class SweetsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

           }

    
    @IBAction func sendSweet(sender: AnyObject) {
        let alert = UIAlertController(title: "New Sweet", message: "Enter a sweet", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "Your Sweet"
        }
        
        alert.addAction(UIAlertAction(title: "Send", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first!
            
            if textField.text != "" {
                let newSweet = CKRecord(recordType:"Sweet")
                newSweet["content"] = textField.text
                
                let publicData = CKContainer.defaultContainer().publicCloudDatabase
                publicData.saveRecord(newSweet, completionHandler: { (record:CKRecord?, error:NSError?) -> Void in
                    if error == nil{
                        print("Sweet saved")//
                    }
                    
                    
                })
                
                
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)

    
    }
}


    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


