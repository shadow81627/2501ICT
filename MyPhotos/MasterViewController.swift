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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        photoList.append(Photo(url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segue
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
                print("Could not download image'\(photo.url)'")
            }
        }
        dispatch_async(queue, backgroundDownload)
    }
}

