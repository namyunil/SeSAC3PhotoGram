//
//  SearchViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/28.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchViewController: BaseViewController {
    
//    let searchBar = {
//        let view = UISearchBar()
//        view.placeholder = "검색어를 입력해주세요"
//        return view
//    }()
    
    let mainView = SearchView()
    
    let imageList = ["pencil", "star", "person", "star.fill", "xmark", "person.circle"] // 애플의 system image 배열
    
    var delegate: PassImageDelegate? // Optional -> 초기화 필요가 없어지기때문..!
    
    //var delegate: PassImageDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //addObserver보다 post가 먼저 신호를 보내면 받을 수 없다..!
        //메모리에 addObserver가 먼저 등록되어있어야 post의 값을 전달받을 수 있다..!
        //따라서 아래 코드는 post가 선행(신호를 먼저 보내고) 후 addObserver가 등록되어 정상작동하지 않는다..!
        //post와 addObeserver의 순서는 중요하다..! -> addOsberver가 등록 된 후 Post가 되어야한다..!
        
        NotificationCenter.default.addObserver(self, selector: #selector(recommandKeywordNotificationObserver), name: NSNotification.Name("RecommendKeyword"), object: nil)
        
        //UX를 더 편하게..! 버튼 클릭시 키보드가 바로 보이도록 하는 기능
        mainView.searchBar.becomeFirstResponder() // 클릭하지않아도 클릭한 것 같은 반응으로..!
        mainView.searchBar.delegate = self
    }
    
    @objc func recommandKeywordNotificationObserver(notification: NSNotification) {
        print("recommandKeywordNotificationObserver")
    }
    
    
    override func configureView() {
        super.configureView()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        //self.addSubview(searchBar)
    }
    
//    override func setConstraints() {
//        super.setConstraints()
//        searchBar.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalToSuperview()
//        }
//    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.resignFirstResponder()
        //사용자의 Focus가 Searchbar에 없다.
        //Search 버튼을 눌렀을때 키보드가 내려가는 기능..!
        // 의도적으로 버튼을 누르지 않은 것과 같은 반응으로..!
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(imageList[indexPath.item])
        
        //protocol 통해 값 전달
        
        
        //Notification을 통한 값 전달
//        NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name" : imageList[indexPath.item], "sample" : "고래밥"] ) // 앱 내부적으로..
        
        
        delegate?.receiveImage(image: UIImage(systemName: imageList[indexPath.item])!)

        
        dismiss(animated: true)
    }
    
}
