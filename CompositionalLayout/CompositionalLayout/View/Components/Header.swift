//
//  Header.swift
//  CompositionalLayout
//
//  Created by 오국원 on 2023/06/24.
//

import UIKit

final class Header: UICollectionReusableView, Identifier {
    
    let label = UILabel()
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        label.frame = bounds
    }
}
