//
//  JavaScriptMethod.swift
//  ShellApp
//
//  Created by dixon on 16/7/1.
//  Copyright © 2016年 Monaco1. All rights reserved.
//

import UIKit
import JavaScriptCore

class JavaScriptMethod: NSObject,JavaScriptMethodProtocol {

    var vc:UIViewController!
    
    init(vc:UIViewController) {
        self.vc = vc
    }
    
    var value: String {
        get { return ""}
        set {          }
    }
    
    
    func postContent111(value: String, _ number: String) {
        NSLog("post content = %@", value)
    }
    
    func postContent(value: String, number: String) {
        NSLog("post number = %@", value)
    }
    
    func postAlertContent(title: String, message: String) {
        
        
        dispatch_async(dispatch_get_main_queue(), {
            // code here
            let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (action:UIAlertAction) in
                
            }
            ac.addAction(action)
            self.vc.presentViewController(ac, animated: true, completion: nil)
        })
    }
    
    func postByFunction(title: String, _ message: String) {
        
        dispatch_async(dispatch_get_main_queue(), {
            // code here
            let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (action:UIAlertAction) in
                
            }
            ac.addAction(action)
            self.vc.presentViewController(ac, animated: true, completion: nil)
        })
    }
}
