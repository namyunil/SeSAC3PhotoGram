//
//  AddView.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/28.
//

import UIKit

class AddView: BaseView { // 레이아웃 관련..
    
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let searchButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let searchProtocolButton = {
        let view = UIButton()
        view.backgroundColor = .brown
        return view
    }()
    
    let dateButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle(DateFormatter.today(), for: .normal)
        return view
    }()
    
    let titleButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle("오늘의 사진", for: .normal)
        return view
    }()
    
    let titleClosureButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle("클로저 데이터 받아오기", for: .normal)
        return view
    }()
    
    
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
        addSubview(dateButton)
        addSubview(searchProtocolButton)
        addSubview(titleButton)
        addSubview(titleClosureButton)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leading.trailingMargin.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
            
        }
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        searchProtocolButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.leading.equalTo(photoImageView)
        }
        
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        titleClosureButton.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
    
}
