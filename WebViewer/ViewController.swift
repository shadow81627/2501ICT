//
//  ViewController.swift
//  WebViewer
//
//  Created by s5014219 on 11/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //makes the keyboard disappear when you hit return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        guard let url = NSURL(string: urlField.text!) else { return false}
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        return true
    }


}
