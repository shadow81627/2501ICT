//
//  ViewController.swift
//  MyPhotos
//
//  Created by s5014219 on 20/04/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController {

    var detailViewController: DetailViewController? = nil
    var photoList: [Photo] = []
    
    //when the view loads add a defualt photos
    override func viewDidLoad() {
        super.viewDidLoad()
        // creates a new Photo from with the url
        photoList.append(Photo(url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"))
       
        //download the image data int eh background
        for photo in photoList {
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
                let vc = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                let indexPaths = self.collectionView!.indexPathsForSelectedItems()
                let indexPath = indexPaths![0] as NSIndexPath
                vc.photo = photoList[indexPath.row]
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
                print("Could not download image'\(photo.url)', what were you even thinking?")
            }
        }
        dispatch_async(queue, backgroundDownload)
    }
    
    //MARK: - Collection View
    
    //gets the number of items in the selection returning the count of the array
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    //if there is an image to put into the view then the image data is turned into a image and displayed in the collection view
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        if let picture = photoList[indexPath.row].imageData{
            cell.image.image = UIImage(data: picture)
        }
        return cell
    }
}

