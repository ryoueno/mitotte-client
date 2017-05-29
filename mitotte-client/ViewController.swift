//
//  ViewController.swift
//  mitotte-client
//
//  Created by 上野 涼 on 2017/05/29.
//  Copyright © 2017年 上野 涼. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    @IBOutlet weak var WebView: WebView!
    var targetURL = "http://localhost"

    override func viewDidLoad() {
        super.viewDidLoad()

        WebView.mainFrame.load(URLRequest(url: URL(string: targetURL)!))
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

