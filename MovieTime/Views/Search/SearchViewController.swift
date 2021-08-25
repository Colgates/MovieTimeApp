//
//  SearchViewController.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 20.07.2021.
//
import Combine
import UIKit

final class SearchViewController: UIViewController, UISearchControllerDelegate {
    
    private let viewModel = SearchViewControllerViewModel()
    
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
        tableView.delegate = self
        tableView.tableHeaderView = createSearchBar()
    }
    
    @Published var searchText: String?
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        configureDataSource()
        setupObservers()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.tintColor = Colors.textColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.textColor ?? .white]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Colors.textColor ?? .white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
    }
    
    private func createSearchBar() -> UIView {
        let headerViewSearchBar = UISearchBar()
        headerViewSearchBar.frame = CGRect(x: 0, y: 0, width: view.width, height: 44)
        headerViewSearchBar.becomeFirstResponder()
        headerViewSearchBar.searchBarStyle = .minimal
        headerViewSearchBar.delegate = self
        headerViewSearchBar.tintColor = Colors.tintColor
        return headerViewSearchBar
    }
    
    private func setupObservers() {
        $searchText
            .receive(on: RunLoop.main)
            .sink { text in
                self.viewModel.searchText = text
            }
            .store(in: &cancellables)
    }
    
    private func configureDataSource() {
        viewModel.datasource = UITableViewDiffableDataSource<Int, Results>(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieTableViewCell.identifier, for: indexPath) as? SearchMovieTableViewCell else { return UITableViewCell() }
            cell.configure(with: model)
            self.tableView.isHidden = false
            return cell
        })
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MovieDetailsViewController()
        guard let model = viewModel.datasource?.snapshot().itemIdentifiers[indexPath.row] else { return }
        vc.title = model.title
        vc.viewModel.getMovieByID(id: model.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
