//
//  ApiData.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-18.
//

import Foundation

struct Dog: Codable {
    
    let message: [String]
    
    init() {
        message = [String]()
    }
    
    var count : Int {
        return message.count
    }
}
