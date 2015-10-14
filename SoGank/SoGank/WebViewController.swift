//
//  WebViewController.swift
//  SoGank
//
//  Created by ule_shengyangyu on 15/10/14.
//  Copyright © 2015年 ule_shengyangyu. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {

    var showURL:String?
    
    @IBOutlet weak var sWebView: UIWebView!
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        showURL = String()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        showURL = String()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let urlRequest = NSURLRequest(URL :NSURL(string: showURL!)!)
        sWebView.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // 清除缓存
        NSURLCache.sharedURLCache().removeAllCachedResponses()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        sWebView.loadHTMLString("", baseURL: nil)
        sWebView.stopLoading()
        sWebView = nil
        NSURLCache.sharedURLCache().removeAllCachedResponses()
    }
    
    // MARK: webview delegate
    func webViewDidFinishLoad(webView: UIWebView) {
        
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "WebKitCacheModelPreferenceKey")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "WebKitDiskImageCacheEnabled")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "WebKitOfflineWebApplicationCacheEnabled")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
