//
//  MovieDetailsViewControllerViewModel.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 26.07.2021.
//

import Combine
import UIKit

protocol MovieDetailsViewControllerViewModelDelegate: AnyObject {
    func didCreateHeaderView(movie: MovieDetails)
}

enum SectionWrapper: Hashable {
    case movies([Movie])
    case actors([ActorList])
}

final class MovieDetailsViewControllerViewModel {
    
    var dataSource: UITableViewDiffableDataSource<Int, SectionWrapper>?
    
    weak var delegate: MovieDetailsViewControllerViewModelDelegate?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getMovieByID(id: String) {
        APICaller.shared.getMovieByID(route: .movieByID, id: id)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("getMovieByID \(completion)")
            } receiveValue: { [weak self] movie in

                var snapshot = NSDiffableDataSourceSnapshot<Int, SectionWrapper>()
                snapshot.appendSections([0, 1])
                snapshot.appendItems([SectionWrapper.actors(movie.actorList)], toSection: 0)
                snapshot.appendItems([SectionWrapper.movies(movie.similars)], toSection: 1)
                self?.dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
                
                self?.delegate?.didCreateHeaderView(movie: movie)
            }
            .store(in: &cancellables)
    }
}


