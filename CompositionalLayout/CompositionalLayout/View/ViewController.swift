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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
                        elementKind: "secondHeaderID",
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
                item.contentInsets.top = 16
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                      heightDimension: .estimated(300)),
                    repeatingSubitem: item,
                    count: 5
                )
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                            heightDimension: .absolute(50)),
                          elementKind: "thirdHeaderID",
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
