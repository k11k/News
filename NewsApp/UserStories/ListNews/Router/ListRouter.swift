//
//  ListRouter.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

class ListRouter: NSObject {
    
    weak var view: UIViewController?
    
    func presentMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        view?.present(alert, animated: true, completion: nil)
    }
}
