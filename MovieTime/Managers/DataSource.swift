//
//  DataSource.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 01.08.2021.
//

import UIKit

class DataSource: UITableViewDiffableDataSource<Int, Movie> {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var snapshot = snapshot()
            if let item = itemIdentifier(for: indexPath) {
                snapshot.deleteItems([item])
                DatabaseManager.shared.deleteItemByMovieID(item: item)
                apply(snapshot, animatingDifferences: true)
            }
        }
    }
}
