//
//  CGenericDelegateDataSource.swift
//  GenericDataSourceTests
//
//  Created by Jorge Luis on 19/03/18.
//  Copyright © 2018 Teste. All rights reserved.
//

//
//  GenericDataSource.swift
//  GenericDataSource
//
//  Created by Helena Leitão on 16/02/2018.
//  Copyright © 2018 Teste. All rights reserved.
//

import UIKit

open class CGenericDelegateDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    fileprivate(set) weak var collectionView: UICollectionView!
    
    public var sections: [CSectionProtocol]!
    
//    public weak var delegate: GenericDelegateDataSourceProtocol?
    
    public init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        self.registerCells()
    }
    
    fileprivate func registerCells() {
        let set = NSMutableSet()
        self.sections.forEach({
            for i in 0..<$0.itemCount() {
                set.add($0.cellType(for: i))
            }
        })
        set.allObjects.map({$0 as! UICollectionViewCell.Type}).forEach({ [weak self] (item: UICollectionViewCell.Type) in
            self?.collectionView.register(item, forCellWithReuseIdentifier: item.reusableIdentifier)
        })
    }
    
    // MARK: UICollectionViewDatasource
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].itemCount()
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.sections[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: section.cellType(for: indexPath.row).className, for: indexPath)
        if let item: Any = section.getItem(for: indexPath.row) {
            (cell as? CellSetupable)?.configure(withAny: item)
        }
        return cell
    }

}
