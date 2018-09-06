//
//  RepositoryCollectionViewCell.swift
//  HDRepositories
//
//  Created by Chinna Venkata Raju on 5/13/18.
//  Copyright © 2018 Chinna Venkata Raju. All rights reserved.
//

import UIKit

class RepositoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var repositoryCreatedLabel: UILabel!
    @IBOutlet weak var repositoryLicenseLabel: UILabel!
    
    
    func setUpRepositoryInfo(repository: Repository) {
        
        if let repositoryName = repository.repoName {
            repositoryNameLabel.text = repositoryName
        }
        
        if let repositoryDescription = repository.repoDescription {
            repositoryDescriptionLabel.text = repositoryDescription
        }
        
        if let repositoryDate = repository.created_at {
            repositoryCreatedLabel.text = repositoryDate
        }
        
        if let repositoryLicense = repository.license.name {
            repositoryLicenseLabel.text = "Copy right © " + repositoryLicense
        }
    }
}
