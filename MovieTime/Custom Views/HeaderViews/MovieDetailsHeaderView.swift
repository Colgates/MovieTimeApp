//
//  DetailMovieHeaderView.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 25.07.2021.
//
import SDWebImage
import UIKit

protocol MovieDetailsHeaderViewDelegate: AnyObject {
    func didTapAddToWatchlistButton()
}
class MovieDetailsHeaderView: UIView {
    
    weak var delegate: MovieDetailsHeaderViewDelegate?
    
    var isAdded = false {
        didSet {
            if isAdded {
                watchListButton.setTitle("Added", for: .normal)
            } else {
                watchListButton.setTitle("Add to Watchlist", for: .normal)
            }
        }
    }
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15, weight: .ultraLight)
        textView.isEditable = false
        textView.backgroundColor = Colors.black
        return textView
    }()
    
    private let watchListButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.setTitleColor(Colors.buttonColor, for: .normal)
        button.backgroundColor = .systemYellow
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(detailsLabel)
        addSubview(posterImage)
        addSubview(genreLabel)
        addSubview(descriptionTextView)
        addSubview(watchListButton)
        
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        watchListButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            detailsLabel.topAnchor.constraint(equalTo: topAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            posterImage.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 20),
            posterImage.widthAnchor.constraint(equalToConstant: width * 0.4),
            posterImage.bottomAnchor.constraint(equalTo: descriptionTextView.bottomAnchor),
            
            genreLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            genreLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 20),
            genreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            descriptionTextView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            watchListButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            watchListButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            watchListButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            watchListButton.heightAnchor.constraint(equalToConstant: 44),
            watchListButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func didTapAddButton() {
        delegate?.didTapAddToWatchlistButton()
        isAdded.toggle()
    }
    
    func configure(with movie: MovieDetails) {
        detailsLabel.text = "\(movie.year)     \(movie.contentRating)     \(movie.runtimeStr)"
        posterImage.sd_setImage(with: URL(string: movie.image))
        genreLabel.text = movie.genres
        descriptionTextView.text = movie.plot
        
        if DatabaseManager.shared.checkIsMovieInTheList(id: movie.id) {
            isAdded = true
        } else {
            isAdded = false
        }
    }
}
