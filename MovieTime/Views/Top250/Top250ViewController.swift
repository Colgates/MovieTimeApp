//
//  Top250ViewController.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 01.08.2021.
//

import UIKit

final class Top250ViewController: UIViewController {
    
    let viewModel = Top250ViewControllerViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.black
        tableView.register(SearchMovieTableViewCell.self, forCellReuseIdentifier: SearchMovieTableViewCell.identifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = 185
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        tableView.delegate = self
        configureDataSource()
    }
    
    private func configureDataSource() {
        viewModel.dataSource = UITableViewDiffableDataSource<Int, Movie>(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieTableViewCell.identifier, for: indexPath) as? SearchMovieTableViewCell else { return UITableViewCell() }
            cell.configure(with: model)
            return cell
        })
    }
}

// MARK: - UITableViewDelegate
extension Top250ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MovieDetailsViewController()
        guard let model = viewModel.dataSource?.snapshot().itemIdentifiers[indexPath.row] else { return }
        vc.title = model.title
        vc.viewModel.getMovieByID(id: model.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
