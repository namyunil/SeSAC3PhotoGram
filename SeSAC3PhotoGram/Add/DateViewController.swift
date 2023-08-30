//
//  DateViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/29.
//

import UIKit
import SnapKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    //Protocol 값 전달 2. 일을 본격적으로 해야하는 VC가 부하직원인 delegate를 갖고있다
    var delegate: PassDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //Protocol 값 전달 3. 필요한 시점에 값을 전달
        delegate?.receiveDate(date: mainView.picker.date)
    }
    
}
