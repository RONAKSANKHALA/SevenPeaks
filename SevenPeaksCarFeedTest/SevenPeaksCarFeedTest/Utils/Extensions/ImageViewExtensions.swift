//
//  ImageViewExtensions.swift
//  SevenPeaksCarFeedTest
//
//  Created by Ronak Sankhala on 30/07/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String) {
        let url = URL(string: url)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { error in
            print(error)
        })
    }
}
