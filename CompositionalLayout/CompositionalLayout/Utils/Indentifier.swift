//
//  Indentifier.swift
//  CompositionalLayout
//
//  Created by 오국원 on 2023/06/24.
//

import Foundation

protocol Identifier {
    static var identifier: String { get }
}

extension Identifier {
    static var identifier: String { return "\(self)" }
}
