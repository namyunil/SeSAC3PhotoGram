//
//  APIService.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/30.
//

import Foundation

class APIService {
    
    //init() { } //internal 접근 레벨 -> 모든 모듈(프로젝트) 내에서 접근 가능
    private init() { } // 접근 제어를 하지 않는다면
    
    private let key = "4XAKUY4o2AszZ3mzeGWxR1J52u0b-jF2Jye0rWE4uB8"
    
    static let shared = APIService()
    //shared를 통해서만 인스턴스 생성 가능 -> 인스턴스 생성 방지
    //하나의 인스턴스, 객체를 타입 프로퍼티로 저장..!
    //접근 제어를 private으로 해도 객체가 생성 가능한 이유는? -> 같은 클래스 내부에 있기에 가능하다.
    
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(key)") else { return }
        
        let request = URLRequest(url: url, timeoutInterval: 10)
        
        URLSession.shared.dataTask(with: request) { data, response, error in //global
            
            
            DispatchQueue.main.async {
                
                if let error = error {
                    completionHandler(nil) // 문제가 생겼을 경우에 사용자에게 noti를 해줘야하기때문에 각각의 경우에
                    print(error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    completionHandler(nil)
                    print(error) // 문제 해결 -> Alert 또는 Do Try Catch 등으로 대응
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return }
                
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                    print(result)
                } catch {
                    completionHandler(nil)
                    print(error) // 디코딩 오류 키
                }
                
            }
            
            
//            let value = String(data: data!, encoding: .utf8)
            
            
        }.resume()
    }
    
}


struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
