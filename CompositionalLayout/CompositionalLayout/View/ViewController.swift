//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by 오국원 on 2023/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        view.register(UICollectionView.self, forCellWithReuseIdentifier: "cell")
        view.register(Header.self,
                      forSupplementaryViewOfKind: "secondHeaderID",
                      withReuseIdentifier: Header.identifier
        )
        view.register(Header.self,
                      forSupplementaryViewOfKind: "thirdHeaderID",
                      withReuseIdentifier: Header.identifier
        )
        view.dataSource = self
        return view
    }()