//
//  MovieDetailVC.swift
//  iFrames
//
//  Created by Engin KUK on 31.07.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    let moviePath: String
//    let movieImage: UIImage?
    
    init(url: String) {
       
      self.moviePath = url
      super.init(nibName: nil, bundle: nil)
      title =  "test"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
 
         
    }
    
    
}

