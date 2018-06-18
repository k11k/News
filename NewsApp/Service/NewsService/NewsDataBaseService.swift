//
//  NewsDataBaseService.swift
//  NewsApp
//
//  Created by jsmirnova on 20.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

class NewsDataBaseService {
    fileprivate let currentEntityName = EntitiesName.news
    fileprivate let dataBaseService = DataBaseService()
    
    typealias Entity = DataBaseService.Entity
    
    func saveNewsItems (_ newsItems: [DataBaseMapping]) {
        let entities = newsItems.map{ $0.dataBaseEntity }
        dataBaseService.saveItems(entities, withName: currentEntityName)
    }
    
    func saveNewsItem (_ newsItem: DataBaseMapping) {
        let entity = newsItem.dataBaseEntity
        dataBaseService.saveItem(entity, withName: currentEntityName)
    }
    
    func getNewsItems () -> [NewsItemModel] {
        if let entities = dataBaseService.getEntities(withName: .news) {
            let newsItems = entities.map{NewsItemModel.init(with: $0)}.filter{$0 != nil}
            return newsItems as! [NewsItemModel]
        }
        return []
    }
    
    func getNewsItem () -> NewsItemModel {
        
    }
}
