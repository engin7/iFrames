//
//  NetworkManager.swift
//  iFrames
//
//  Created by Engin KUK on 31.07.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// Network Response
class ResultArray: Codable {
    var total_results = 0
    var results = [SearchResult]()
}

// Network Request
class NetworkManager {
static let shared = NetworkManager() // singleton
private let apiKey = "719f4948418af6489623d9d9de284d48"
private let baseURL = "https://api.themoviedb.org/3/search/movie?api_key=719f4948418af6489623d9d9de284d48&query=%@"
private let top100URL = "https://api.themoviedb.org/3/movie/top_rated?api_key=719f4948418af6489623d9d9de284d48&language=en-US&page="
    
var state: State = .notSearchedYet
private var dataTask: URLSessionDataTask? = nil

private init() {}
 
    enum State {
      case notSearchedYet
       case loading
      case noResults
      case results(BehaviorRelay<[SearchResult]>)
    }
    
typealias SearchComplete = (Bool) -> Void
// special closure takes Bool as parameter returns -> () no value to make code more readable
    func performSearch(for text: String, completion: @escaping SearchComplete )  {
        var url: URL?
        var searchResult: [SearchResult] = []
        dataTask?.cancel()  // new search cancels old one
        var newState = State.notSearchedYet
        //TODO: adjust for top 100
        if text.isEmpty {
            for index in 1...5 {
            url = URL(string: top100URL + "\(index)")
            let session = URLSession.shared
            dataTask = session.dataTask(with: url!, completionHandler: {data, response, error in
                var success = false
                // if the search cancelled ignore error code and return
                if let error = error as NSError?, error.code == -999 {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                    let searchResults = self.parse(data: data)
                    
                    if  searchResults.isEmpty {
                        newState = .noResults
                    }
                    success = true
                    searchResult.append(contentsOf:searchResults)
                    newState = .results(BehaviorRelay(value: searchResult))
                }
                DispatchQueue.main.async {
                    completion(success) //Bool
                    self.state = newState
                }
            })
            dataTask?.resume()
        }
        }
        if !text.isEmpty {
            state = .loading
            url = themoviedbURL(searchText: text)
            let session = URLSession.shared
            dataTask = session.dataTask(with: url!, completionHandler: {data, response, error in
                var newState = State.notSearchedYet
                var success = false
                // if the search cancelled ignore error code and return
                if let error = error as NSError?, error.code == -999 {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                    let searchResults = self.parse(data: data)
                    
                    if  searchResults.isEmpty {
                        newState = .noResults
                    } else {
                        newState = .results(BehaviorRelay(value: searchResults))
                    }
                    success = true
                }
                DispatchQueue.main.async {
                    self.state = newState
                    completion(success) //Bool
                }
            })
            dataTask?.resume()
        }
    }
    func loadImage(imageView: UIImageView, path: String, size: Int) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let url = URL(string: "http://image.tmdb.org/t/p/w" + String(size) + path)!
        let downloadTask = session.downloadTask(with: url,
        completionHandler: { [weak imageView] url, response, error in
          if error == nil, let url = url,
          let data = try? Data(contentsOf: url),
          let image = UIImage(data: data) {
            DispatchQueue.main.async {
                if let weakSelf = imageView as UIImageView? {
                weakSelf.image = image
              }
          } }
        })
        downloadTask.resume()
        return downloadTask
    }
    
    // MARK:- Private Methods
      private func themoviedbURL(searchText: String) -> URL {
          let encodedText = searchText.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!
          let endPoint = String(format: baseURL, encodedText) //term=%@ adds text to %@
          let url = URL(string: endPoint)
          return url!
      }
         
      private func parse(data: Data) -> [SearchResult] {
          do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from:data)
             return result.results
          } catch {
            print("JSON Error: \(error)")
        return [] }
      }
}
