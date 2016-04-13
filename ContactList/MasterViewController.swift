//
//  MasterViewController.swift
//  ContactList
//
//  Created by s5014219 on 16/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    //the array of contacts
    var objects = [ContactListEntry]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        /*the old code for the add button
        //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //self.navigationItem.rightBarButtonItem = addButton*/
        //addes a defualt object tot he objects array
        objects.insert(ContactListEntry(firstName: "Peter", lastName: "File", yearOfBirth: 1943, middleName: "Bendoverson", address: "9 Fake st", phoneNumber: "12234"), atIndex: 0)
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*func insertNewObject(sender: AnyObject) {
        objects.insert(, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }*/

    // MARK: - Segues
    //gets the segue looks at the identifier and if the identifier is "contactDetailSegue"
    //

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier where identifier == "contactDetailSegue" {
            print("Got contactDetailSegue")
            let vc = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            vc.person = ContactListEntry(firstName: "Peter", lastName: "File", yearOfBirth: 1943, middleName: "Bendoverson", address: "9 Fake st", phoneNumber: "12234")
            
            //old code
            /*if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }*/
        }
        if let identifier = segue.identifier where identifier == "showDetail" {
            let vc = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                vc.person = objects[indexPath.row]
            }
        }
        
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object.fullName()
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

