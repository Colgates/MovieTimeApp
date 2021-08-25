//
//  HomeViewControllerViewModel.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 21.07.2021.
//

import Combine
import UIKit

final class HomeViewControllerViewModel {
    
    private var cancellables: Set<AnyCancellable> = []
    
    var dataSource: UITableViewDiffableDataSource<Section, [Movie]>?
    
    func getMovies() {
        
        let group = DispatchGroup()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, [Movie]>()
        snapshot.appendSections(Section.allCases)

        group.enter()
        APICaller.shared.fetchMovies(route: .comingSoon)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("getComingSoonMovies \(completion)")
                group.leave()
            } receiveValue: { movies in
                snapshot.appendItems([movies], toSection: .comingSoon)
            }
            .store(in: &self.cancellables)

        group.enter()
        APICaller.shared.fetchMovies(route: .inTheaters)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("getInTheatersMovies \(completion)")
                group.leave()
            } receiveValue: { movies in
                snapshot.appendItems([movies], toSection: .inTheaters)
            }
            .store(in: &self.cancellables)

        group.enter()
        APICaller.shared.fetchMovies(route: .mostPopularTVs)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("getMostPopularTVs \(completion)")
                group.leave()
            } receiveValue: { movies in
                snapshot.appendItems([movies], toSection: .mostPopularTVs)
            }
            .store(in: &self.cancellables)

        group.enter()
        APICaller.shared.fetchMovies(route: .mostPopularMovies)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("getMostPopularMovies \(completion)")
                group.leave()
            } receiveValue: { movies in
                snapshot.appendItems([movies], toSection: .mostPopularMovies)
            }
            .store(in: &self.cancellables)

        group.notify(queue: .main) {
            print("finished group")
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
}
