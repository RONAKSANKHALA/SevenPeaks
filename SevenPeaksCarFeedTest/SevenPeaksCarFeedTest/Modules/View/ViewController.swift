//
//  ViewController.swift
//  SevenPeaksCarFeedTest
//
//  Created by Ronak Sankhala on 30/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet var tblCarArticles: UITableView!
    @IBOutlet var viewNoDataFound: UIView!
    private var bag = DisposeBag()
    private var carsViewModel = CarsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Check Article Data is available on Local databse and API or not
        if carsViewModel.isArticleAvailabe {
            self.viewNoDataFound.isHidden = true
            self.loadArticleDataOnTableView()
        } else {
            self.viewNoDataFound.isHidden = false
        }
    }
    
    @IBAction func onRetryButtonClicked(_ sender: Any) {
        //Retry to call API Again and try to load New Data if internet is available otherwise data will be load from Local Data Base
        self.loadArticleDataOnTableView()
    }
    
    //Load Data from API and Bind Data on TableView
    private func loadArticleDataOnTableView() {
        tblCarArticles.rx.setDelegate(self).disposed(by: bag)
        carsViewModel.fetchArticlesList()
        self.bindTableViewforArticles()
    }
}

extension ViewController: UITableViewDelegate {
    
    //Bind Tableview to Display Data
    private func bindTableViewforArticles() {
        //Reusable Tableview cell
        carsViewModel.articles.bind(to: tblCarArticles.rx.items(cellIdentifier: "CarsFeedTableViewCell", cellType: CarsFeedTableViewCell.self)) {(row, item, cell) in
            cell.articles = item
        }.disposed(by: bag)
        
        //Select Item Information on tap Tableview cell or model selection
        tblCarArticles.rx.modelSelected(Article.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.ingress ?? "")")
        }).disposed(by: bag)
    }
}
