//
//  MasterViewController.swift
//  Friends
//
//  Created by s5014219 on 12/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var contacts = ContactList()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        contacts.entries.append(Contact(address: "someAddress", firstName: "peter", lastName: "file", imageURL: "http://epaper2.mid-day.com/images/no_image_thumb.gif"))
        contacts.entries.append(Contact(address: "someAddress", firstName: "Ben", lastName: "Dover", imageURL: "http://epaper2.mid-day.com/images/no_image_thumb.gif"))
        
        for contact in contacts.entries {
            loadPhotoInBackground(contact)
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Download
    
    //downloads the images for the collection view in the background so thatt he UI is still responsive
    // the image is set to a defual no image at the begining while the actual image is being downloaded
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = contacts.entries[indexPath.row]
        if let contactCell = cell as? ContactUITableViewCell {
            contactCell.fullName!.text = object.fullName()
            if let imageData = object.image {
                 contactCell.imageDisplay.image = UIImage(data: object.image!)
            }
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
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the list, and add a new row to the table view.
        }
    }
    
}

