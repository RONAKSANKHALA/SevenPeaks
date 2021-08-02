//
//  CommonFunctions.swift
//  SevenPeaksCarFeedTest
//
//  Created by Ronak Sankhala on 30/07/21.
//

import Foundation
import UIKit

class CommonFunctions: NSObject {
    @objc class TestClass: NSObject {}
    static let Instance = CommonFunctions()
    
    func stringToDate(stringDate: String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        guard let dateToConvert = stringDate else { return "" }
        guard let dates = formatter.date(from: dateToConvert) else { return "" }
        guard let isCurrentYear = checkYearIsSame(secondDate: dates) else { return "" }
        guard let is12HrFormate = self.checkSystemTimeFormate() else { return "" }
        let timeFormate = is12HrFormate ? "hh:mm" : "HH:mm"
        formatter.dateFormat = isCurrentYear ? "dd MMMM, \(timeFormate)" : "dd MMMM yyyy, \(timeFormate)"
        let stringDate = formatter.string(from: dates)
        return stringDate
    }
    
    func checkYearIsSame(secondDate: Date) -> Bool? {
        let currentDate = Date()
        let currentYear = Calendar.current.dateComponents([.year], from: currentDate)
        let secondYear = Calendar.current.dateComponents([.year], from: secondDate)
        
        if currentYear == secondYear {
            return true
        } else {
            return false
        }
    }
    
    func checkSystemTimeFormate() -> Bool? {
        let locale = NSLocale.current
        let formatter : String = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:locale)!
        if formatter.contains("a") {
            //phone is set to 12 hours
            return true
        } else {
            //phone is set to 24 hours
            return false
        }
    }
    
}

@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }

}
