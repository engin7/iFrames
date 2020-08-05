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

class MovieDetailVC: UIViewController, UITextViewDelegate {
    
    var movie :  BehaviorRelay<SearchResult>
    let movieID: Int
    let fanArt: String

    let overview   = UITextView()
    let popularity = UILabel()
    let movieImage = UIImageView()
    var downloadTask: URLSessionDownloadTask?
    private let disposeBag = DisposeBag()
    private let search = NetworkManager.shared
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    var flag = false

    init(movie: SearchResult) {
        self.movie   = BehaviorRelay(value: movie)
        self.movieID = movie.id
        self.fanArt = movie.backdrop_path ?? ""

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overview.delegate = self
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                //update movie by network call for updated values (rating, #votes etc)
                if self.flag == true {
                    var updatedMovie: SearchResult?
                    self.search.movieDetail(for: self.movieID, completion: {success in
                        switch self.search.state {
                        case .result(let item):
                            updatedMovie = item
                        default:
                            return
                        }
                        self.movie = BehaviorRelay(value: updatedMovie!)
                    })
                }
                self.flag = true
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
        
        view.addSubview(popularity)
        view.addSubview(movieImage)
        view.addSubview(overview)
        
        popularity.translatesAutoresizingMaskIntoConstraints = false
        popularity.font = UIFont.boldSystemFont(ofSize: 16)
        popularity.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        popularity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.clipsToBounds = true
        movieImage.frame = CGRect(x: (view.frame.width - view.frame.width/1.5) / 2, y: 110, width: view.frame.width/1.5, height: view.frame.width)
        movieImage.contentMode = .scaleAspectFit
        movieImage.layer.cornerRadius = 40
        
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.font = UIFont.boldSystemFont(ofSize: 16)
        overview.isEditable = false
        overview.isSelectable = false
        overview.frame = CGRect(x: (view.frame.width - view.frame.width/1.5) / 2, y: view.frame.width+110, width: view.frame.width/1.5, height:  view.frame.width/2)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if overview.contentSize.height > overview.frame.size.height && (overview.contentOffset.y >= overview.contentSize.height - overview.frame.size.height)
        {
            self.downloadTask = NetworkManager.shared.loadImage(imageView: self.movieImage, path:  fanArt, size: 300)
        }
        
        if overview.contentSize.height < overview.frame.size.height {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.downloadTask = NetworkManager.shared.loadImage(imageView: self.movieImage, path:  self.fanArt, size: 300)
            }
        }
        
    }
    
    //MARK: - Rx Setup
    
    func setupCellConfiguration() {
        movie.asObservable() //  .subscribe(onNext: to discover changes to the Observable’s value.
            .subscribe(onNext: { [unowned self] movie in
                self.overview.text = movie.overview
                self.popularity.text = "Popularity: " + String(movie.popularity)
                self.downloadTask = NetworkManager.shared.loadImage(imageView: self.movieImage, path: movie.imagePath, size: 342)
                self.title =  movie.title
            })
            .disposed(by: disposeBag)
    }
    
}

