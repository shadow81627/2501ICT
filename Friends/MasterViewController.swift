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
    var managedObjectContext: NSManagedObjectContext? = nil
   //the list of all the contacts that are displayed in the table view
    
    var index: Int!
    var update = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        //insertNewObject(self)
        
    }
    
    func insertNewObject(sender: AnyObject) {
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        let contact = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as! Contact
        
        contact.address = "stuff"
        contact.firstName = "bob"
        contact.lastName = "bill"
        contact.imageURL = "http://i.imgur.com/LuRFBBm.jpg"
        loadPhotoInBackground(contact)
        
        
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
    
    //adds a bunch of defualt contacts to the table view
    /*func insertDefualtContact() {
        contacts.entries.append(Contact(address: "Subway", firstName: "Peter", lastName: "File", imageURL: "http://www.brandchannel.com/wp-content/uploads/2015/08/subway-jared-fogle-sub-860.jpg"))
        contacts.entries.append(Contact(address: "indover", firstName: "Ben", lastName: "Dover", imageURL: "https://acsbore.files.wordpress.com/2011/09/ben-dover_wordpress.jpg"))
        contacts.entries.append(Contact(address: "6feetunder", firstName: "Adolf", lastName: "Hitler", imageURL: "http://i.imgur.com/LuRFBBm.jpg"))
        contacts.entries.append(Contact(address: "behind", firstName: "Hugh", lastName: "Jazz", imageURL: "https://pbs.twimg.com/profile_images/509424292954918912/JSF45qB6.jpeg"))
        contacts.entries.append(Contact(address: "downunder", firstName: "Mike", lastName: "Litoris", imageURL: "http://clubaristo.net/forums/attachment.php?attachmentid=5076&d=1233188341"))
        contacts.entries.append(Contact(address: "downunder", firstName: "Sam", lastName: "Pound", imageURL: "http://img.ifcdn.com/images/164c717b7b29257727278c500b85f0d5ecb4d504a758df22ffe6894d1230a0ba_1.jpgx"))
    }*/
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    //when a cell is selected segue to the detail view to display details
    //when the add button is pressed segue to the detail view to creat a new Photo
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let contact = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Contact
                let controller = segue.destinationViewController as! DetailViewController
                controller.contact = contact
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        if let identifier = segue.identifier where identifier == "addButton" {
            let vc = segue.destinationViewController as! DetailViewController
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
    
    // MARK: - Delegates
    
    //if the flag update is true then the photoList will be updated
    //if the flag is not update then a new entrie will be added
    //after the photoList has been added to or updated it will then be saved to file
    func update(vc: DetailViewController) {
        if((update){
            loadPhotoInBackground(vc.contact!)
            self.tableView!.reloadData()
            //adds the photos detials entered in the detial view to the list of contacts
        }else if(!update && (vc.contact?.url != nil && vc.contact?.url != "")){
            loadPhotoInBackground(vc.contact! )
            photoList.entries.insert(vc.photo!, atIndex: 0)
            self.tableView!.reloadData()
        }else {
            //dont do anything becuase you probably want to cancel at this point
        }
        //saves the photoList to a file so it can be loaded next time the app is opened
        photoList.save()
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Contact
        self.configureCell(cell, contact: object)
        
        return cell

    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //print("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }
    
    //sets the text and image of the contacts in the table view to be that of the contacts in the contact list
    func configureCell(cell: UITableViewCell, contact: Contact) {
        if let contactCell = cell as? ContactUITableViewCell {
            contactCell.fullName!.text = contact.fullName()
            //contactCell.imageDisplay.image = UIImage(data: contact.image!)
        }
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Contact", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            let object = self.fetchedResultsController.objectAtIndexPath(indexPath!) as! Contact
            self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, contact: object)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    /*
    // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
    // In the simplest, most efficient, case, reload the table view.
    self.tableView.reloadData()
    }
    */
    
}



