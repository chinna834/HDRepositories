//
//  RequestObjects.swift
//  HDRepositories
//
//  Created by Chinna Venkata Raju on 5/13/18.
//  Copyright © 2018 Chinna Venkata Raju. All rights reserved.
//

import Foundation

fileprivate func constructURLForRepository(for query: String, page: Int) -> URL? {
    
    var urlComponents = URLComponents()
    urlComponents.scheme = urlScheme
    urlComponents.host = baseURL
    
    let path = usersPath + query + reposPath
    urlComponents.path = path
    
    var queryItems = [URLQueryItem]()
    
    let pageQueryItem = URLQueryItem(name: "page", value: String(page))
    let pageSizeQueryItem = URLQueryItem(name: "per_page", value: String(pageSet))
    queryItems.append(contentsOf: [pageQueryItem, pageSizeQueryItem])
    
    urlComponents.queryItems = queryItems
    
    return urlComponents.url
    
}

struct RepositoryRequestObject: RequestObject {
    typealias response = RepositoryResponseObject
    
    var host:String = baseURL
    var path:String = ""
    var url:URL
    var method:String = httpsGet
    var header:[[String:Any]]?
    var body:[String:Any]?
    var query: String = ""
    
    init(searchKey: String, page: Int = 1) {
        query = searchKey
        header = [["Content-Type": "application/json"], ["Accept": "application/json"]]
        url = constructURLForRepository(for: searchKey, page: page)!
    }
}


