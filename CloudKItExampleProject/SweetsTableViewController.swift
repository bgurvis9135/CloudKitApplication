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

    var sweets = [CKRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
    }
    
    func loadData(){
        sweets = [CKRecord]()
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
        let quary = CKQuery(recordType: "Student", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        publicData.performQuery(quary, inZoneWithID: nil) { (results:[CKRecord]?, error:NSError?) -> Void in
            if let sweets = results{
                self.sweets = sweets
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    
            })
        }
        
        
        }
    }
    
    @IBAction func sendSweet(sender: AnyObject) {
        let alert = UIAlertController(title: "New Sweet", message: "Enter a sweet", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "Your Sweet"
        }
        
        alert.addAction(UIAlertAction(title: "Send", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first!
            
            if textField.text != "" {
                let newSweet = CKRecord(recordType:"Student")
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



    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sweets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        if sweets.count == 0{
            return cell
        }
        
        let sweet = sweets[indexPath.row]
        
        if let sweetContent = sweet["content"] as? String {
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormat.stringFromDate(sweet.creationDate!)
            
            cell.textLabel?.text = sweetContent
            cell.detailTextLabel?.text = dateString
            
        }
        
        return cell
    }


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


}