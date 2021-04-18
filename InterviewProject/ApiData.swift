//
//  ApiData.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-18.
//

import Foundation

struct ApiData: Codable {
    
    let message: [String]
    let status: String
    
    init() {
        message = [String]()
        status = ""
    }
    
    var count : Int {
        return message.count
    }
}
