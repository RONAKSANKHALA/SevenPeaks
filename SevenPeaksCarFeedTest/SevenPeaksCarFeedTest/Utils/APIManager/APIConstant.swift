//
//  APIConstant.swift
//  SevenPeaksCarFeedTest
//
//  Created by Ronak Sankhala on 30/07/21.
//

import Foundation

//API COnstan file to store local or static objects.
struct APPURL {

    private struct Domains {
        static let Dev = "https://www.apphusetreach.no/application/119267"
    }

    private  struct Routes {
        static let Api = "/article/get_articles_list"
    }

    private  static let Domain = Domains.Dev
    private  static let Route = Routes.Api

    static var BaseURL: String {
        return Domain + Route
    }
}
