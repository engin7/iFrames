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
    @objc dynamic var backdrop_path : String?
    @objc dynamic var averageVote   = 0.0
    @objc dynamic var popularity    = 0.0
    @objc dynamic var vote_count    = 0.0
    @objc dynamic var id            = 0
    var genres                      = List<Int>()


   enum CodingKeys: String, CodingKey {
      case imagePath = "poster_path"
      case averageVote = "vote_average"
      case title, overview, release_date
      case popularity, vote_count, id, backdrop_path
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
            case 14: arrayOfValues.append("Fantasy")
            case 36: arrayOfValues.append("History")
            case 27: arrayOfValues.append("Horror")
            case 10402: arrayOfValues.append("Music")
            case 9648: arrayOfValues.append("Mystery")
            case 10749: arrayOfValues.append("Romance")
            case 878: arrayOfValues.append("Science Fiction")
            case 10770: arrayOfValues.append("TV Movie")
            case 53: arrayOfValues.append("Thriller")
            case 10752: arrayOfValues.append("War")
            case 37: arrayOfValues.append("Western")
            default: break
            }
        }
            return  arrayOfValues
    }
}
  
