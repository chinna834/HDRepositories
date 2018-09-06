//
//  ResponseObjects.swift
//  HDRepositories
//
//  Created by Chinna Venkata Raju on 5/13/18.
//  Copyright © 2018 Chinna Venkata Raju. All rights reserved.
//

import Foundation

struct RepositoryResponseObject: DecodableResponse {
    
    var errorDictionary: [String: Any]!
    var responseDictionary: [String: Any]!
    var repositories: [Repository]?
    
    static func parse(data: Data, success: Bool) -> RepositoryResponseObject? {
        
        var repoResponse = RepositoryResponseObject()
        
        if success {
            let decoder = JSONDecoder()
            
            do {
                let repositories = try decoder.decode([Repository].self, from: data)
                repoResponse.repositories = repositories
                return repoResponse
            }catch {
                print("Exception Occured")
            }
            return repoResponse
        }
        else {
            repoResponse.errorDictionary = [:]
            return repoResponse
        }
    }
}
