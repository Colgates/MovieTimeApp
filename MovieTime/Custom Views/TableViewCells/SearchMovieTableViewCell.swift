//
//  SearchMovieTableViewCell.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 20.07.2021.
//
import SDWebImage
import UIKit

class SearchMovieTableViewCell: UITableViewCell {
    
    static let identifier = "SearchMovieTableViewCell"
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemYellow
        label.textAlignment = .center
        label.textColor = .darkText
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        return label
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let crewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Colors.gray
        return imageView
    }()
    //210x322
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = Colors.black
        
        contentView.addSubview(rankLabel)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(crewLabel)
        contentView.addSubview(ratingLabel)
        
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        crewLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
                NSLayoutConstraint.activate([
                    
                    movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                    movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                    movieImageView.widthAnchor.constraint(equalToConstant: 105),
                    movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                    
                    movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
                    movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                    movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),

                    yearLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
                    yearLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor),
                    yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    
                    crewLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
                    crewLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor),
                    crewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

                    ratingLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
                    ratingLabel.topAnchor.constraint(equalTo: crewLabel.bottomAnchor, constant: 10),
                    ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                    
                    rankLabel.heightAnchor.constraint(equalToConstant: 30),
                    rankLabel.widthAnchor.constraint(equalToConstant: 30),
                    rankLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                    rankLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with searchResults: Results) {
        rankLabel.isHidden = true
        movieTitleLabel.text = "\(searchResults.title) \n\(searchResults.description)"
        movieImageView.sd_setImage(with: URL(string: searchResults.image), completed: nil)
    }
    
    func configure(with movie: Movie) {
        movieImageView.sd_setImage(with: URL(string: movie.image))
        movieTitleLabel.text = movie.title
        yearLabel.text = "Year: \(movie.year)"
        crewLabel.text = "Crew: \(movie.crew ?? "No information")"
        ratingLabel.text = "⭐️ \(movie.imDbRating ?? "")"
        
        rankLabel.text = movie.rank
    }
}
