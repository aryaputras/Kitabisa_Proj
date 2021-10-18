//
//  NetworkServices.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 16/10/21.
//

import Foundation
import UIKit

//Popular
//Top rated
//Now playing
//Detail

//Is favorite: Core Data: Check By ID.

///This class handle all network   operation within this app
class NetworkServices {
    
    ///Token for TMDB API.
    private var token = "a4fc6ff99237c2226086c2a0b90e1f49"
    

    
    ///Get list of movies from TMDB API
    func getMoviesData(category: Category, completion: @escaping (Result<Movies, Error>) -> Void) {
       
        var dataTask: URLSessionDataTask?
        
        
        ///String for choosen category to be appended into url path
        var categoryString: String {
            if category == .topRated{
                print("TOP RATED : ")
                return "top_rated"
            } else if category == .nowPlaying {
                print("NOW PLAYING : ")
                return "now_playing"
            } else if category == .popular {
                print("POPULAR : ")
                return "popular"
            }
            return ""
        }
        
        ///Final URL for movie
        let movieUrl = "https://api.themoviedb.org/3/movie/\(categoryString)?api_key=\(token)&language=en-US&page=1"
        
        
        guard let url = URL(string: movieUrl) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Movies.self, from: data)
                // print(jsonData)
                completion(.success(jsonData))
                

                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    //self.collectionViewTwo.reloadData()
                    
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }

    
    ///Get certain movie reviews from TMDB API
    func getMovieReviews(movieID: String, completion: @escaping (Result<MovieReviews, Error>) -> Void) {
        print("getting discovery")
        var dataTask: URLSessionDataTask?
        let movieDetailUrl = "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=\(token)&language=en-US"
        
        ///Final url for movie reviews
        guard let url = URL(string: movieDetailUrl) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieReviews.self, from: data)
                // print(jsonData)
                print(data)
                completion(.success(jsonData))
                
                // Back to the main thread
                
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    //self.collectionViewTwo.reloadData()
                    
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    ///Get specific movie detail from TMDB API
    func getMovieDetail(movieID: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        print("getting discovery")
        var dataTask: URLSessionDataTask?
        let movieDetailUrl = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(token)&language=en-US"
        
        
        guard let url = URL(string: movieDetailUrl) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieDetail.self, from: data)
                // print(jsonData)
                print(data)
                completion(.success(jsonData))
                
                // Back to the main thread
                
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    //self.collectionViewTwo.reloadData()
                    
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    
}


