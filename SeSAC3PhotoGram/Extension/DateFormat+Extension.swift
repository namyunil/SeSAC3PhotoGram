//
//  DateFormat+Extension.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/08/29.
//

import Foundation

//static 기준으로 dateformat 구성..!

extension DateFormatter {
    
    static let format = {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        return format
    }()
    
    static func today() -> String {
        return format.string(from: Date())
    }
    
    static func convertDate(date: Date) -> String {
        return format.string(from: date)
    }
    
}
