//
//  HomeViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/31.
//

import UIKit

//AnyObject: 클래스에서만 프로토콜을 정의할 수 있도록 제약
protocol HomeViewProtool: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {
    
    var list: Photo = Photo(total:0 , total_pages:0, results: []) // 서버에서 응답을 받기전에 컬렉션 뷰는 이미 그리기때문에 오류가 생긴다..!
    
    let mainView = HomeView()
    
    override func loadView() {
        
        mainView.delegate = self
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        
        APIService.shared.callRequest(query: "sky") { photo in
            //photo는 옵셔널 타입이다..! -> 오류 대응을 위해 조건문으로 대응한다..!
           
            guard let photo = photo else {
                print("ALERT Error")
                return
            }
            
            print("API END")
            self.list = photo // 네트워크 통신 전후로 데이터가 변경됨.
            
            //url session을 사용하면 -> 내부적으로 background thread로 바뀌게되는데..!
            // 1. dispatchQueue.main.async를 통해 담아준다.
//            DispatchQueue.main.async {
//                self.mainView.collectionView.reloadData()
//            }
            
            self.mainView.collectionView.reloadData() // callRequest 내부에 구현하면 매번 dispatchqueue를 부르지않아도된다.
            
        }
    }
    
    deinit {
        print(self, #function)
    }
}

extension HomeViewController: HomeViewProtool {
    
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.backgroundColor = .systemBlue
        
        //String -> URL -> Data -> Image
        let thumb = list.results[indexPath.item].urls.thumb
        
        let url = URL(string: thumb) // 링크를 기반으로 이미지를 보여준다? >>> 네트워크 통신임!!!
        
        
        DispatchQueue.global().async {
            
            let data = try! Data(contentsOf: url!) // 동기적으로 작동하는 코드 -> background에서 동작하도록..! -> 비동기적으로 작동할 수 있도록
            
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            } //4주차때 했던 코드..!
            
        }
        
        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)
//        delegate?.didSelectItemAt(indexPath: indexPath)
    }
}
