//
//  ListModule.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

class ListModule: NSObject {
    
    fileprivate var viewController: ListViewController?
    fileprivate var moduleType: ModuleType!
    
    /**
     Вью модуля. Если вью не создан (не используется storyboard/xib), создает и конфигурирует модуль.
     
     - returns: Вью модуля.
     */
    var view: UIViewController {
        guard let view = viewController else {
            viewController = ListViewController(nibName: "ListViewController", bundle: nil)
            configureModule(view: self.viewController!)
            return self.viewController!
        }
        return view
    }
    
    init(moduleType: ModuleType) {
        self.moduleType = moduleType
    }
    
    /**
     Устанавливает зависимости модуля.
     
     - parameter view: Вью модуля.
     */
    fileprivate func configureModule(view: ListViewController) {
        let presenter = ListPresenter()
        let router = ListRouter()
        let interactor = ListInteractor()
        router.view = view
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor        
    }
}
