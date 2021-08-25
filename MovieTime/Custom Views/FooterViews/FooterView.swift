//
//  FooterView.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 01.08.2021.
//

import SDWebImage
import UIKit

protocol FooterViewDelegate: AnyObject {
    func didTapMoviesButton()
    func didTapTVsButton()
}

class FooterView: UIView {
    
    weak var delegate: FooterViewDelegate?
    
    private let top250MoviesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Top 250 Movies", for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleColor(Colors.buttonColor, for: .normal)
        button.backgroundColor = .systemYellow
        return button
    }()
    
    private let top250TVsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Top 250 TV Series", for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleColor(Colors.buttonColor, for: .normal)
        button.backgroundColor = .systemYellow
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        top250MoviesButton.addTarget(self, action: #selector(didTapMoviesButton), for: .touchUpInside)
        top250TVsButton.addTarget(self, action: #selector(didTapTVsButton), for: .touchUpInside)
        addSubview(top250MoviesButton)
        addSubview(top250TVsButton)
    
        top250MoviesButton.translatesAutoresizingMaskIntoConstraints = false
        top250TVsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            top250MoviesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            top250MoviesButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            top250MoviesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            top250MoviesButton.heightAnchor.constraint(equalToConstant: 44),
            
            top250TVsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            top250TVsButton.topAnchor.constraint(equalTo: top250MoviesButton.bottomAnchor, constant: 20),
            top250TVsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            top250TVsButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapMoviesButton() {
        delegate?.didTapMoviesButton()
    }
    
    @objc private func didTapTVsButton() {
        delegate?.didTapTVsButton()
    }
}

