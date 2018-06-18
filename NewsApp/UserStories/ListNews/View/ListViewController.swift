//
//  ListViewController.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var presenter: ListPresenter!
    fileprivate let cdm = ListCDM()
    let refreshControl = UIRefreshControl()


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setupView()
        cdm.delegate = self
    }
    
    @objc func startRefresh () {
        presenter.updateView()
    }
}

//MARK: PresenterOutput
extension ListViewController {
    func updateView(with newsItems: [NewsItemModel]) {
        refreshControl.endRefreshing()
        cdm.items = newsItems
        tableView?.reloadData()
    }
    
    func setupView () {
        
        refreshControl.addTarget(self, action: #selector(startRefresh), for: .valueChanged)
        refreshControl.tag = 11
        
        tableView.addSubview(refreshControl)
        tableView.register(UINib(nibName: NewsTableViewCell.nibName, bundle:nil), forCellReuseIdentifier: NewsTableViewCell.cellID)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        tableView.dataSource = cdm.dataSource(forTableView: tableView)
        tableView.delegate   = cdm.delegate(forTableView: tableView)
        tableView.dataSource = cdm
        tableView.delegate = cdm
        
        tableView.sectionHeaderHeight = 0.0
        tableView.sectionFooterHeight = 0.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160
        
        title = "Новости"
    }
}

extension ListViewController: ListCDMDelegate {
    func didSelectItem(_ item: ListItem) {
        if let newsItem = item as? NewsItemModel {
            presenter.newsItemSelected(newsItem)
        }
    }
}
