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
        if carsViewModel.isArticleAvailabe {
            self.viewNoDataFound.isHidden = true
            self.loadArticleDataOnTableView()
        } else {
            self.viewNoDataFound.isHidden = false
        }
    }
    
    @IBAction func onRetryButtonClicked(_ sender: Any) {
        self.loadArticleDataOnTableView()
    }
    
    private func loadArticleDataOnTableView() {
        tblCarArticles.rx.setDelegate(self).disposed(by: bag)
        carsViewModel.fetchArticlesList()
        self.bindTableViewforArticles()
    }
}

extension ViewController: UITableViewDelegate {
    
    private func bindTableViewforArticles() {
        
        carsViewModel.articles.bind(to: tblCarArticles.rx.items(cellIdentifier: "CarsFeedTableViewCell", cellType: CarsFeedTableViewCell.self)) {(row, item, cell) in
            cell.articles = item
        }.disposed(by: bag)
        
        tblCarArticles.rx.modelSelected(Article.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.ingress ?? "")")
        }).disposed(by: bag)
    }
}
