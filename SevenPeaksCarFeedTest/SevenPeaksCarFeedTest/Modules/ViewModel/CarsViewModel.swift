//
//  CarsViewModel.swift
//  SevenPeaksCarFeedTest
//
//  Created by Ronak Sankhala on 30/07/21.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import CoreData
class CarsViewModel {
    //PublishSubject ot Sore data and Update on Tableview
    let articles = PublishSubject<[Article]>()
    var isArticleAvailabe: Bool = true
    
    //Load Data From API and Store Core Data
    //If API Fails then check from Local Data, If Found then Displayed on TableView
    func fetchArticlesList() {
        if Connectivity.isConnectedToInternet() {
            if let url =  URL(string: APPURL.BaseURL) {
                var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 100)
                urlRequest.httpMethod = "GET"
                
                AF.request(urlRequest).responseJSON { response in
                    if let data = response.data {
                        do {
                            let response = try JSONDecoder().decode(CarsFeed.self, from: data)
                            switch response.status {
                            case .success:
                                guard let articles = response.content else {
                                    return
                                }
                                //Cleare all The Data From Local Data Whenever API Will call
                                DatabaseController.deleteAllArticles()
                                //Adding Api Response Data In to the Core Data
                                self.addArticlesToCoreData(articles: articles)
                                //After Adding Call Save Context
                                DatabaseController.saveContext()
                                //Check and call Publisher to Show Data on TableView
                                if let articles = DatabaseController.getAllArticles() {
                                    self.articles.onNext(articles)
                                    self.articles.onCompleted()
                                }
                                self.isArticleAvailabe = true
                            case .none:
                                self.loadLocalArticleData()
                                print("Somthing Went Wrong! Please Try Again.")
                            }
                        } catch let error {
                            self.loadLocalArticleData()
                            self.articles.onError(error)
                        }
                    } else {
                        self.loadLocalArticleData()
                    }
                }
            } else {
                self.loadLocalArticleData()
            }
        } else {
            self.loadLocalArticleData()
        }
    }
    
    //Add Article Data into the Database for Offline Support
    private func addArticlesToCoreData(articles: [CarsFeedContent]) {
        if !articles.isEmpty {
            for article in articles {
                let entity = NSEntityDescription.entity(forEntityName: "Article", in: DatabaseController.getContext())
                let newArticle = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())
                
                newArticle.setValue(article.changed, forKey: "changed")
                newArticle.setValue(article.created, forKey: "created")
                newArticle.setValue(article.dateTime, forKey: "dateTime")
                newArticle.setValue(article.id, forKey: "id")
                newArticle.setValue(article.image, forKey: "image")
                newArticle.setValue(article.ingress, forKey: "ingress")
                newArticle.setValue(article.tags, forKey: "tags")
                newArticle.setValue(article.title, forKey: "title")
            }
        }
    }
    
    //Load Datafrom Database for Offline Support
    private func loadLocalArticleData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let articles = DatabaseController.getAllArticles(), !articles.isEmpty {
                self.isArticleAvailabe = true
                self.articles.onNext(articles)
                self.articles.onCompleted()
            } else {
                self.isArticleAvailabe = false
            }
        }
    }
}
