//
//  ProfileViewControllerViewModel.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 01.08.2021.
//

import UIKit

final class ProfileViewControllerViewModel {
    
    var dataSource: UITableViewDiffableDataSource<Int, Movie>?
    
    func getWatchlistData() {
        DispatchQueue.main.async {
            DatabaseManager.shared.getDocuments() { self.updateSnapshot(with: $0) }
        }
    }
    
    private func updateSnapshot(with item: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        snapshot.appendItems(item)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
