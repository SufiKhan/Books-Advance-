//
//  BooksNwtworkUtility.swift
//  GoogleBooks
//
//  Created by mac on 16/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
class BooksNetworkUtility {
    
    lazy var endPoint: String = {
        return "https://www.googleapis.com/books/v1/volumes?filter=free-ebooks&q=a"
    }()
    
    func getBooksList(completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        
        guard let url = URL(string: endPoint) else { return completion(.Error("Invalid URL, we can't update your feed")) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { return completion(.Error(error!.localizedDescription)) }
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    guard let itemsJsonArray = json["items"] as? [[String: AnyObject]] else {
                        return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
                    }
                    DispatchQueue.main.async {
                       // print(json)
                        completion(.Success(itemsJsonArray))
                    }
                }
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
            }.resume()
    }
    
}

enum Result<T> {
    case Success(T)
    case Error(String)
}
