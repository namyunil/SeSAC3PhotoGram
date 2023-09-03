//
//  AssignmentSearchViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/09/03.
//

import UIKit
import SnapKit
import SwiftyJSON
import Alamofire
import Kingfisher

struct image {
    var full: String
    var thumb: String
}

class AssignmentSearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    var imageList: [image] = []
    
    var delegate: PassImageStringDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    func callRequest(query: String) {
        
        let key = "4XAKUY4o2AszZ3mzeGWxR1J52u0b-jF2Jye0rWE4uB8"
        let url = "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(key)"
        
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                print(#function)
                
                
                for item in json["results"].arrayValue {
                    let thumb = item["urls"]["thumb"].stringValue
                    let full = item["urls"]["full"].stringValue
                    
                    let data = image(full: full, thumb: thumb)
                    self.imageList.append(data)
                    
                    self.mainView.collectionView.reloadData()
                }
                
             
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.searchBar.delegate = self
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
}


extension AssignmentSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.kf.setImage(with: URL(string: imageList[indexPath.row].thumb))
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let full = imageList[indexPath.row].full
//        let url = URL(string: full)
//
//        DispatchQueue.global().async {
//            let data = try! Data(contentsOf: url!)
//
//            DispatchQueue.main.async {
//                self.delegate?.receiveImage(image: UIImage(data: data)!)
//            }
         
        print(indexPath)
//        print(imageList[indexPath.row].full)
        let full = imageList[indexPath.row].full
        print(full)
        delegate?.receiveImage(image: full)
        navigationController?.popViewController(animated: true)
//        }
    }
    
    
}

extension AssignmentSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        imageList = []
        print(#function)
        mainView.searchBar.resignFirstResponder()
        guard let text = mainView.searchBar.text else { return }
        callRequest(query: text)
        
//        mainView.collectionView.reloadData()
    }
}
