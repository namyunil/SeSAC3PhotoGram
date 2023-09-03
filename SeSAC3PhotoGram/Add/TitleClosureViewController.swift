//
//  TitleClosureViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/29.
//

import UIKit
import SnapKit

class TitleClosuerViewController: BaseViewController {
    
    
    let textView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let sampleView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let greenView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    //Closure 값 전달 1.
    var completionHandler: ((String) -> (Void))?
    //var completionHandler: ((String) -> (Void))
    
    
    
    
    deinit {
        print("deinit", self)
    }
    
    func setAnimation() {
        //시작
        sampleView.alpha = 0
        greenView.alpha = 0
        //끝
        //completion handler를 물고 물고, 연쇄적으로 사용할 수 있다..!
        UIView.animate(withDuration: 1, delay: 2, options: .curveLinear) {
            self.sampleView.alpha = 1
            self.sampleView.backgroundColor = .blue
        } completion: { bool in
            
            UIView.animate(withDuration: 1) {
                self.greenView.alpha = 1
            }
            
        }
        
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textView)
        view.addSubview(sampleView)
        view.addSubview(greenView)
        setAnimation()
    }
    
    override func setConstraints() {
        
        greenView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view).offset(80)
        }
        
        sampleView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        completionHandler?(textView.text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //ViewController 내부에서 네트워크 통신이 동작된다면, global로 동작이 될 수 있기때문에
        //UI업데이트를 위해 Main에서 동작할 수 있도록 main.async에서 진행..!!
        DispatchQueue.main.async {
            self.greenView.alpha = 1.0
            
            UIView.animate(withDuration: 0.3) {
                self.greenView.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.greenView.alpha = 1.0
            
            UIView.animate(withDuration: 0.3) {
                self.greenView.alpha = 0.5
            }
        }
    }
    
}
