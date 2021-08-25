//
//  MovieDetailsViewController.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 24.07.2021.
//
import Combine
import UIKit

final class MovieDetailsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(DetailCollectionTableViewCell.self, forCellReuseIdentifier: DetailCollectionTableViewCell.identifier)
        tableView.register(HomeCollectionTableViewCell.self, forCellReuseIdentifier: HomeCollectionTableViewCell.identifier)
        tableView.backgroundColor = Colors.black
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 50
        return tableView
    }()
    
    var viewModel = MovieDetailsViewControllerViewModel()
    
    private var movieToSaveToWatchlist: Movie?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func configureDatasource() {
        viewModel.dataSource = UITableViewDiffableDataSource<Int, SectionWrapper>(tableView: tableView, cellProvider: { tableView, indexPath, wrapper in
            switch wrapper {
            
            case .actors(let actors):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCollectionTableViewCell.identifier, for: indexPath) as? DetailCollectionTableViewCell else { return UITableViewCell() }
                cell.configure(with: actors)
                cell.delegate = self
                return cell
                
            case .movies(let movies):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollectionTableViewCell.identifier, for: indexPath) as? HomeCollectionTableViewCell else { return UITableViewCell() }
                cell.configure(with: movies)
                cell.delegate = self
                return cell
            }
        })
    }
}

// MARK: - UITableViewDelegate
extension MovieDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()
        let names = ["Cast", "Similar Movies"]
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.frame = CGRect(x: 20, y: 0, width: view.width, height: tableView.sectionHeaderHeight)
        label.textColor = Colors.textColor
        label.text = names[section]
        container.addSubview(label)
        return container
    }
}

// MARK: - HomeCollectionTableViewCellDelegate
extension MovieDetailsViewController: HomeCollectionTableViewCellDelegate {
    
    func didSelectItem(with model: Movie) {
        let vc = MovieDetailsViewController()
        vc.title = model.title
        vc.viewModel.getMovieByID(id: model.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - DetailCollectionTableViewCellDelegate
extension MovieDetailsViewController: DetailCollectionTableViewCellDelegate {
    
    func didSelectItem(with model: ActorList) {
        let vc = ActorDetailsViewController()
        vc.title = model.name
        vc.viewModel.getActorByID(id: model.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - DetailMovieViewControllerViewModelDelegate
extension MovieDetailsViewController: MovieDetailsViewControllerViewModelDelegate {

    func didCreateHeaderView(movie: MovieDetails) {
        let headerView = MovieDetailsHeaderView()
        headerView.delegate = self
        movieToSaveToWatchlist = Movie(id: movie.id, rank: nil, title: movie.title, year: movie.year, image: movie.image, crew: nil, imDbRating: movie.imDbRating)
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height * 0.6)
        DispatchQueue.main.async {
            headerView.configure(with: movie)
            self.tableView.tableHeaderView = headerView
        }
    }
}

// MARK: - DetailMovieViewControllerViewModelDelegate
extension MovieDetailsViewController: MovieDetailsHeaderViewDelegate {
    
    func didTapAddToWatchlistButton() {
        if let movie = movieToSaveToWatchlist {
            if DatabaseManager.shared.checkIsMovieInTheList(id: movie.id) {
                DatabaseManager.shared.deleteItemByMovieID(item: movie)
            } else {
                DatabaseManager.shared.addDocument(movie)
            }
        }
    }
}
