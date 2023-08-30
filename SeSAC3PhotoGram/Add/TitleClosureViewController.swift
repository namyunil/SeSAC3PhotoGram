//
//  TitleClosureViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/29.
//

import UIKit
import SnapKit

class TitleClosuerViewController: BaseViewController {
    
    //Closure 값 전달 1.
    var completionHandler: ((String) -> (Void))?
    //var completionHandler: ((String) -> (Void))
    
    
    let textView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    override func configureView() {
        super.configureView()
        view.addSubview(textView)
        
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        completionHandler?(textView.text)
    }
}
