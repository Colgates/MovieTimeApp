//
//  ActorDetailsViewController.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 31.07.2021.
//

import UIKit

final class ActorDetailsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HomeCollectionTableViewCell.self, forCellReuseIdentifier: HomeCollectionTableViewCell.identifier)
        tableView.backgroundColor = Colors.black
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 50
        return tableView
    }()
    
    var viewModel = ActorDetailsViewControllerViewModel()
    
    override func loadView() {
        super.loadView()
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        viewModel.delegate = self
        
        configureDatasource()
    }
    
    private func configureDatasource() {
        viewModel.dataSource = UITableViewDiffableDataSource<Int, ActorDetails>(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollectionTableViewCell.identifier, for: indexPath) as? HomeCollectionTableViewCell else { return UITableViewCell() }
            cell.configure(with: model.knownFor)
            cell.delegate = self
            return cell
        })
    }
}

// MARK: - UITableViewDelegate
extension ActorDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.frame = CGRect(x: 20, y: 0, width: view.width, height: tableView.sectionHeaderHeight)
        label.textColor = Colors.textColor
        label.text = "Known For:"
        container.addSubview(label)
        return container
    }
}

// MARK: - HomeCollectionTableViewCellDelegate
extension ActorDetailsViewController: HomeCollectionTableViewCellDelegate {
    func didSelectItem(with model: Movie) {
        print(model.title)
        let vc = MovieDetailsViewController()
        vc.title = model.title
        vc.viewModel.getMovieByID(id: model.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - DetailMovieViewControllerViewModelDelegate
extension ActorDetailsViewController: ActorDetailsViewControllerViewModelDelegate {

    func didCreateHeaderView(actor: ActorDetails) {
        let headerView = ActorDetailsHeaderView()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height)
        DispatchQueue.main.async {
            headerView.configure(with: actor)
            self.tableView.tableHeaderView = headerView
        }
    }
}

