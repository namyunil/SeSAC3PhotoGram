//
//  DateView.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/29.
//

import UIKit
import SnapKit

class DateView: BaseView {

    
    let picker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels //Wheels 방식 -> 본질적 높이가 설정이 되어있음 -> 위와 양 옆 레이아웃만 잡아도 되는..!
        return view
    }()
    
    override func configureView() {
        addSubview(picker)
    }
    
    
    override func setConstraints() {
        picker.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
