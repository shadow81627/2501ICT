//
//  ViewController.swift
//  MyPhotos
//
//  Created by s5014219 on 20/04/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController, DetailViewControllerDelegate {
    
    var detailViewController: DetailViewController? = nil
    var photos = PhotoList()
    
    //when the view loads add a defualt photos
    override func viewDidLoad() {
        super.viewDidLoad()
        // creates a new Photo from with the url
        photos.entries.append(Photo(title: "1", tag: ["2", "3"], url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"))
        photos.entries.append(Photo(url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"))
        photos.entries.append(Photo(url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"))
        photos.entries.append(Photo(url: "https://upload.wikimedia.org/wikipedia/commons/d/d9/Big_Bear_Valley,_California.jpg"))
        
        //download the image data in the background
        for photo in photos.entries {
            loadPhotoInBackground(photo)
        }
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
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()
            let indexPath = indexPaths![0] as NSIndexPath
            vc.photo = photos.entries[indexPath.row]
            vc.update = true
            vc.delegate = self
        }
        if let identifier = segue.identifier where identifier == "addButton" {
            let vc = segue.destinationViewController as! DetailViewController
            vc.photo = Photo(url: "")
            vc.update = false
            vc.delegate = self
            
        }
    }
    
    // MARK: - Download
    
    //downloads the images for the collection view in the background so thatt he UI is still responsive
    func loadPhotoInBackground(photo: Photo){
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        let backgroundDownload = {
            if let data = NSData(contentsOfURL:NSURL(string: photo.url)!){
                let mainQueue = dispatch_get_main_queue()
                dispatch_async(mainQueue, {
                    photo.imageData = data
                    self.collectionView!.reloadData()
                })
            }else {
                print("Could not download image'\(photo.url)'")
            }
        }
        dispatch_async(queue, backgroundDownload)
    }
    
    // MARK: -Delegates
    
    //removes the detail views photo from the photo list
    func binPressed(vc: DetailViewController){
        photos.entries.removeAtIndex(0)
        vc.update =  true // set the detal view flag to be cancel
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //
    func update(vc: DetailViewController) {
        self.collectionView!.reloadData()
        if(vc.update){
            self.collectionView!.reloadData()
        //adds the photos detials entered in the detial view to the list of contacts
        }else if(!vc.update){
            photos.entries.insert(vc.photo!, atIndex: 0)
        }else {
            //dont do anything becuase you probably want to cancel at this point
        }
    }
    
    //MARK: - Collection View
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //gets the number of items in the selection returning the count of the array
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.entries.count
    }
    
    //if there is an image to put into the view then the image data is turned into a image and displayed in the collection view
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        if let picture = photos.entries[indexPath.row].imageData{
            cell.image.image = UIImage(data: picture)
        }
        return cell
    }
}

