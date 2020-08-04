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
    var genre0         = CustomLabel()
    var genre1         = CustomLabel()
    var genre2         = CustomLabel()
    let listImageView  = UIImageView()
    var imagePath      = ""

    
    override init(frame: CGRect) {
      
        super.init(frame: frame)
 
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(releaseDate)
        addSubview(listImageView)
        addSubview(rating)
        addSubview(voteCount)
        addSubview(genre0)
        addSubview(genre1)
        addSubview(genre2)

        genre0.font = UIFont.boldSystemFont(ofSize: 12)
        genre0.translatesAutoresizingMaskIntoConstraints = false
        genre0.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
        genre0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(120)).isActive = true
        genre0.layer.masksToBounds = true
        genre0.layer.cornerRadius = 5.0
       
        genre1.font = UIFont.boldSystemFont(ofSize: 12)
        genre1.translatesAutoresizingMaskIntoConstraints = false
        genre1.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
        genre1.layer.masksToBounds = true
        genre1.layer.cornerRadius = 5.0
        
        self.addConstraint(NSLayoutConstraint(
               item: genre1,
               attribute: .left,
               relatedBy: .equal,
               toItem: genre0,
               attribute: .right,
               multiplier: 1.0,
               constant: 10
               ))
        
        self.addConstraint(NSLayoutConstraint(
                      item: genre2,
                      attribute: .left,
                      relatedBy: .equal,
                      toItem: genre1,
                      attribute: .right,
                      multiplier: 1.0,
                      constant: 10
                      ))
        
        genre2.font = UIFont.boldSystemFont(ofSize: 12)
        genre2.translatesAutoresizingMaskIntoConstraints = false
        genre2.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
        genre2.layer.masksToBounds = true
        genre2.layer.cornerRadius = 5.0
        
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
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        titleLabel.numberOfLines = 1


        releaseDate.font = UIFont.boldSystemFont(ofSize: 14)
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        releaseDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true
        
        rating.font = UIFont.boldSystemFont(ofSize: 14)
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.topAnchor.constraint(equalTo: topAnchor, constant: 88).isActive = true
        rating.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true
        
        voteCount.font = UIFont.boldSystemFont(ofSize: 14)
        voteCount.translatesAutoresizingMaskIntoConstraints = false
        voteCount.topAnchor.constraint(equalTo: topAnchor, constant: 112).isActive = true
        voteCount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true
    }
    
   
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}

 
  
