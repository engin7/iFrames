//
//  MovieListVC.swift
//  iFrames
//
//  Created by Engin KUK on 31.07.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    lazy var searchBar:UISearchBar = UISearchBar(frame: .zero)
    private let search = NetworkManager.shared
    var downloadTask: URLSessionDownloadTask?

    private let searchText = BehaviorRelay<String?>(value: nil)
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureSearch() //call Rx functions
        collectionView.backgroundColor = .systemGray5
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    deinit {
       downloadTask?.cancel()
    }
     
    func configureSearchBar() {
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search for movies..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        self.definesPresentationContext = true
        
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 138)
    }
    
    func showNetworkError() {
         let alert = UIAlertController(title: "Sorry...", message: "Error occured connecting the Movie DataBase. Please try again.", preferredStyle: .alert)
         
         let action = UIAlertAction(title: "OK", style: .default, handler: nil)
         alert.addAction(action)
         present(alert, animated: true, completion: nil)
         }
    
}


//MARK: - Rx Setup
// reactive Observer to update the   automatically.
private extension MovieListVC {
    
    func setupCellConfiguration() {
        
        collectionView.dataSource = nil // before creating our new datasource with .bind

        switch search.state {
             case .results(let list):
                list.asObservable()
               .bind(to: collectionView
               .rx
               .items(cellIdentifier: "Cell",
                cellType: MovieCell.self)) { _, element, cell in
                cell.titleLabel.text = element.title
                cell.releaseDate.text = String(element.release_date.prefix(4) )
                cell.rating.text = "rating: ★  \(element.averageVote ) "
                cell.voteCount.text = "total votes: \(Int(element.vote_count )) "
                cell.listImageView.image = nil // reset the image
                cell.imagePath = element.imagePath
                if cell.imagePath == element.imagePath { //to prevent possible flickering issues
                    if let image = PersistenceManager.getSavedImage(named: element.imagePath) {
                    cell.listImageView.image = image //read image from local path
                    } else {  // write image to local path for first time loading and put inside view
                    self.downloadTask = NetworkManager.shared.loadImage(imageView: cell.listImageView, path: element.imagePath, size: 92)
                    }
                }
                }
               .disposed(by: disposeBag)
             default:
               return
           // FIXME: show loading, not found cell etc..
        }
    }
    
    func setupCellTapHandling() {
      collectionView
        .rx
        .modelSelected(SearchResult.self) // return Observable
        // Taking that Observable, call subscribe(onNext:), passing in a closure of what should be done any time a model is selected
        .subscribe(onNext: { [unowned self] result in
           
          if let selectedRowIndexPath = self.collectionView.indexPathsForSelectedItems?.first
          {
            // don't select multiple items
            self.collectionView.deselectItem(at: selectedRowIndexPath, animated: true)
            let vc = MovieDetailVC(movie: result)
            self.navigationController?.pushViewController(vc, animated: true)
          }
        })
      .disposed(by: disposeBag)
    }
     
    func configureSearch() {
        searchBar.rx.text.asDriver()
                .drive(searchText)
                .disposed(by: disposeBag)

            searchText.asObservable().subscribe(onNext: { [weak self] (text) in
                if let vc = self, vc.searchBar.text != text {
                    vc.searchBar.text = text
                }
            })
                .disposed(by: disposeBag)

             searchText.asObservable().subscribe(onNext: { [weak self] (text) in
                self!.search.performSearch(for: self!.searchText.value!, completion: {success in
                    if !success {
                        self!.showNetworkError()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { //fetch realm data
                        self!.setupCellConfiguration()
                        self!.setupCellTapHandling()
                          }
            
                 })
            })
            .disposed(by: disposeBag)
    }
}
