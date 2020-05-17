//
//  WebviewViewController.swift
//  BoardNews
//
//  Created by Serina Chen on 5/16/20.
//  Copyright © 2020 Serina Chen. All rights reserved.
//

import UIKit

class WebviewViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.loadRequest(URLRequest(url: URL(string: url)!))
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
  


}
