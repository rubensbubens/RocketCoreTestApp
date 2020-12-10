//
//  WebViewController.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var presenter: WebViewPresenterType!
    
    //MARK: -
    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.updateView()
    }
}

extension WebViewController: WebView {
    func loadURL(_ url: URL) {
        webView.load(URLRequest(url: url))
    }
}

extension WebViewController: WKUIDelegate {
    
}
