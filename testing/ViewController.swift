//
//  ViewController.swift
//  testing
//
//  Created by Anil on 23/05/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func downloadAction(sender: AnyObject) {
        println("hello")
        
        SwiftSpinner.show("Downloading...", animated: true)
        if let checkedUrl = NSURL(string: "http://hdwallpaperd.com/wp-content/uploads/hd-widescreen-wallpapers-4.jpg") {
            downloadImage(checkedUrl)
        }
        
    }
    
    func downloadImage(url:NSURL){
        println("Started downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                
                SwiftSpinner.show("Downloading Completed", animated: false)
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    var path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent("Image1") as String
                    println(path)
                    data!.writeToFile(path, atomically: true)
                    SwiftSpinner.hide()
                    UISaveVideoAtPathToSavedPhotosAlbum(path, nil, nil, nil)
                }
            }
        }
    }
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: NSData(data: data))
            }.resume()
    }
}

