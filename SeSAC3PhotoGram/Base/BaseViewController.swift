//
//  BaseViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/28.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    var name: String?
    
//    var completionHandler: ((String) -> ())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .white
        print("Base ConfigureView")
        
    }

    func setConstraints() {
        print("Base SetConstraints")
    }
}
