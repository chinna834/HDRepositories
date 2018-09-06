//
//  Repository.swift
//  HDRepositories
//
//  Created by Chinna Venkata Raju on 5/13/18.
//  Copyright © 2018 Chinna Venkata Raju. All rights reserved.
//

import Foundation

class License: NSObject, Codable {
    var key:String? = nil
    var name:String? = nil
    
    enum LicenseKeys: String, CodingKey {
        case key = "key"
        case name = "name"
    }
}

class Repository: NSObject, Codable {
    var repoName: String? = nil
    var repoDescription: String? = nil
    var created_at: String? = nil
    var license: License = License()
    
    enum RepositoryKeys: String, CodingKey {
        case repoName = "name"
        case repoDescription = "description"
        case created_at = "created_at"
        case license = "license"
    }
    
    convenience required init(from decoder: Decoder) {
        self.init()
        
        let container = try! decoder.container(keyedBy: RepositoryKeys.self)
        
        self.repoName = (try? container.decode(String.self, forKey: .repoName)) ?? "No Name"
        self.repoDescription = (try? container.decode(String.self, forKey: .repoDescription)) ?? "No Description Available"
        self.created_at = (try? container.decode(String.self, forKey: .created_at)) ?? "No timestamp Available"
        self.license = (try? container.decode(License.self, forKey: .license)) ?? license
    }
    
    func encode(to encoder: Encoder) {
        //Not Required
    }
}
