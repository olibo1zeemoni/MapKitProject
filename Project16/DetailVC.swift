//
//  DetailVC.swift
//  Project16
//
//  Created by Olibo moni on 20/02/2022.
//

import UIKit
import WebKit

class DetailVC: UIViewController, WKNavigationDelegate {
    
    var capital: Capital?
    var progressView = UIProgressView(progressViewStyle: .default)
    
   
    
    var webView: WKWebView!
    var website = "https://en.wikipedia.org/wiki/"
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // guard let capital = capital else { return }


        let url = URL(string: website + (capital?.title ?? "Pacific_Ocean") )!
        let request = URLRequest(url: url)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        toolbarItems = [progressButton]
        navigationController?.isToolbarHidden = false
        //navigationController?.toolbar.backgroundColor = .gray
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

}
