//
//  MovieListVC.swift
//  iFrames
//
//  Created by Engin KUK on 31.07.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import UIKit


class MovieListVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    lazy var searchBar:UISearchBar = UISearchBar(frame: .zero)
    private let search = NetworkManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "Cell")
        configureSearchBar()
 
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch NetworkManager.shared.state {
         case .notSearchedYet:
           return 0
         case .loading:
           return 1
         case .noResults:
           return 1
         case .results(let list):
           return list.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        switch NetworkManager.shared.state {
             case .notSearchedYet:
               fatalError("Not possible")
               
             case .loading:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCell
           
                
               return cell
               
             case .noResults:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCell
               cell.titleLabel.text = "Sorry, nothing found"
                return cell
               
             case .results(let list):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCell
                
                cell.titleLabel.text = list[indexPath.row].title
                return cell
        }
        
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func showNetworkError() {
         let alert = UIAlertController(title: "Sorry...", message: "Error occured connecting the Movie DataBase. Please try again.", preferredStyle: .alert)
         
         let action = UIAlertAction(title: "OK", style: .default, handler: nil)
         alert.addAction(action)
         present(alert, animated: true, completion: nil)
         }
    
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
              self.collectionView.reloadData()
             })
            
            collectionView.reloadData()
            searchBar.resignFirstResponder()
          }
    
    }

 

