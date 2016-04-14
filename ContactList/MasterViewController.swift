//
//  MasterViewController.swift
//  ContactList
//
//  Created by s5014219 on 16/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, DetailViewControllerDelegate {

    //the detail view the master view will work on
    var detailViewController: DetailViewController? = nil
    //the list of contacts
    var contacts = ContactList()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        //adds a defualt contact to the contacts list
        contacts.entries.insert(ContactListEntry(firstName: "Peter", lastName: "File", yearOfBirth: 1943, middleName: "Ben", address: "9 Fake st", phoneNumber: "12234"), atIndex: 0)
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

    // MARK: - Segues
    
    //the prepare for segue function is used to proform actions and transfer data when switching views
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        //This segue is used by the add new contact button to display a page with text fields where a contacts details can be entered in
        if let identifier = segue.identifier where identifier == "addContact" {
            let vc = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            vc.person = ContactListEntry(firstName: "", lastName: "") //adds an empty person to the detail view
            vc.update = "add" //set the detial view flag to be add
            vc.delegate = self
        }
        //the show detail segue is used to edit an existing person in the contactList
        if let identifier = segue.identifier where identifier == "showDetail" {
            let vc = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                vc.person = contacts.entries[indexPath.row]
                vc.update = "update" // set the detail view flag to update
                vc.delegate = self
            }
        }
    }
    
    // MARK: - Delegates
    
    //cancels the add or update detials
    func cancelPressed(vc: DetailViewController){
        self.navigationController?.popViewControllerAnimated(true)
        vc.update = "cancel" // set the detal view flag to be cancel
    }
    
    //updates the table view with edited data or adds a new contact if the add button was pressed
    func update(vc: DetailViewController){
        if(vc.update == "update"){
            tableView.reloadData()
        //adds the persons detials entered in the detial view as a contactList entry to the list of contacts
        //does not add the person to the list if they do not have a first name or last name
        }else if(vc.update == "add" && (vc.person!.firstName != "" || vc.person!.lastName != "")){
            contacts.entries.insert(vc.person!, atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }else {
            //dont do anything becuase you probab;y want to cancel at this point
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.entries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = contacts.entries[indexPath.row]
        cell.textLabel!.text = object.fullName()
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            contacts.entries.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the list, and add a new row to the table view.
        }
    }


}

