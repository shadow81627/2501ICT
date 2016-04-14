//
//  MasterViewController.swift
//  ContactList
//
//  Created by s5014219 on 16/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, DetailViewControllerDelegate {

    var detailViewController: DetailViewController? = nil
    //the array of contacts
    var objects = [ContactListEntry]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        //adds a defualt object tot he objects array
        objects.insert(ContactListEntry(firstName: "Peter", lastName: "File", yearOfBirth: 1943, middleName: "Ben", address: "9 Fake st", phoneNumber: "12234"), atIndex: 0)
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
    //adds the persons detials entered in the detial view as a contactList entry to the array of contacts
    func insertNewObject(vc: DetailViewController) {
        objects.insert(vc.person!, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues
    //the prepare for segue function is used to proform actions and transfer data when switching views
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //This segue is used by the add new contact button to display a page with text fields where a contacts details can be entered in
        if let identifier = segue.identifier where identifier == "contactDetailSegue" {
            let vc = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            vc.delegate = self
        }
        //the show detail segue is used to edit an existing person in the contactList
        if let identifier = segue.identifier where identifier == "showDetail" {
            let vc = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                vc.person = objects[indexPath.row]
                vc.delegate = self
            }
        }
    }
    
    func cancelPressed(vc: DetailViewController){
        self.navigationController?.popViewControllerAnimated(true)
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

