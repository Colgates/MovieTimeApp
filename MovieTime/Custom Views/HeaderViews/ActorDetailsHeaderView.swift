//
//  ActorDetailsHeaderView.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 31.07.2021.
//

import SDWebImage
import UIKit

class ActorDetailsHeaderView: UIView {
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let awardsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .ultraLight)
        label.numberOfLines = 0
        return label
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
                addSubview(photoImageView)
                addSubview(awardsLabel)
                addSubview(descriptionLabel)
                
                detailsLabel.translatesAutoresizingMaskIntoConstraints = false
                photoImageView.translatesAutoresizingMaskIntoConstraints = false
                awardsLabel.translatesAutoresizingMaskIntoConstraints = false
                descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    
                    detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    detailsLabel.topAnchor.constraint(equalTo: topAnchor),
                    detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    detailsLabel.heightAnchor.constraint(equalToConstant: 30),
                    
                    photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    photoImageView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor),
                    photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    photoImageView.heightAnchor.constraint(equalToConstant: height * 0.5),
                    
                    descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    descriptionLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
                    descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    
                    awardsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    awardsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                    awardsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    awardsLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
    }
    
    func configure(with actor: ActorDetails) {
        detailsLabel.text = actor.role
        photoImageView.sd_setImage(with: URL(string: actor.image))
        awardsLabel.text = actor.awards
        descriptionLabel.text = actor.summary
    }
}
