//
//  MovieDetailVC.swift
//  iFrames
//
//  Created by Engin KUK on 31.07.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    let movie: SearchResult
    let overview   = UILabel()
    let movieImage = UIImageView()
    var downloadTask: URLSessionDownloadTask?

    init(movie: SearchResult) {
      self.movie = movie
      self.overview.text = movie.overview
      self.downloadTask = NetworkManager.shared.loadImage(imageView: movieImage, path: movie.image, size: 342)
      super.init(nibName: nil, bundle: nil)
      title =  movie.title
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

        self.view.backgroundColor = .white
        view.addSubview(movieImage)
        view.addSubview(overview)
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.clipsToBounds = true
        movieImage.frame = CGRect(x: (view.frame.width - view.frame.width/1.5) / 2, y: (view.frame.height - view.frame.width/1.5) / 5, width: view.frame.width/1.5, height: view.frame.width)
        movieImage.contentMode = .scaleAspectFit
        
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.font = UIFont.boldSystemFont(ofSize: 16)
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.frame = CGRect(x: (view.frame.width - view.frame.width/1.5) / 2, y: (view.frame.height - view.frame.width/1.2), width: view.frame.width/1.5, height: view.frame.width)
        overview.numberOfLines = 8
    }
    
}

