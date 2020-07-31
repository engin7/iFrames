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
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "Cell")

    }
     
    func configureSearchBar() {
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search for movies..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
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
    
    
// TODO: Tapping function .modelSelected
    // let vc = ChatViewController(url: )
    // self.navigationController?.pushViewController(vc, animated: true)
    
    
}
 
extension MovieListVC: UISearchBarDelegate {
    
     func position(for bar: UIBarPositioning) -> UIBarPosition {
         return .topAttached
        }
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
      search.performSearch(for: searchBar.text!, completion: {success in
          
     if !success {
                 self.showNetworkError()
                 }
        self.setupCellConfiguration()
       })
        searchBar.resignFirstResponder()
    }
}

 

