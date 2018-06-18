//
//  NewsItem.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit
protocol  ListItem {
    var listTitle: String { get }
    var listCreateDate: String { get }
}

protocol DetailedItem {
    var detailedTitle: String { get }
    var detailedContent: String { get }
    var detailedDate: String { get }
}

protocol DataBaseMapping {
    var dataBaseEntity: [EntitiesProperties: Any] { get }
    init?(with entity: [EntitiesProperties : Any])
}

struct  NewsItemModel {
    fileprivate var id: String
    fileprivate var title: String
    fileprivate var dateCreate: Date
    fileprivate var dateModified: Date?
    fileprivate var content : String?
    
    init?(with data: [String: Any]) {
        guard let id = data["id"] as? String,
            let title = data["text"] as? String,
        let publication = data["publicationDate"] as? [AnyHashable: Any],
        let createDateMillisec = publication["milliseconds"] as? Int else { return nil }
        
        self.id = id
        self.title = title
        self.dateCreate = createDateMillisec.prepareDate()
        
        if let millisec = data["millisec"] as? Int {
            self.dateModified = millisec.prepareDate()
        }
        if let content = data["content"] as? String {
            self.content = content
        }
    }
}

extension NewsItemModel: ListItem {
    var listTitle: String {
        return title
    }
    
    var listCreateDate: String {
        return dateCreate.timeAgo()
    }
}

extension NewsItemModel: DetailedItem {
    var detailedTitle: String {
        return title
    }
    
    var detailedContent: String {
        return content ?? ""
    }
    
    var detailedDate: String {
        return dateCreate.timeAgo()
    }
}

extension NewsItemModel: DataBaseMapping {
    var dataBaseEntity: [EntitiesProperties : Any] {
        var entity: [EntitiesProperties : Any] = [:]
        entity[.id] = id
        entity[.title] = title
        entity[.dateCreate] = dateCreate
        entity[.dateModified] = dateModified
        entity[.content] = content
        return entity
    }
    init?(with entity: DataBaseService.Entity) {
        guard let id = entity[.id] as? String,
            let title = entity[.title] as? String,
            let dateCreate = entity[.dateCreate] as? Date else { return nil }
        self.id = id
        self.title = title
        self.dateCreate = dateCreate
        
        if let dateModified = entity[.dateModified] as? Date {
            self.dateModified = dateModified
        }
        if let content = entity[.content] as? String {
            self.content = content
        }
    }
}
