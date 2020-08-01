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
    let listImageView  = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        addSubview(titleLabel)
        addSubview(releaseDate)
        addSubview(listImageView)

        listImageView.translatesAutoresizingMaskIntoConstraints = false
        listImageView.clipsToBounds = true
        listImageView.frame = CGRect(x: 8, y: 8, width: 84, height: 84)
        listImageView.backgroundColor = .blue
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true

        releaseDate.font = UIFont.boldSystemFont(ofSize: 14)
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.topAnchor.constraint(equalTo: topAnchor, constant: 36).isActive = true
        releaseDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}

 
 
