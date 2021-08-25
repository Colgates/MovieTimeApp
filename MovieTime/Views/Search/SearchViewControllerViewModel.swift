//
//  SearchViewControllerViewModel.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 20.07.2021.
//

import Combine
import UIKit

final class SearchViewControllerViewModel {
    
    var datasource: UITableViewDiffableDataSource<Int, Results>?
    
    @Published var searchText: String?
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        $searchText
            .receive(on: RunLoop.main)
            .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
            .sink { _ in
                if let text = self.searchText {
                    self.getMovies(searchText: text)
                }
            }
            .store(in: &cancellables)
    }
    
    func getMovies(searchText: String) {
        APICaller.shared.search(route: .search, searchText: searchText)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("Search by \(searchText) is \(completion)")
            } receiveValue: { [weak self] results in
                self?.updateSnapshot(with: results)
            }
            .store(in: &cancellables)
    }
    
    func updateSnapshot(with results: [Results]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Results>()
        snapshot.appendSections([0])
        snapshot.appendItems(results)
        datasource?.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

