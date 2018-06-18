//
//  ListPresenter.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

class ListPresenter {
    
    weak var view: ListViewController?
    var router: ListRouter!
    var interactor: ListInteractor!
}

// viewOutput
extension ListPresenter {
    func setupView() {
        interactor.delegate = self
        view?.setupView()
        interactor.getNewsList()
    }
    func updateView() {
        interactor.getNewsList()
    }
    func newsItemSelected(_ newsItem: NewsItemModel) {
        
    }
}


extension ListPresenter: ListInteractorDelegate {
    func newsListObtained(_ news: [NewsItemModel]) {
        view?.updateView(with: news)
    }
    
    func obtainError(_ error: Error) {
        router.presentMessage(title: "Произошла ошибка при получении данных", message: error.localizedDescription)
    }
}
