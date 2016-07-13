//
//  WKWebViewController.swift
//  ShellApp
//
//  Created by dixon on 16/7/12.
//  Copyright © 2016年 Monaco1. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler {

    var screenFrame = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let config = WKWebViewConfiguration()
        let userContent = WKUserContentController()
        userContent.addScriptMessageHandler(self, name: "callSwift")
        config.userContentController = userContent
        
        let wv = WKWebView(frame: screenFrame, configuration: config)
        wv.navigationDelegate = self
        wv.UIDelegate = self
        wv.tag = 100
        self.view.addSubview(wv)
        
        let htmlFile = NSBundle.mainBundle().pathForResource("test", ofType: "html")
        if let file = htmlFile {
            do{
                let htmlString = try String(contentsOfFile: file,encoding: NSUTF8StringEncoding)
                wv.loadHTMLString(htmlString, baseURL: nil)
            }catch{
                let avc = UIAlertController(title: "info", message: "contentsOfFile went wrong", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (aa:UIAlertAction) in
                    
                })
                avc.addAction(okAction)
                
                self.presentViewController(avc, animated: true, completion: nil)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        let wv:WKWebView = self.view.viewWithTag(100)as! WKWebView
         wv.configuration.userContentController.removeScriptMessageHandlerForName("callSwift")
    }
    
    //wkwebview delegate
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        completionHandler()
        let alert = UIAlertController(title: "ios-alert", message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: { (aa:UIAlertAction) in
            NSLog("handle here")
        }))
        //alert.addAction(UIAlertAction(title: "cancel", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        NSLog("111")
        let dict = message.body as! Dictionary<String,String>
        print(dict)
        let method:String = dict["method"]!
        let param1:String = dict["param1"]!
        if method=="hello"{
            //hello(param1)
        }
    }
}
