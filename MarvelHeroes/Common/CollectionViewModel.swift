//
//  CollectionWorker.swift
//  MarvelHeroes
//
//  Created by Paweł on 13/10/2022.
//

import UIKit

class CollectionViewModel<CellType: UICollectionViewCell & Providable>: NSObject {
    enum Section {
      case main
    }
    
    typealias Item = CellType.ProvidedItem
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    
    private var dataSource: DataSource?
    private var cellIdentifier: String
    private weak var collectionView: UICollectionView?
    weak var parentVC: UIViewController?
    
    public var items: Binding<[Item]> = .init([])
    
    init(collectionView: UICollectionView, cellReuseIdentifier: String, parentVC: UIViewController) {
        self.cellIdentifier = cellReuseIdentifier
        self.collectionView = collectionView
        self.parentVC = parentVC
        super.init()
    }
}

extension CollectionViewModel {
    private func cellProvider(_ collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CellType
        cell.provide(item)
        return cell
    }
    
    public func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { fatalError("CollectionView isn't here :(") }
        let dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        self.dataSource = dataSource
        return dataSource
    }
}

extension CollectionViewModel {
    private func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items.value)
        dataSource?.apply(snapshot)
    }
        
    public func add(_ items: [Item]) {
        items.forEach {
            self.items.value.append($0)
        }
        update()
    }

    public func remove(_ items: [Item]) {
        items.forEach { item in
            self.items.value.removeAll { $0 == item }
        }
        update()
    }
}
