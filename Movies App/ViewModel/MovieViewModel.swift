//
//  MovieViewModel.swift
//  Movies App
//
//  Created by Tarun Gorre on 01.06.19.
//  Copyright © 2019 Tarun Gorre. All rights reserved.
//

import Foundation

class MovieViewModel: NSObject {
    var movies: [Movie]?
    var similarMovies: [Movie]?

    // Here we call the API for fetching now_playing movies
    func fetchTheNewMovies(completion:@escaping (_ movies:[Movie])->()) {
        APIManager.fetchTheMovies(movieType: "new", movieId: 0) { movies in
            self.movies = movies
            completion(self.movies ?? [])
        }
    }
    
    // Here we call the API for fetching similar movies based on the movieId of the selected movie
    func fetchSimilarMovies(movieId: Int, completion:@escaping (_ movies:[Movie])->()) {
        APIManager.fetchTheMovies(movieType: "similar", movieId: movieId) { movies in
            self.similarMovies = movies
            completion(self.similarMovies ?? [])
        }
    }

    // number of movies fetched from now_playing API request
    func numberOfMovies() -> Int {
        return self.movies?.count ?? 0
    }
    
    // movie object of the selected Movie
    func fetchTheMovie(index: Int) -> Movie? {
        return self.movies?[index]
    }
    
    // number of movies fetched from similar movies API request
    func numberOfSimilarMovies() -> Int {
        return self.similarMovies?.count ?? 0
    }

    // movie object of the selected Movie from the similar movies
    func fetchSimilarMovie(index: Int) -> Movie? {
        return self.similarMovies?[index]
    }

}
