//
//  ActorsCollectionViewCell.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 29.07.2021.
//

import UIKit

protocol DetailCollectionTableViewCellDelegate: AnyObject {
    func didSelectItem(with model: ActorList)
}

class DetailCollectionTableViewCell: UITableViewCell {

    public weak var delegate: DetailCollectionTableViewCellDelegate?
    
    static let identifier = "DetailCollectionTableViewCell"

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.backgroundColor = Colors.gray
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, ActorList>?

    var actors: [ActorList] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureDataSource()
        addSubview(collectionView)
        collectionView.frame = contentView.bounds
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, ActorList>(collectionView: collectionView, cellProvider: { collectionView, indexPath, model in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: model)
            return cell
        })
        var snapshot = NSDiffableDataSourceSnapshot<Int, ActorList>()
        snapshot.appendSections([0])
        snapshot.appendItems(actors)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func configure(with actors: [ActorList]) {
        self.actors = actors
    }
}
// MARK: - UICollectionViewDelegate
extension DetailCollectionTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(with: actors[indexPath.row])
    }
}

// MARK: - CollectionView Item Size
extension DetailCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.51, height: collectionView.frame.size.height * 0.9)
    }
}
