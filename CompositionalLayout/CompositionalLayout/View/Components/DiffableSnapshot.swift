//
//  DiffableSnapshot.swift
//  CompositionalLayout
//
//  Created by 오국원 on 2023/06/26.
//

import UIKit

typealias DiffableSnapshot = NSDiffableDataSourceSnapshot<Section, Item>

extension DiffableSnapshot {
    
    mutating func addSection(sections: [Section]) {
        self.appendSections(sections)
    }
    
    mutating func addItems(section: Section, items: [Item]) {
        self.appendItems(items, toSection: section)
    }
}
