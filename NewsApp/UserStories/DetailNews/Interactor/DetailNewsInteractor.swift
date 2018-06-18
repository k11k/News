//
//  DetailNewsInteractor.swift
//  NewsApp
//
//  Created by jsmirnova on 03.02.18.
//  Copyright © 2018 jsmirnova. All rights reserved.
//

import UIKit

class DetailNewsInteractor: NSObject {
    
    weak var delegate: DetailNewsInteractorDelegate?
    
    func obtainNews(withId id: String) {
        
    }
}

protocol DetailNewsInteractorDelegate: class {
    func newsObtained (_ news: NewsItemModel)
    func errorObtained (_ error: Error)
}
