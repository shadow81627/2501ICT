//
//  MasterViewController.swift
//  Friends
//
//  Created by s5014219 on 12/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit
import CoreData

//the master view controller for the main laugh view
class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, DetailViewControllerDelegate{
    
    var detailViewController: DetailViewController? = nil
   //the list of all the contacts that are displayed in the table view
    var contacts = ContactList()
    
    var index: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
       
        //loads content form a property list file for persisten loading
        contacts.load()
        
        //adds defualt contacts if there arent any
        if contacts.entries.count == 0 {
            insertDefualtContact()
        }
        
        //loads all of the images for the contacts
        for contact in contacts.entries {
            loadPhotoInBackground(contact)
        }
    }
    
    //adds a bunch of defualt contacts to the table view
    func insertDefualtContact() {
        contacts.entries.append(Contact(address: "Subway", firstName: "Peter", lastName: "File", imageURL: "http://www.brandchannel.com/wp-content/uploads/2015/08/subway-jared-fogle-sub-860.jpg"))
        contacts.entries.append(Contact(address: "indover", firstName: "Ben", lastName: "Dover", imageURL: "https://acsbore.files.wordpress.com/2011/09/ben-dover_wordpress.jpg"))
        contacts.entries.append(Contact(address: "6feetunder", firstName: "Adolf", lastName: "Hitler", imageURL: "http://i.imgur.com/LuRFBBm.jpg"))
        contacts.entries.append(Contact(address: "behind", firstName: "Hugh", lastName: "Jazz", imageURL: "https://pbs.twimg.com/profile_images/509424292954918912/JSF45qB6.jpeg"))
        contacts.entries.append(Contact(address: "downunder", firstName: "Mike", lastName: "Litoris", imageURL: "http://clubaristo.net/forums/attachment.php?attachmentid=5076&d=1233188341"))
        contacts.entries.append(Contact(address: "downunder", firstName: "Sam", lastName: "Pound", imageURL: "http://img.ifcdn.com/images/164c717b7b29257727278c500b85f0d5ecb4d504a758df22ffe6894d1230a0ba_1.jpgx"))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        contacts.save()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segue
    
    //when a cell is selected segue to the detail view to display details
    //when the add button is pressed segue to the detail view to creat a new Photo
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier where identifier == "showDetail" {
            let vc = segue.destinationViewController as! DetailViewController
            
            if let indexPaths = self.tableView.indexPathsForSelectedRows {
                let indexPath = indexPaths[0] as NSIndexPath
                index = indexPath.row
                vc.contact = contacts.entries[index]
                vc.update = true
                vc.delegate = self
            }
        }
        if let identifier = segue.identifier where identifier == "addButton" {
            let vc = segue.destinationViewController as! DetailViewController
            vc.contact = Contact(address: "", firstName: "", lastName: "", imageURL: "")
            vc.update = false
            vc.delegate = self
        }
    }
    
    // MARK: - Download
    
    //downloads the images for the collection view in the background so thatt he UI is still responsive
    //the image is set to a defual no image at the begining while the actual image is being downloaded
    //if the image could not be downlaoded then the defualt image will be displayed
    func loadPhotoInBackground(contact: Contact){
        //defualt image
        let image = UIImage(named: "no-image.png")!
        let photoData = UIImagePNGRepresentation(image)!
        //defualt image data
        let noPhoto = NSData(data: photoData)
        if contact.image == nil {
            contact.image = noPhoto
        }
        //photo.imageData = noPhoto
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        let backgroundDownload = {
            if let data = NSData(contentsOfURL:NSURL(string: contact.imageURL)!){
                let mainQueue = dispatch_get_main_queue()
                dispatch_async(mainQueue, {
                    contact.image = data
                    self.tableView!.reloadData()
                })
            }else {
                print("Could not download image'\(contact.imageURL)'")
                contact.image = noPhoto
            }
        }
        dispatch_async(queue, backgroundDownload)
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.entries.count
    }
    
    //sets the content of the dynamic reusalbe cells to be the content of the contacts arrays contacts
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = contacts.entries[indexPath.row]
        //sets the text and image of the contacts in the table view to be that of the contacts in the contact list
        if let contactCell = cell as? ContactUITableViewCell {
            contactCell.fullName!.text = object.fullName()
            contactCell.imageDisplay.image = UIImage(data: object.image!)
        }
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
            contacts.save()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the list, and add a new row to the table view.
        }
    }
    
}

