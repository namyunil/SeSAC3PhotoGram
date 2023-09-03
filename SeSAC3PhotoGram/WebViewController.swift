//
//  WebViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/29.
//
import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {
    
    var webView = WKWebView()
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadView를 통해서 webView를 갈아끼는게 아니라면?
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(100)
        }
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        //네비게이션 컨트롤러가 처음에는 투명, 스크롤 하면 불투명해지는 특성
        //네비게이션을 디자인하려면? UINavigationBarAppearance
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        
        
        navigationController?.navigationBar.standardAppearance = appearance // 스크롤이 될 때 / 처음 투명, 스크롤하면 색깔
        navigationController?.navigationBar.scrollEdgeAppearance = appearance // 'edge'-> 스크롤이 끝난 상태, 시작 할 때/ 처음 색깔, 스크롤하면 투명
        navigationController?.navigationBar.isTranslucent = false // 네비게이션 바의 투명도에 따라 루트뷰의 범주가 달라진다
        
        title = "이건 웹뷰입니다"
    }
    
    
    func reloadButtonClicked() {
        webView.reload()
    }
    
    func goBackButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}
