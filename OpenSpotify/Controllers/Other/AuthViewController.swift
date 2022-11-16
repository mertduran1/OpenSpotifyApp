//
//  AuthViewController.swift
//  OpenSpotify
//
//  Created by Mert Duran on 31.08.2022.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    //isimsiz function. anonymous function
    private let webView : WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
        
    }()
    
    public var completionHandler : ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Giriş Yap"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self //burdaki self authviewcontrollerin kendisini temsil eder. self diyerek webviewın yaptığı islerden bende sorumluyum dedik
        self.view.addSubview(webView)
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        webView.load(URLRequest(url: url))
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code"  })?.value else {
                    return
                }
                webView.isHidden = true

                AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
                    DispatchQueue.main.async {
                        self?.navigationController?.popToRootViewController(animated: true)
                        self?.completionHandler?(success)
                    }
                }
    }
   

}
