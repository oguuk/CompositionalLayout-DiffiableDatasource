//
//  CollectionViewDiffableDataSource.swift
//  CompositionalLayout
//
//  Created by 오국원 on 2023/06/25.
//

import UIKit

final class CollectionViewDiffableDataSource: UICollectionViewDiffableDataSource<Section, Item> {

    init(collectionView: UICollectionView, cellID: String, supplementaryHeaders: [String: String]) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            switch item {
            case .normal(_):
                cell.backgroundColor = indexPath.row.isMultiple(of: 2) ? .red : .blue
            }
            return cell
        }
        
        self.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if let headerText = supplementaryHeaders[kind] {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as? Header
                view?.label.text = headerText
                return view
            }
            return nil
        }
    }
}
