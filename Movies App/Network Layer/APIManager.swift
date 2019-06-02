//
//  APIManager.swift
//  Movies App
//
//  Created by Tarun Gorre on 01.06.19.
//  Copyright © 2019 Tarun Gorre. All rights reserved.
//


import Foundation

public class APIManager {
    static let apiKey = "68d9195b856d6960e5a60da525d650bf"
    static let baseAPIURL = "https://api.themoviedb.org/3/movie"
    static let nowPlayingMoviesEndPoint = "/now_playing"
    static let similarMoviesEndPoint = "/similar"
    static let trailingEndPoint = "?page=1&language=en&api_key="
    
    class func fetchTheMovies(movieType: String, movieId: Int, completion: @escaping (_ movies: [Movie]) -> ()) {
        // Fetch the data from API
        var endPoint: String
        
        if movieType == "new" {
            endPoint = "\(baseAPIURL)\(nowPlayingMoviesEndPoint)\(trailingEndPoint)\(apiKey)"
        } else {
            endPoint = "\(baseAPIURL)/\(movieId)\(similarMoviesEndPoint)\(trailingEndPoint)\(apiKey)"
        }
        
        guard let jsonUrl = URL(string: endPoint) else { return }
        
        URLSession.shared.dataTask(with: jsonUrl) { (data, response, error) in
        
        guard let data = data else { return }
        do {
            let jsonObject = try JSONDecoder().decode(MoviesResponse.self, from: data)
            let movies = jsonObject.results
            completion(movies)
        } catch let error {
            print("Unable to serialize the json: ",error)
        }
      }.resume()
    }
}


