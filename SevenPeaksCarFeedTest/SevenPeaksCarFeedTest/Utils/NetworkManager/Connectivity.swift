//
//  Connectivity.swift
//  SevenPeaksCarFeedTest
//
//  Created by Ronak Sankhala on 02/08/21.
//

import Foundation
import Alamofire

//NetworkConnection Manager
class Connectivity {
    //Check Netowr is available or not.
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
