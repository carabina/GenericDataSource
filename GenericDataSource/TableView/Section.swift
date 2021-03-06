//
//  Section.swift
//  GenericDataSourceTests
//
//  Created by Anderson Lucas de Castro Ramos on 01/03/2018.
//  Copyright © 2018 Teste. All rights reserved.
//

import UIKit

@objc public protocol SectionProtocol: class {
    var title: String? { get set }
    var footer: String? { get set }
    
    @objc optional func headerType() -> UITableViewHeaderFooterView.Type
    @objc optional func headerHeight() -> CGFloat
    @objc optional func estimatedHeaderHeight() -> CGFloat
    @objc optional func headerPostConfiguration(for header: UITableViewHeaderFooterView, of section: Int)
    
    @objc optional func footerType() -> UITableViewHeaderFooterView.Type
    @objc optional func footerHeight() -> CGFloat
    @objc optional func estimatedFooterHeight() -> CGFloat
    @objc optional func footerPostConfiguration(for footer: UITableViewHeaderFooterView, of section: Int)
 
    func itemCount() -> Int
    
    func cellType(for index: Int) -> UITableViewCell.Type
    func cellHeight(for index: Int) -> CGFloat
    func estimatedCellHeight(for index: Int) -> CGFloat
    @objc optional func cellPostConfiguration(for cell: UITableViewCell, at indexPath: IndexPath)
}

open class Section : SectionProtocol {
    fileprivate var dataSource: DataSourceProtocol
    
    public var title: String?
    public var footer: String?
    
    public var headerObject: Any?
    public var footerObject: Any?
    
    public init(title: String? = nil, footer: String? = nil, dataSource: DataSourceProtocol) {
        self.title = title
        self.footer = footer
        self.dataSource = dataSource
    }
    
    open func cellType(for index: Int) -> UITableViewCell.Type {
        return UITableViewCell.self
    }
    
    open func cellHeight(for index: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    open func estimatedCellHeight(for index: Int) -> CGFloat {
        return self.cellHeight(for: index)
    }
    
    public func itemCount() -> Int {
        return self.dataSource.getItemCount()
    }
    
    public func itemTypeIs(type: Any.Type) -> Bool {
        return self.dataSource.itemType() == type
    }
    
    public func getItem<T>(for index: Int) -> T {
        return self.dataSource.getItem(for: index)
    }
}
