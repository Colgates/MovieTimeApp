//
//  ProfileViewController.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 20.07.2021.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = Colors.black
        tableView.register(SearchMovieTableViewCell.self, forCellReuseIdentifier: SearchMovieTableViewCell.identifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = 185
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 50
        return tableView
    }()
    
    private let viewModel = ProfileViewControllerViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getWatchlistData()
    }
    
    override func loadView() {
        super.loadView()
        view = tableView
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureDataSource()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.tintColor = Colors.textColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.textColor ?? .white]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Colors.textColor ?? .white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Your Watchlist"
    }
    
    private func configureDataSource() {
        viewModel.dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieTableViewCell.identifier, for: indexPath) as? SearchMovieTableViewCell else { return UITableViewCell() }
            cell.configure(with: model)
            cell.rankLabel.isHidden = true
            cell.crewLabel.isHidden = true
            return cell
        })
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let model = viewModel.dataSource?.itemIdentifier(for: indexPath) else { return }
        let vc = MovieDetailsViewController()
        vc.title = model.title
        vc.viewModel.getMovieByID(id: model.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
