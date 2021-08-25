//
//  CategoryCollectionViewCell.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 20.07.2021.
//
import SDWebImage
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private var isButtonTapped = false
    
    //    private let addButton: UIButton = {
    //        let button = UIButton()
    //        button.setImage(UIImage(systemName: "plus"), for: .normal)
    //        button.backgroundColor = .black.withAlphaComponent(0.7)
    //        button.tintColor = .systemYellow
    //        button.layer.cornerRadius = 10
    //        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    //        return button
    //    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Colors.black
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = Colors.black
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .left
        label.backgroundColor = Colors.black
        label.layer.cornerRadius = 10
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath
        //        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(imageView)
        contentView.addSubview(secondLabel)
        contentView.addSubview(firstLabel)
        //        contentView.addSubview(addButton)
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height * 0.8)
        firstLabel.frame = CGRect(x: 0, y: imageView.height, width: width, height: height * 0.1)
        secondLabel.frame = CGRect(x: 0, y: imageView.height + firstLabel.height, width: width, height: height * 0.1)
        //        addButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    }
    
    //    @objc private func didTapAddButton() {
    //
    //        if isButtonTapped {
    //            addButton.setImage(UIImage(systemName: "plus"), for: .normal)
    //            addButton.backgroundColor = .black.withAlphaComponent(0.7)
    //        } else {
    //            addButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
    //            addButton.backgroundColor = .systemYellow
    //            addButton.tintColor = .white
    //        }
    //        isButtonTapped.toggle()
    //    }
    
    func configure(with movie: Movie) {
        imageView.sd_setImage(with: URL(string: movie.image), completed: nil)
        firstLabel.text = movie.title
        if movie.imDbRating == "" {
            secondLabel.text = ""
        } else {
            secondLabel.text = "⭐️ \(movie.imDbRating ?? "")"
        }
    }
    
    func configure(with actor: ActorList) {
        //        addButton.isHidden = true
        imageView.sd_setImage(with: URL(string: actor.image), completed: nil)
        firstLabel.text = actor.name
        secondLabel.text = "as: \(actor.asCharacter)"
    }
}
