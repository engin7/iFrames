//
//  MovieCell.swift
//  iFrames
//
//  Created by Engin KUK on 31.07.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//
import UIKit
 
class MovieCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
           let lb  = UILabel()
           lb.text = "Movie Name"
           lb.font = UIFont.boldSystemFont(ofSize: 14)
           lb.font = UIFont.boldSystemFont(ofSize: 14)
           lb.translatesAutoresizingMaskIntoConstraints = false
           return lb
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 8 ).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}

 
 
