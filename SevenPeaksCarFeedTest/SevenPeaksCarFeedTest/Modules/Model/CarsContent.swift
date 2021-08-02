//
//  CarsContent.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 30, 2021

import Foundation

public class CarsContent : NSObject, Codable {
    
    let descriptionField : String?
    let subject : String?
    let type : String?
    
    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case subject = "subject"
        case type = "type"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        subject = try values.decodeIfPresent(String.self, forKey: .subject)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }
    func encode(with coder: Decoder) {
        
    }
}
