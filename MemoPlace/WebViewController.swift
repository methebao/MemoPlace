//
//  WebViewController.swift
//  MemoPlace
//
//  Created by The Bao on 11/12/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "http://thebao.me"){
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
