//
//  SearchView.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/28.
//

import UIKit

class SearchView: BaseView {
    
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        return view
    }()
    
    lazy var collectionView = { // collectionView는 flowlayout을 통해 레이아웃을 잡아줬기 때문에 아래와 같이..
        //클로저 구문과 뷰에 대한 로드 시점으로 인해 -> lazy var..!
//        let view = UICollectionView()
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        view.collectionViewLayout = collectionViewLayout()
        return view
    }()
    
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        // 레이아웃이 문제여서 안보이는 경우가 많은데..!
        // 디버그 팁) 메서드 호출 점검 -> 고정적인 사이즈를 넣어보기.. -> 원하는 사이즈로 수정..
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 40 //200 //self.frame.width - 40
        layout.itemSize = CGSize(width: size / 4, height: size / 4)
        return layout
    }
    
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
}
