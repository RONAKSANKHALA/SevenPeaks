//
//  CarsFeedTableViewCell.swift
//  SevenPeaksCarFeedTest
//
//  Created by Ronak Sankhala on 30/07/21.
//

import UIKit
import Kingfisher

class CarsFeedTableViewCell: UITableViewCell {

    @IBOutlet var imgCar: UIImageView!
    @IBOutlet var lblCarName: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblDetails: UILabel!
    @IBOutlet var viewGradient: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var articles: Article? {
        didSet {
            if let data = articles {
                if let strURL = data.image {
                    imgCar.setImage(url: strURL)
                }
                self.lblDetails.text = data.ingress
                self.lblDate.text = CommonFunctions.Instance.stringToDate(stringDate: data.dateTime)
                self.lblCarName.text = data.title
            }
        }
    }
}

