//
//  ListInteractor.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import Foundation

protocol ListInteractorDelegate: class {
    func newsListObtained(_ news: [NewsItemModel])
    func obtainError(_ error: Error)
}

class ListInteractor: NSObject {
    
    var newsService = NewsService()
    
    weak var delegate: ListInteractorDelegate!
    
    override init() {
        super.init()
        newsService.delegate = self
    }
    
    func getNewsList() {
        newsService.getNewsList()
    }
}

extension ListInteractor: NewsServiceDelegate {
    func obtainedNewsList(_ newsList: [NewsItemModel]) {
        delegate?.newsListObtained(newsList)
    }
    
    func obtainedNewsItem(_ newsItem: NewsItemModel) {
    }
    
    func webGetError(_ error: Error) {
        delegate?.obtainError(error)
    }
}
