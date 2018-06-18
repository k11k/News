//
//  CDMList.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

protocol ListCDMDelegate: class {
    func didSelectItem(_ item: ListItem)
}

class ListCDM : NSObject {
    
    typealias Delegate = ListCDMDelegate
    typealias ItemType = ListItem
    
    weak var delegate: Delegate?
    
    var items: [ItemType] = []
    
    func dataSource(forTableView: UITableView) -> UITableViewDataSource {
        return self
    }
    
    func delegate(forTableView: UITableView) -> UITableViewDelegate {
        return self
    }
}

// MARK: - UITableViewDataSource
extension ListCDM : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.nibName) as! NewsTableViewCell
        cell.setup(title: item.listTitle, date: item.listCreateDate)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListCDM: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
