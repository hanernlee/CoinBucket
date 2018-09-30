//
//  AllCoinsViewControllerCollectionViewLayout.swift
//  CoinBucket
//
//  Created by Christopher Lee on 30/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class AllCoinsViewControllerCollectionViewLayout: UICollectionViewLayout {
    private var _layoutMap = [IndexPath : UICollectionViewLayoutAttributes]()     // 1
    private var _columnsYoffset: [CGFloat]!                                       // 2
    private var _contentSize: CGSize!                                             // 3
    
    private(set) var totalItemsInSection = 0
    
    // 4
    var totalColumns = 0
    var interItemsSpacing: CGFloat = 8
    
    // 5
    var contentInsets: UIEdgeInsets {
        return collectionView!.contentInset
    }
}
