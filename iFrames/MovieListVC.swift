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
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "Cell")
        configureSearchBar()
 
    }
    
    
    override func viewDidLayoutSubviews() {
         
        
        
     }
    
    func configureSearchBar() {
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search for movies..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        self.definesPresentationContext = true
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCell
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
}

extension MovieListVC: UISearchBarDelegate {
    
     func position(for bar: UIBarPositioning) -> UIBarPosition {
         return .topAttached
        }
        

    
    }

 

