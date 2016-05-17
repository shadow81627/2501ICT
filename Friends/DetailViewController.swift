//
//  DetailViewController.swift
//  Friends
//
//  Created by s5014219 on 12/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

//the delegate for handling actions with the master view
protocol DetailViewControllerDelegate {
    //func update(vc: DetailViewController)
    //func binPressed(vc: DetailViewController)
}

class DetailViewController: UITableViewController {
    
    var delegate: DetailViewController?
    
    var update: Bool?
    
    var contact: Contact?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

