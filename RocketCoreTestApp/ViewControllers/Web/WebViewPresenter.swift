//
//  WebViewPresenter.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation

protocol WebView: class {
    func loadURL(_ url: URL)
}

protocol WebViewPresenterType {
    func updateView()
}

struct WebViewPresenter: WebViewPresenterType {
    weak var view: WebView?
    var url: URL
    
    func updateView() {
        view?.loadURL(url)
    }
}
