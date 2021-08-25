//
//  HomeViewController.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 20.07.2021.
//

import Combine
import UIKit

final class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewControllerViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HomeCollectionTableViewCell.self, forCellReuseIdentifier: HomeCollectionTableViewCell.identifier)
        tableView.backgroundColor = Colors.black
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 50
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        view = tableView
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDatasource()
        viewModel.getMovies()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.tableFooterView = self.createFooter()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.tintColor = Colors.textColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.textColor ?? UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Colors.textColor ?? UIColor.white]
    }

    private func configureDatasource() {
        viewModel.dataSource = UITableViewDiffableDataSource<Section, [Movie]>(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollectionTableViewCell.identifier, for: indexPath) as? HomeCollectionTableViewCell else { return UITableViewCell() }
            cell.configure(with: model)
            cell.delegate = self
            return cell
        }) 
    }
    
//    private func createHeader() -> UIView? {
////        https://www.imdb.com/video/imdb/vi2959588889/imdb/embed
//        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else { return nil }
//        print("OK")
//        let url = URL(fileURLWithPath: path)
//        let player = AVPlayer(url: url)
//        player.volume = 1
//
//        let headerView = UIView(frame: CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height / 2))
//
//        let playerLayer = AVPlayerLayer(player: player)
//
//        playerLayer.frame = headerView.bounds
//        headerView.layer.addSublayer(playerLayer)
//
//        player.play()
//        return headerView
//    }
    
    private func createFooter() -> UIView {
        let footer = FooterView()
        footer.delegate = self
        footer.frame = CGRect(x: 0, y: 0, width: view.width, height: 150)
        footer.isUserInteractionEnabled = true
        return footer
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.frame = CGRect(x: 20, y: 0, width: view.width, height: tableView.sectionHeaderHeight)
        label.textColor = Colors.textColor
        label.text = Section.allCases[section].rawValue
        container.addSubview(label)
        return container
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 2
    }
}

// MARK: - HomeCollectionTableViewCellDelegate
extension HomeViewController: HomeCollectionTableViewCellDelegate {
    func didSelectItem(with model: Movie) {
        let vc = MovieDetailsViewController()
        vc.title = model.title
        vc.viewModel.getMovieByID(id: model.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - FooterViewDelegate
extension HomeViewController: FooterViewDelegate {
    func didTapMoviesButton() {
        let vc = Top250ViewController()
        vc.title = "Top 250 Movies"
        vc.viewModel.get250Movies()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapTVsButton() {
        let vc = Top250ViewController()
        vc.title = "Top 250 TV Series"
        vc.viewModel.get250TVs()
        navigationController?.pushViewController(vc, animated: true)
    }
}
