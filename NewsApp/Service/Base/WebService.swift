//
//  WebService.swift
//  NewsApp
//
//  Created by jsmirnova on 17.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

enum WebResult {
    case success([String:Any])
    case error(Error)
}

class WebService {
    
    fileprivate let queryForNewsList = "https://api.tinkoff.ru/v1/news"
    
    func getDataWith(withQuery query: String?, completion: @escaping (WebResult) -> Void) {
        
        if var urlComponents = URLComponents(string: queryForNewsList) {
            urlComponents.query = query
        
            guard let url = urlComponents.url else { return }
            
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    completion(.error(error!))
                    return
                }
                guard let data = data else { return }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                        DispatchQueue.main.async {
                            completion(.success(json))
                        }
                    }
                } catch let error {
                    completion(.error(error))
                }
            }
            
            dataTask.resume()
        }
    }
}
