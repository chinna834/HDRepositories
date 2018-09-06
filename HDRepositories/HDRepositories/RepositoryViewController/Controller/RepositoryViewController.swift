//
//  RepositoryViewController.swift
//  HDRepositories
//
//  Created by Chinna Venkata Raju on 5/13/18.
//  Copyright © 2018 Chinna Venkata Raju. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {

    var currentPage = 1
    var query = "apple"
    
    var activityIndicator: ActivityIndicator! = nil
    var repositorySearchController: UISearchController! = nil
    let alertController: AlertController! = AlertController.alertController
    
    var repositories: [Repository] = []
    
    @IBOutlet weak var repositoryCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBAction func selectListOrGridView(_ sender: Any) {

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 0.2) { () -> Void in
                self.repositoryCollectionView.collectionViewLayout.invalidateLayout()
                self.repositoryCollectionView.setCollectionViewLayout(ListCollectionViewLayout(), animated: true)
            }
        case 1:
            UIView.animate(withDuration: 0.2) { () -> Void in
                self.repositoryCollectionView.collectionViewLayout.invalidateLayout()
                self.repositoryCollectionView.setCollectionViewLayout(GridCollectionViewLayout(), animated: true)
            }
        default:
            break
        }
    }
    
    //MARK: - Load Repositories
    func reloadRepositories(repos: [Repository]) {
        if currentPage == 1 {
            repositories = repos
        }
        else {
            repositories.append(contentsOf: repos)
        }
        
        repositoryCollectionView.reloadData()
    }
    
    func loadRepositories(query: String, page: Int = 1) {
        let requestObject = RepositoryRequestObject.init(searchKey: query, page: page)
        
        NetworkManager.sharedInstance.send(requestObject: requestObject) { [weak self] (success, response, error) in
            
            if success {
                if let responseRespositories = response?.repositories {
                    self?.reloadRepositories(repos: responseRespositories)
                }
            }
            else {
                self?.alertController.showAlertWithTitle(having: "", message: "Something went wrong. Please try again", target: self!, successTitle: "OK", cancelTitle: "Cancel", successAction: { (okAction) in
                    
                }, cancelAction: {
                    
                })
                
            }
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureSearchController()

        loadRepositories(query: query, page: currentPage)
        repositoryCollectionView.setCollectionViewLayout(ListCollectionViewLayout(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
