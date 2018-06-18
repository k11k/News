//
//  NewsWebService.swift
//  NewsApp
//
//  Created by jsmirnova on 20.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

class NewsWebService: WebService {
    
    typealias NewsListSuccessHandler = ([NewsItemModel]) -> Void
    typealias NewsItemSuccessHandler = (NewsItemModel) -> Void
    
    private let queryBase = "_content?id="
    
    func getNewsList(withSuccess success: @escaping NewsListSuccessHandler, andFailure failure: @escaping CommonFailure){
        getDataWith(withQuery: nil) { result in
            switch result {
            case .success(let resultDictionary):
                if let payload = resultDictionary["payload"] as? [[String:Any]] {
                    var finalNews = [NewsItemModel]()
                    for item in payload {
                        if let newsItemModel = NewsItemModel.init(with: item) {
                            finalNews.append(newsItemModel)
                        }
                    }
                    success(finalNews)
                }
                break
            case .error(let error):
                failure(error)
                break
            }
        }
    }
    
    func getNews(withId id: String, withSuccess success: @escaping NewsItemSuccessHandler, andFailure failure: @escaping CommonFailure) {
        let queryFinal = queryBase + id
        
        getDataWith(withQuery: queryFinal) { result in
            switch result {
            case .success(let resultDictionary):
                if let payload = resultDictionary["payload"] as? [String:Any],
                    let newsItemModel = NewsItemModel.init(with: payload) {
                    success(newsItemModel)
                }
                break
            case .error(let error):
                failure(error)
                break
            }
        }
    }
}
