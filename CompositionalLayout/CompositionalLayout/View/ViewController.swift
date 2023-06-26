//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by 오국원 on 2023/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    enum Constant {
        static let cellID = "cellID"
        static let categoryHeaderId = "categoryHeaderId"
        static let playlistHeaderId = "playlistHeaderId"
    }
        
    private let supplementaryHeaders = [Constant.categoryHeaderId: "categories",
                                        Constant.playlistHeaderId: "playlist"
    ]
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.cellID)
        view.register(Header.self,
                      forSupplementaryViewOfKind: Constant.categoryHeaderId,
                      withReuseIdentifier: Header.identifier
        )
        view.register(Header.self,
                      forSupplementaryViewOfKind: Constant.playlistHeaderId,
                      withReuseIdentifier: Header.identifier
        )
        return view
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        dataSource = CollectionViewDiffableDataSource(collectionView: collectionView,
                                                      cellID: Constant.cellID,
                                                      supplementaryHeaders: supplementaryHeaders)
        dataSource?.apply(applySnapshot())
        collectionView.dataSource = dataSource
    }
    
    private func applySnapshot() -> DiffableSnapshot {
        var snapshot = DiffableSnapshot()
        snapshot.addSection(sections: Section.allCases)
        for section in Section.allCases {
            switch section {
            case .section1:
                snapshot.addItems(section: section, items: (0..<3).map { .normal("\(section)Item \($0)") })
            case .section2:
                snapshot.addItems(section: section, items: (0..<8).map { .normal("\(section)Item \($0)") })
            case .section3:
                snapshot.addItems(section: section, items: (0..<4).map { .normal("\(section)Item \($0)") })
            default:
                snapshot.addItems(section: section, items: (0..<20).map { .normal("\(section)Item \($0)") })
            }
        }
        return snapshot
    }
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNum, env in
            
            switch sectionNum {
            case 0:
                let item: NSCollectionLayoutItem = .init(
                    layoutSize:
                            .init(
                                widthDimension: .fractionalWidth(1),
                                heightDimension: .fractionalHeight(1)
                            )
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(200)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            case 1:
                let item: NSCollectionLayoutItem = .init(
                    layoutSize:
                            .init(
                                widthDimension: .fractionalWidth(0.25),
                                heightDimension: .absolute(150)
                            )
                )
                item.contentInsets.bottom = 16
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(500)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems = [
                    .init(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(50)
                        ),
                        elementKind: Constant.categoryHeaderId,
                        alignment: .topLeading
                    )
                ]
                return section
            case 2:
                let item: NSCollectionLayoutItem = .init(
                    layoutSize:
                            .init(
                                widthDimension: .fractionalWidth(1),
                                heightDimension: .absolute(80)
                            )
                )
                item.contentInsets.trailing = 32
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1),
                                      heightDimension: .absolute(200)),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets.leading = 16
                section.contentInsets.top = 16
                return section
            default:
                let item: NSCollectionLayoutItem = .init(
                    layoutSize:
                            .init(
                                widthDimension: .fractionalWidth(1),
                                heightDimension: .fractionalHeight(1)
                            )
                )
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(0.95),
                                      heightDimension: .estimated(100)),
                    repeatingSubitem: item,
                    count: 5
                )
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                            heightDimension: .absolute(50)),
                          elementKind: Constant.playlistHeaderId,
                          alignment: .topLeading
                         )
                ]
                section.contentInsets.leading = 16
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }
        }
    }
}
