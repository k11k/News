//
//  Constants.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

class Constants: NSObject {

}

typealias CommonFailure = (Error)-> Void

enum ModuleType {
    case news
    
    func title() -> String {
        switch self {
        case .news:
            return "Новости"
        }
    }
}
