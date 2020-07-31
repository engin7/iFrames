//
//  SearchResult.swift
//  iFrames
//
//  Created by Engin KUK on 31.07.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import Foundation

class ResultArray: Codable {
    var total_results = 0
    var results = [SearchResult]()
}

class SearchResult:Codable, CustomStringConvertible {
    
  
    var description: String {
      return "Name: \(title ?? "None"), Summary: \(overview ?? "None")\n"
    }
    
    var title: String? = ""
    var overview: String? = ""
    var release_date:String?
    var averageVote: Double?
    var popularity: Double?
    var vote_count: Double?
    var image = ""

   enum CodingKeys: String, CodingKey {
      case image = "poster_path"
      case averageVote = "vote_average"
      case title, overview, release_date
      case popularity, vote_count
   }
    
}
