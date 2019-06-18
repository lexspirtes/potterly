//
//  TrimCollectionView.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/17/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit

//starting collectionView
class TrimCollectionView: UICollectionViewFlowLayout {
    let innerSpace: CGFloat = 1.0
    let numberOfCellsOnRow: CGFloat = 3
    
    override init() {
        super.init()
        self.minimumLineSpacing = innerSpace
        self.minimumInteritemSpacing = innerSpace
        self.scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.size.width/self.numberOfCellsOnRow)-self.innerSpace
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width:itemWidth(), height:itemWidth())
        }
        get {
            return CGSize(width:itemWidth(),height:itemWidth())
        }
    }
    
    
}
