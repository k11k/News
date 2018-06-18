//
//  Int+Date.swift
//  NewsApp
//
//  Created by jsmirnova on 20.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import Foundation

extension Int {
    func prepareDate() -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        return date
    }
}
