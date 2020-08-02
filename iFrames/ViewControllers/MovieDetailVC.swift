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
import Network

class MovieDetailVC: UIViewController {
    
    var movie :  BehaviorRelay<SearchResult>
    let overview   = UILabel()
    let movieImage = UIImageView()
    var downloadTask: URLSessionDownloadTask?
    private let disposeBag = DisposeBag()
    private let search = NetworkManager.shared
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")

    init(movie: SearchResult) {
        self.movie = BehaviorRelay(value: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                //update movie by network call for updated values (rating, #votes etc)
                var updatedMovie: SearchResult?
                self.search.movieDetail(for: self.movie.value.id, completion: {success in
                    switch self.search.state {
                     case .result(let item):
                     updatedMovie = item
                   default:
                   return
                    }
                    self.movie = BehaviorRelay(value: updatedMovie!)
                 })
            } else {
                 print("There's no internet connection.")
            }
        }
        monitor.start(queue: queue)
        setupCellConfiguration()
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

    func setupCellConfiguration() {
      movie.asObservable() //  .subscribe(onNext: to discover changes to the Observable’s value.
        .subscribe(onNext: { [unowned self] movie in
            self.overview.text = movie.overview
            self.downloadTask = NetworkManager.shared.loadImage(imageView: self.movieImage, path: movie.image, size: 342)
            self.title =  movie.title
        })
        .disposed(by: disposeBag)
    }
    
}

