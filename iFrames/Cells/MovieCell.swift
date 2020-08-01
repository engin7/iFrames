//
//  MovieCell.swift
//  iFrames
//
//  Created by Engin KUK on 31.07.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//
import UIKit
 
class MovieCell: UICollectionViewCell {
    
    let titleLabel     = UILabel()
    let releaseDate    = UILabel()
    let rating         = UILabel()
    let voteCount      = UILabel()
    let listImageView  = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(releaseDate)
        addSubview(listImageView)
        addSubview(rating)
        addSubview(voteCount)

        listImageView.translatesAutoresizingMaskIntoConstraints = false
        listImageView.clipsToBounds = true
        listImageView.frame = CGRect(x: 0, y: 0, width: 92, height: 138)
        listImageView.backgroundColor = .systemGray6
        listImageView.layer.cornerRadius = 20
        listImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]

        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true

        releaseDate.font = UIFont.boldSystemFont(ofSize: 14)
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        releaseDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true
        
        rating.font = UIFont.boldSystemFont(ofSize: 12)
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.topAnchor.constraint(equalTo: topAnchor, constant: 58).isActive = true
        rating.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true
        
        voteCount.font = UIFont.boldSystemFont(ofSize: 12)
        voteCount.translatesAutoresizingMaskIntoConstraints = false
        voteCount.topAnchor.constraint(equalTo: topAnchor, constant: 76).isActive = true
        voteCount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}

 
 
