//
//  MovieDetailVC.swift
//  iFrames
//
//  Created by Engin KUK on 31.07.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailVC: UIViewController {
    
     
    let movie :  BehaviorRelay<SearchResult>
    let overview   = UILabel()
    let movieImage = UIImageView()
    var downloadTask: URLSessionDownloadTask?
    private let disposeBag = DisposeBag()

    init(movie: SearchResult) {
        self.movie = BehaviorRelay(value: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
        setupCartObserver()
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
        movieImage.layer.cornerRadius = 40
        
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.font = UIFont.boldSystemFont(ofSize: 16)
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.frame = CGRect(x: (view.frame.width - view.frame.width/1.5) / 2, y: (view.frame.height - view.frame.width/1.2), width: view.frame.width/1.5, height: view.frame.width)
        overview.numberOfLines = 8
    }
    
    //MARK: - Rx Setup

    func setupCartObserver() {
      movie.asObservable() //  .subscribe(onNext: to discover changes to the Observable’s value.
        .subscribe(onNext: { [unowned self] movie in
            self.overview.text = movie.overview
            self.downloadTask = NetworkManager.shared.loadImage(imageView: self.movieImage, path: movie.image, size: 342)
            self.title =  movie.title
        })
        .disposed(by: disposeBag)
    }
    
}

