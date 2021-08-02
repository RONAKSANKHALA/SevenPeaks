//
//  CarsContaintMain.swift
//  SevenPeaksCarFeedTest
//
//  Created by Ronak Sankhala on 30/07/21.
//

import Foundation

struct CarsArticleContent : Codable {

        let changed : Int?
        let content : [CarsContent]?
        let created : Int?
        let dateTime : String?
        let id : Int?
        let image : String?
        let ingress : String?
        let tags : [AnyObject]?
        let title : String?

        enum CodingKeys: String, CodingKey {
                case changed = "changed"
                case content = "content"
                case created = "created"
                case dateTime = "dateTime"
                case id = "id"
                case image = "image"
                case ingress = "ingress"
                case tags = "tags"
                case title = "title"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                changed = try values.decodeIfPresent(Int.self, forKey: .changed)
                content = try values.decodeIfPresent([CarsContent].self, forKey: .content)
                created = try values.decodeIfPresent(Int.self, forKey: .created)
                dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                image = try values.decodeIfPresent(String.self, forKey: .image)
                ingress = try values.decodeIfPresent(String.self, forKey: .ingress)
            if let tag = values.decodeIfPresent([AnyObject].self, forKey: .tags) {
                tags = tag
            }
                title = try values.decodeIfPresent(String.self, forKey: .title)
        }

}
