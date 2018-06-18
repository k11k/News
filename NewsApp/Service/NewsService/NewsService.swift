//
//  NewsService.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

protocol NewsServiceDelegate: class {
    func obtainedNewsList (_ newsList: [NewsItemModel])
    func obtainedNewsItem (_ newsItem: NewsItemModel)
    
    func webGetError (_ error: Error)
}

class NewsService: NSObject {
    
    fileprivate let dataBaseService = NewsDataBaseService()
    fileprivate let webService = NewsWebService()
    
    weak var delegate: NewsServiceDelegate?
    
    func getNewsList() {
        let webSuccess: ([NewsItemModel])-> Void = { [weak self] newsItems in
            guard let `self` = self else { return }
            self.dataBaseService.saveNewsItems(newsItems)
            self.delegate?.obtainedNewsList(newsItems)
        }
        
        let webFailure: CommonFailure = { [weak self] error in
            guard let `self` = self else { return }
            self.delegate?.webGetError(error)
            let newItems = self.dataBaseService.getNewsItems()
            self.delegate?.obtainedNewsList(newItems)
        }
        
        webService.getNewsList(withSuccess: webSuccess, andFailure: webFailure)
    }
    
    func getNews(withId id: String) {
        
    }
}
