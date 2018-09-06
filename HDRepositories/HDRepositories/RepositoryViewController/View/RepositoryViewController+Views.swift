//
//  RepositoryViewController+Views.swift
//  HDRepositories
//
//  Created by Chinna Venkata Raju on 5/13/18.
//  Copyright © 2018 Chinna Venkata Raju. All rights reserved.
//

import Foundation
import UIKit

extension RepositoryViewController {
   
    //MARK: Activity Indicator Setup
    func setUpActivityIndicator() {
        activityIndicator = ActivityIndicator(frame: CGRect(x: self.view.center.x - 25, y: self.view.center.y - 25, width: 50, height: 50), image: #imageLiteral(resourceName: "loading"))
        view.addSubview(activityIndicator)
        view.bringSubview(toFront: activityIndicator)
        activityIndicator.isHidden = true
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func configureSearchController() {
        repositorySearchController = UISearchController.init(searchResultsController: nil)
        repositorySearchController.searchResultsUpdater = self
        
        repositorySearchController.dimsBackgroundDuringPresentation = true
        repositorySearchController.obscuresBackgroundDuringPresentation = false
        
        repositorySearchController.searchBar.becomeFirstResponder()
        repositorySearchController.searchBar.placeholder = "Enter Repository Name"
        navigationItem.searchController = repositorySearchController
        definesPresentationContext = true
    }
}
