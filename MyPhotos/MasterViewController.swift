//
//  ViewController.swift
//  MyPhotos
//
//  Created by s5014219 on 20/04/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController, DetailViewControllerDelegate, PhotoViewControllerDelegate {
    
    var detailViewController: DetailViewController? = nil
    var photoViewController: PhotoViewController? = nil
    //the list of photos
    var photoList = PhotoList()
    var index: Int!
    var update = true
    
    //when the view loads add a defualt photos
    override func viewDidLoad() {
        super.viewDidLoad()
                //loads entries from file
        photoList.load()
        
        // creates a new Photo from with the url if there are no entries
        if photoList.entries.count <= 0 {
        photoList.entries.append(Photo(title: "1", tag: ["2", "3"], url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"))
        /*photoList.entries.append(Photo(title: "1", tag: ["2", "3"], url: "http://i3.kym-cdn.com/photos/images/facebook/000/875/509/533.jpg"))
        photoList.entries.append(Photo(title: "a", url: "http://vignette2.wikia.nocookie.net/uncyclopedia/images/a/ab/Holocausttycoon.jpg/revision/latest/scale-to-width-down/250?cb=20060417145631"))
        photoList.entries.append(Photo(title: "a", url: "http://www.history.co.uk/sites/default/files/adolf-hitler-in-colour.jpg"))
        photoList.entries.append(Photo(title: "a", url: "http://i.imgur.com/LuRFBBm.jpg"))
        photoList.entries.append(Photo(title: "a", url: "http://i.imgur.com/175HatD.jpg"))
        photoList.entries.append(Photo(title: "a", url: "http://i.imgur.com/WeScWlg.jpg"))
        photoList.entries.append(Photo(title: "a", url: "http://img.ifcdn.com/images/3f053896e5d21348200836f5b69f225fc216a3e83b056fa3d7d7e322fc97cf5b_1.jpg"))*/
        photoList.entries.append(Photo(title: "b", url: "https://upload.wikimedia.org/wikipedia/commons/d/d9/Big_Bear_Valley,_California.jpg"))
            
            
        }
        
        //download the image data in the background
        for photo in photoList.entries {
            loadPhotoInBackground(photo)
        }
    }
    
    //add the resign observer
    override func viewWillAppear(animated: Bool){
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "aboutToResign", name: Resign, object: nil)

    }
    
    //removes the resign observer
    override func viewDidDisappear(animated: Bool) {
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self)
    }
    
    //will save the photoList when the app resigns
    func aboutToResign(){
        //saves the photoList to a file so it can be loaded next time the app is opened
        photoList.save()
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
            let vc = segue.destinationViewController as! PhotoViewController
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()
            let indexPath = indexPaths![0] as NSIndexPath
            index = indexPath.row
            vc.photo = photoList.entries[index]
            update = true
            vc.delegate = self
            photoViewController = vc
        }
        if let identifier = segue.identifier where identifier == "addButton" {
            let vc = segue.destinationViewController as! DetailViewController
            vc.photo = Photo(title: "", url: "")
            update = false
            vc.delegate = self
            
        }
    }
    
    // MARK: - Download
    
    //downloads the images for the collection view in the background so thatt he UI is still responsive
    func loadPhotoInBackground(photo: Photo, callback: (NSData?) -> Void = { _ in }){
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        let backgroundDownload = {
            if let data = NSData(contentsOfURL:NSURL(string: photo.url)!){
                let mainQueue = dispatch_get_main_queue()
                dispatch_async(mainQueue, {
                    photo.imageData = data
                    self.collectionView!.reloadData()
                    callback(data)
                })
            }else {
                callback(nil)
                print("Could not download image'\(photo.url)'")
            }
        }
        dispatch_async(queue, backgroundDownload)
    }
    
    // MARK: - Delegates
    
    //removes the a selected photo from the photo list
    func binPressed(vc: DetailViewController){
        photoList.entries.removeAtIndex(index)
        update =  true // set the detal view flag to be cancel
        self.navigationController?.popViewControllerAnimated(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //if the flag update is true then the photoList will be updated
    //if the flag is not update then a new entrie will be added
    //after the photoList has been added to or updated it will then be saved to file
    func update(vc: DetailViewController, callback: (NSData?) -> Void = { _ in }) {
        if(update){
            loadPhotoInBackground(vc.photo!, callback: callback)
            //photoViewController!.photo = vc.photo
            self.collectionView!.reloadData()
        //adds the photos detials entered in the detial view to the list of contacts
        }else if(!update && (vc.photo?.url != nil && vc.photo?.url != "")){
            loadPhotoInBackground(vc.photo! )
            photoList.entries.insert(vc.photo!, atIndex: 0)
            self.collectionView!.reloadData()
        }else {
            //dont do anything becuase you probably want to cancel at this point
        }
        //saves the photoList to a file so it can be loaded next time the app is opened
        //photoList.save()
    }
    
    // MARK: - PhotoViewDelegates
    
    //gives the PhotoView the previous Photo in the collection
    func previousPhoto(vc: PhotoViewController){
        if index == 0 {
            index = photoList.entries.count - 1
        }else{
            index = index - 1
        }
        vc.photo = photoList.entries[index]
    }
    
    //gives the PhotoView the Next Photo int he collection
    func nextPhoto(vc: PhotoViewController){
        if index == photoList.entries.count - 1 {
            index = 0
        }else{
            index = index + 1
        }
        vc.photo = photoList.entries[index]
    }
    
    
    //MARK: - Collection View
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //gets the number of items in the selection returning the count of the array
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.entries.count
    }
    
    //if there is an image to put into the view then the image data is turned into a image and displayed in the collection view
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        if let picture = photoList.entries[indexPath.row].imageData{
            cell.image.image = UIImage(data: picture)
        }
        return cell
    }
}