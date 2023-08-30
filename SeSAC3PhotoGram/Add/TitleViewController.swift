//
//  TitleViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/29.
//

import UIKit
import SnapKit

class TitleViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    //Closure 값 전달 1.
    //var completionHandler: ((String) -> ())? // String 전달
    var completionHandler: ((String, Int, Bool) -> ())? // 다양한 타입 전달
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
    }
    
    @objc func doneButtonClicked() {
        print(#function)
        completionHandler?(textField.text!, 77, false)
        navigationController?.popViewController(animated: true) //present가 아닌 navigationController를 통한 push로 화면 전환이기때문에 pop..!
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //Closure 값 전달 2.
        completionHandler?(textField.text!, 100, true)
    }
}
