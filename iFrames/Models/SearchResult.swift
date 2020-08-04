//
//  SearchResult.swift
//  iFrames
//
//  Created by Engin KUK on 31.07.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import Foundation
import RealmSwift

class SearchResult: Object,Codable {
    
    @objc dynamic var title         = ""
    @objc dynamic var overview      = ""
    @objc dynamic var release_date  = ""
    @objc dynamic var imagePath     = ""
    @objc dynamic var averageVote   = 0.0
    @objc dynamic var popularity    = 0.0
    @objc dynamic var vote_count    = 0.0
    @objc dynamic var id            = 0
    var genres                      = List<Int>()
    

   enum CodingKeys: String, CodingKey {
      case imagePath = "poster_path"
      case averageVote = "vote_average"
      case title, overview, release_date
      case popularity, vote_count, id
      case genres = "genre_ids"
   }
     
    var labels: [String] {
        var arrayOfValues: [String] = []
         for  genre  in genres {
        switch  genre {
        case 28: arrayOfValues.append("Action")
        case 12: arrayOfValues.append("Adventure")
        case 16: arrayOfValues.append("Animation")
        case 35: arrayOfValues.append("Comedy")
        case 80: arrayOfValues.append("Crime")
        case 18: arrayOfValues.append("Drama")
        case 10751: arrayOfValues.append("Family")
 
        default: break
        }
        }
            return  arrayOfValues
    }
    
    
}

 

 
 

// TODO: show genres

//
//{
//  "genres": [
//    {
//      "id": 28,
//      "name": "Action"
//    },
//    {
//      "id": 12,
//      "name": "Adventure"
//    },
//    {
//      "id": 16,
//      "name": "Animation"
//    },
//    {
//      "id": 35,
//      "name": "Comedy"
//    },
//    {
//      "id": 80,
//      "name": "Crime"
//    },
//    {
//      "id": 99,
//      "name": "Documentary"
//    },
//    {
//      "id": 18,
//      "name": "Drama"
//    },
//    {
//      "id": 10751,
//      "name": "Family"
//    },
//    {
//      "id": 14,
//      "name": "Fantasy"
//    },
//    {
//      "id": 36,
//      "name": "History"
//    },
//    {
//      "id": 27,
//      "name": "Horror"
//    },
//    {
//      "id": 10402,
//      "name": "Music"
//    },
//    {
//      "id": 9648,
//      "name": "Mystery"
//    },
//    {
//      "id": 10749,
//      "name": "Romance"
//    },
//    {
//      "id": 878,
//      "name": "Science Fiction"
//    },
//    {
//      "id": 10770,
//      "name": "TV Movie"
//    },
//    {
//      "id": 53,
//      "name": "Thriller"
//    },
//    {
//      "id": 10752,
//      "name": "War"
//    },
//    {
//      "id": 37,
//      "name": "Western"
//    }
//  ]
//}
