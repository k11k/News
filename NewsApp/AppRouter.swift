//
//  AppRouter.swift
//  NewsApp
//
//  Created by jsmirnova on 21.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

var needPresentNewFeatureView: Bool = false

class AppRouter {
    
    static let shared = AppRouter()
    
    
    var window: UIWindow?
    
    func presentRootModule(animated: Bool) {
        guard let window = self.window else {
            assertionFailure("missed window")
            return
        }
        let moduleView: UIViewController = ListModule.init(moduleType: .news).view
        let nc = UINavigationController(rootViewController: moduleView)
        window.rootViewController = nc
        if animated {
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromRight,
                              animations: nil,
                              completion: nil)
        } else {
            window.makeKeyAndVisible()
        }
    }
    
    func presentAlertWithText(text: String,completeHandler: @escaping ((UIAlertAction) -> Swift.Void) ) {
        let alert = UIAlertController(title: "Внимание",
                                      message: text,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Перейти в настройки",
                                      style: UIAlertActionStyle.default,
                                      handler: completeHandler))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        window?.rootViewController?.presentedViewController?.present(alert, animated: true, completion: nil)
    }
}

