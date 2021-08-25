//
//  ActorDetailsViewControllerViewModel.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 31.07.2021.
//

import Combine
import UIKit

protocol ActorDetailsViewControllerViewModelDelegate: AnyObject {
    func didCreateHeaderView(actor: ActorDetails)
}

final class ActorDetailsViewControllerViewModel {
    
    var dataSource: UITableViewDiffableDataSource<Int, ActorDetails>?
    
    weak var delegate: ActorDetailsViewControllerViewModelDelegate?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getActorByID(id: String) {
        APICaller.shared.getActorByID(route: .actorByID, id: id)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("getActorByID \(completion)")
            } receiveValue: { [weak self] actor in
                self?.updateSnapshot(with: actor)
                self?.delegate?.didCreateHeaderView(actor: actor)
            }
            .store(in: &cancellables)
    }
    
    private func updateSnapshot(with items: ActorDetails) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ActorDetails>()
        snapshot.appendSections([0])
        snapshot.appendItems([items])
        dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}
