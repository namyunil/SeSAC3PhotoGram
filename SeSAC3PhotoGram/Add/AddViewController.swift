//
//  ViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/28.
//

import UIKit
import SeSACFramework
import Kingfisher
//Protocol 값 전달 1.
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

protocol PassImageDelegate {
    func receiveImage(image: UIImage)
}

protocol PassImageStringDelegate {
    func receiveImage(image: String)
}
/*
protocol PassImageDataDelegate {
    func receiveData(name: String)
}
*/

//Naming과 Conveition의 측면에서 MainViewController, DetailViewController는 -> 상징적인 의미이기에 지양하자..!
class AddViewController: BaseViewController { // 기능에 대한 분리..!

    
    let mainView = AddView() // rootview를 교체해야한다..!
    
    override func loadView() { // viewDidLoad보다 먼저 호출이 된다, rootview 관련된 내용..! / super 메서드 호출 X -> 이유는?
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        APIService.shared.callRequest(query: "sky")
        
      
//        ClassOpenExample.publicExample()
//        ClassPublicExample.publicExample()
//        ClassPublicExample.internalExample()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
        //addObserver는 신호만 받는다..! selector를 통해 어떻게 행동할 것인가..!
        //name은 post에서 설정한 여러개의 name이 있다면 그 중 어떤 것을 받을 것인가..!
        //addobserver에는 userinfo에 대한 매개변수가 없다..!
        //이미지가 벗어나는 것은 clips to bound를 하지않아서..! 이 부분에 대해서 고려해주면 된다
    }

    
    deinit {
        print("deinit", self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(#function)
        
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
        
        //sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
        //sesacShowAlert(title: <#T##String#>, message: <#T##String#>, ButtonTitle: <#T##String#>, ButtonAction: <#T##(UIAlertAction) -> Void#>)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SelectImage"), object: nil)
    }
    
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        
        print(#function)
        
//        print("selectImageNotificationObserver")
//        print(notification.userInfo?["name"])
//        print(notification.userInfo?["sample"])
        //Key값에 어떤 값이 올지 모르고, 휴먼에러의 가능성이 있기때문에 옵셔널로..!
        
        if let name = notification.userInfo?["name"] as? String { // userInfo타입은 Any 타입이기때문에 Type Casting을 이용해서..!
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    
    
    func showAlert() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { UIAlertAction in
            let vc = AssignmentGalleryViewController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let web = UIAlertAction(title: "웹에서 가져오기", style: .default) { UIAlertAction in
            let vc = AssignmentSearchViewController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(gallery)
        alert.addAction(web)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc func searchButtonClicked() {
       
        showAlert()
        
        
        
        
//
//        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]
//
//        NotificationCenter.default.post(name: NSNotification.Name("RecommanKeyword"), object: nil, userInfo: ["word" : word.randomElement()! ])
//
//
////        present(SearchViewController(), animated: true)
//        // 단순 present -> viewWillAppear 한 번만 / NavigationController 기준으로 push 혹은 fullscreen -> 여러번
//        navigationController?.pushViewController(SearchViewController(), animated: true)
//
    }
    
    
    @objc func dateButtonClicked() {
        //Protocol 값 전달 5.
//        let vc = DateViewController()
//        vc.delegate = self
        
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
//        navigationController?.pushViewController(DateViewController(), animated: true)
        
    }
    
    @objc func searchProtocolButtonClicked() {
        //Protocol 값 전달 5.
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
//        present(SearchViewController(), animated: true)
    }
    
    @objc func titleButtonClicked() {
        let vc = TitleViewController()
        
        //Closure 값 전달 3.
        //CompetionHandler에 대한 정의가 TitleViewController의 프로퍼티인 completionHandler에 할당..!
        //viewDidDisappear에서 아래 코드가 실행된다..!
        //바깥에 있는 함수는 생명이 다 해도 클로저 구문은 뒤 늦게 실행된다..!
        vc.completionHandler = { title, age, push in
            self.mainView.titleButton.setTitle(title, for: .normal)
            print("completionHandler", age, push)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleClosuerButtonClicked() {
        let vc = TitleClosuerViewController()
        vc.completionHandler = { jack in
            self.mainView.titleClosureButton.setTitle(jack, for: .normal)
            print("completionHandler")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureView() { //addSubView
        super.configureView()
        print("Add ConfigureView")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.titleClosureButton.addTarget(self, action: #selector(titleClosuerButtonClicked), for: .touchUpInside)
        
        

//        view.addSubview(photoImageView)
//        view.addSubview(searchButton)

    }
    
    override func setConstraints() { //제약조건
        super.setConstraints()
        print("Add SetConstraints")
//        photoImageView.snp.makeConstraints { make in
//            make.topMargin.leading.trailingMargin.equalTo(view.safeAreaLayoutGuide).inset(10)
//            make.height.equalTo(view).multipliedBy(0.3)
//            
//        }
//        searchButton.snp.makeConstraints { make in
//            make.size.equalTo(50)
//            make.bottom.trailing.equalTo(photoImageView)
//        }
        
    }

}

//protocol 값 전달 4. 실제로 수행하는..!
extension AddViewController: PassDataDelegate {
    
    
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
    
    
}


extension AddViewController: PassImageDelegate {
    func receiveImage(image: UIImage) {
        mainView.photoImageView.image = image
    }
    
    
}

extension AddViewController: PassImageStringDelegate {
    func receiveImage(image: String) {
        print(image)
        
        mainView.photoImageView.kf.setImage(with: URL(string: image))
    }
    
    
}

/*
//Protocol 값 전달 4.
extension AddViewController: PassImageDataDelegate {
    
    func receiveData(name: String) {
        mainView.photoImageView.image = UIImage(systemName: name)
    }
    
    
}
*/
