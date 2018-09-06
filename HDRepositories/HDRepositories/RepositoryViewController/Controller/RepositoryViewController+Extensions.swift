//
//  Repository+Extensions.swift
//  HDRepositories
//
//  Created by Chinna Venkata Raju on 5/13/18.
//  Copyright © 2018 Chinna Venkata Raju. All rights reserved.
//

import Foundation
import UIKit

extension RepositoryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCollectionViewCell
        
        let repository = repositories[indexPath.item]
        cell.setUpRepositoryInfo(repository: repository)
        
        return cell
    }
}

extension RepositoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return gridItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == repositories.count - 1  {
            currentPage = repositories.count/pageSet
            currentPage = currentPage + 1
            loadRepositories(query: query, page: currentPage)
        }
    }
}

extension RepositoryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = repositorySearchController.searchBar
        
        if let searchText = searchBar.text, !(searchText.isEmpty) {
            currentPage = 1
            loadRepositories(query: searchText, page: currentPage)
        }
    }
}

