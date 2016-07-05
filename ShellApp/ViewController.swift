//
//  ViewController.swift
//  ShellApp
//
//  Created by dixon on 16/6/20.
//  Copyright © 2016年 Monaco1. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol JavaScriptMethodProtocol: JSExport {
    var value: String {get set}
    //对应JavaScript中callSwift.postContent方法
    //有下划线表示下划线后面的参数名和js 函数名没有关系
    func postContent111(value: String,_ number: String)
    //对应JavaScript中callSwift.postContentNumber方法
    func postContent(value: String, number: String)
    
    func postAlertContent(title: String, message: String)
    
    func postByFunction(title:String,_ message:String)
}

@objc class ViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet var wv:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "js 与 swift 简单通信"
        
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        NSURLCache.sharedURLCache().diskCapacity = 0
        NSURLCache.sharedURLCache().memoryCapacity = 0
        
        //self.navigationController?.hidesBarsOnSwipe = true
        
//        let urlString = "http://m.daiyuehuajck.com/mobile/"
//        let url = NSURL(string: urlString)
//        if let tempUrl = url {
//            let request = NSURLRequest(URL: tempUrl)
//            wv.loadRequest(request)
//        }

        
        
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
        
        let backBarButtonItem = createBarButton("cc_webview_back.png", action: #selector(ViewController.back(_:)))
        let forwardBarButtonItem = createBarButton("cc_webview_forward.png", action: #selector(ViewController.forward(_:)))
        self.navigationItem.leftBarButtonItems = [backBarButtonItem,forwardBarButtonItem]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //webview delegate
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let jsContext = webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext
        jsContext?.setObject(JavaScriptMethod(vc: self), forKeyedSubscript: "callSwift")
    }
    
    //click method
    func back(sender:UIButton) -> Void {
        if wv.canGoBack {
            wv.goBack()
        }
    }
    
    func forward(sender:UIButton) -> Void {
        if wv.canGoForward {
            wv.goForward()
        }
    }
    
    //custom method
    
    func createBarButton(imageName:String,action:Selector) -> UIBarButtonItem {
        let backImage = UIImage(named: imageName)
        backImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let btn_back = UIButton(type: UIButtonType.Custom)
        btn_back.frame = CGRectMake(0, 0, 21, 17)
        btn_back.tintColor = UIColor.orangeColor()
        btn_back.setImage(backImage!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        btn_back.addTarget(self, action:action , forControlEvents: UIControlEvents.TouchUpInside)

        let barButtonItem = UIBarButtonItem(customView: btn_back)
        return barButtonItem
    }
    
    
}

