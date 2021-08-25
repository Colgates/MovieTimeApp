//
//  Top250ViewControllerViewModel.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 01.08.2021.
//

import Combine
import UIKit

final class Top250ViewControllerViewModel {

    private var cancellables: Set<AnyCancellable> = []
    
    var dataSource: UITableViewDiffableDataSource<Int, Movie>?
    
    func get250Movies() {
        APICaller.shared.fetchMovies(route: .top250movies)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("get250movies \(completion)")
            } receiveValue: { movies in
                var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
                snapshot.appendSections([0])
                snapshot.appendItems(movies)
                self.dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
            }
            .store(in: &cancellables)
    }
    
    func get250TVs() {
        APICaller.shared.fetchMovies(route: .top250TVs)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("get250TVs \(completion)")
            } receiveValue: { movies in
                var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
                snapshot.appendSections([0])
                snapshot.appendItems(movies)
                self.dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
            }
            .store(in: &cancellables)
    }
}


