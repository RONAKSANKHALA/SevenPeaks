//
//  CarsFeed.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 30, 2021

import Foundation

struct CarsFeed : Codable {
    
    let content : [CarsFeedContent]?
    let serverTime : Int?
    let status : APIStatus?
    
    enum CodingKeys: String, CodingKey {
        case content = "content"
        case serverTime = "serverTime"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        content = try values.decodeIfPresent([CarsFeedContent].self, forKey: .content)
        serverTime = try values.decodeIfPresent(Int.self, forKey: .serverTime)
        status = try values.decodeIfPresent(APIStatus.self, forKey: .status)
    }
    
}

enum APIStatus: String, Codable {
    case success
}
