//
//  UICollectionView+ReusableCell.swift
//  SharedUI
//
//  Created by hoseinAlimoradi on 6/27/23.
//
import UIKit

extension UICollectionViewCell: ReusableCell {}

extension UICollectionView {
    /// Registers UICollectionViewCells for classes.
    /// - parameter cellType: CellType
    public func registerCellTypeForClass<Cell: ReusableCell>(_ cellType: Cell.Type) {
        register(cellType, forCellWithReuseIdentifier: Cell.cellIdentifier)
    }

    /// Dequeues the appropriate cell from the collection view.
    /// - parameter indexPath: indexPath.
    /// - Returns: ReusableCell
    public func dequeueReusableCellType<Cell: ReusableCell>(_ indexPath: IndexPath) -> Cell {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: Cell.cellIdentifier, for: indexPath) as! Cell
    }
}
