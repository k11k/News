//
//  DetailNewsModule.swift
//  NewsApp
//
//  Created by jsmirnova on 03.02.18.
//  Copyright © 2018 jsmirnova. All rights reserved.
//

import UIKit

class DetailNewsModule: NSObject {
    
    fileprivate var viewController: DetailNewsViewController?
    
    /**
     Вью модуля. Если вью не создан (не используется storyboard/xib), создает и конфигурирует модуль.
     
     - returns: Вью модуля.
     */
    var view: UIViewController {
        guard let view = viewController else {
            viewController = DetailNewsViewController(nibName: "DetailNewsViewController", bundle: nil)
            configureModule(view: self.viewController!)
            return self.viewController!
        }
        return view
    }
    /**
     Устанавливает зависимости модуля.
     
     - parameter view: Вью модуля.
     */
    fileprivate func configureModule(view: DetailNewsViewController) {
        let presenter = DetailNewsPresenter()
        let router = DetailNewsRouter()
        let interactor = DetailNewsInteractor()
        router.view = view
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
    }
}

