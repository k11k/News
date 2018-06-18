//
//  ManagedObject + Mapping.swift
//  NewsApp
//
//  Created by jsmirnova on 20.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import CoreData

extension NSManagedObject {
    func getEntity(withName name: EntitiesName) -> [EntitiesProperties: Any] {
        switch name {
        case .news:
            var entity = [EntitiesProperties: Any]()
            for property in EntitiesProperties.all {
                entity[property] = value(forKey: property.rawValue)
            }
            return entity
        }
    }
}
