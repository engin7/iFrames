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
    
    private let searchText = BehaviorRelay<String?>(value: nil)
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureSearch() //call Rx function
        collectionView.backgroundColor = .white
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "Cell")
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
        return CGSize(width: view.frame.width, height: 100)
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
               }
               .disposed(by: disposeBag)
             default:
               break
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
            self.collectionView.deselectItem(at: selectedRowIndexPath, animated: true)
//            print(result)
          }
        })
        .disposed(by: disposeBag)
    }
    
    
// TODO: Tapping function .modelSelected
    // let vc = ChatViewController(url: )
    // self.navigationController?.pushViewController(vc, animated: true)
    
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
                    self!.setupCellConfiguration()
                    self!.setupCellTapHandling()
                 })
            })
            .disposed(by: disposeBag)
        }
    }
    
 
 
