//
//  GridCollectionViewLayout.swift
//  HDRepositories
//
//  Created by Chinna Venkata Raju on 5/13/18.
//  Copyright © 2018 Chinna Venkata Raju. All rights reserved.
//

import Foundation
import UIKit

class GridCollectionViewLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.width/2) - gridItemSpacing
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: gridItemHeight)
        }
        get {
            return CGSize(width: itemWidth(), height: 160)
        }
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
