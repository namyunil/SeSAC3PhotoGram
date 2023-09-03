//
//  URLSessionViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/30.
//

import UIKit

// 해당하는 코드를 기억하고 잘 짜는 게 아니라.
// 어떤 특성이 있는지 알고, 그래서 Alamofire에서 이렇게 구현을 했구나를 이해하는 관점

class URLSessionViewController: UIViewController {
    
    var session: URLSession!
    
    var total: Double = 0 // Contents-Length
    
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100)%"
            //"\(Int(result * 100))%"
            print(result , total)
        }
    }
    
    let progressLabel = {
        let view = UILabel()
        view.backgroundColor = .black
        view.textColor = .white
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buffer = Data() // buffer?.append(data)가 실행되기 위함
        //처음 buffer를 선언할때 초기화를 해줘도 된다..!
        
        view.addSubview(progressLabel)
        view.addSubview(imageView)
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
        view.backgroundColor = .white
        
        
        
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        // shared session은 delegate와 함께 사용이 불가하기에 configuration에 .shared가 없음..!
        // shared session과 default session은 거의 동일하다..!
        // delegate 메서드를 어디서 구현할거야? -> delegateQueue: .main에서 실행..!
        
        
        
//        URLSession.shared.dataTask(with: <#T##URLRequest#>) { <#Data?#>, <#URLResponse?#>, <#Error?#> in
//            <#code#>
//        }
        //URLSession.shared -> session으로..!
        
        session.dataTask(with: url!).resume()
        //completionHandler (Closure 구문) 이 아닌 delegate를 선택하여 클로저가 아닌 extension의 delegate..!..!
    }
    
    
    //카카오톡 사진 다운로드: 다운로드 중에 다른 채팅방으로 넘어가면? 취소 버튼?
    //어떤 앱을 구현하느냐에 따라 다르겠지만..!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //취소 액션(화면이 사라질 때 등)
        session.invalidateAndCancel() //리소스 정리, 실행중인 것도 무시
        
        //기다렸다가 리소스 끝나면 정리
        session.finishTasksAndInvalidate() // 데이터 3개를 받아야하는데, 1개는 받고 나머지는 안받는..!
    }
    
    
}




extension URLSessionViewController: URLSessionDataDelegate {
    
//    //서버에서 최초로 응답 받은 경우에 호출(상태코드 처리) // 100MB // 서버에 대한 헤더에 대한 내용을 도출 할 수 있는..
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("RESPONSE", response)
        
        if let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) {
            
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!) ?? 0
            
            return .allow
        } else {
            return .cancel
        }
    }
    
    //서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA:", data)
        buffer?.append(data) // buffer가 nil이면 append 구문 실행 X
    }
    
    //서버에서 응답이 완료가 된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
        
        if let error {
            print(error)
            
        } else {
            
            guard let buffer = buffer else {
                print(error)
                return
            }
            
            imageView.image = UIImage(data: buffer) // dispatchqueue.main.async를 하지않았지만
        }
    }
    
}
