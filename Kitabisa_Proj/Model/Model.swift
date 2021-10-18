//
//  Model.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 16/10/21.
//

import Foundation
import UIKit

//MARK: - Movies

///Movies data model. Contains variable for array of Movie
struct Movies: Codable {
    var page: Int
    var results: [Movie]
}

///Movie data model. Contain movie's metadata such as id, title, overview, release date, etc
struct Movie:Codable {
    var id: Int?
    var title: String?
    var overview: String?
    var poster_path: String?
    var vote_average: Float?
    var backdrop_path: String?
    var release_date: String?
}
///Movie data model final. Contains Movie, but the poster is UIImage
struct MovieFinal {
    var id: Int?
    var title: String?
    var overview: String?
    var poster: UIImage?
    var vote_average: Float?
    var release_date: String?
}



//MARK: - Review
///Movie Reviews data model, contains array of movie review
struct MovieReviews: Codable {
    var id: Int?
    var results: [MovieReview]
}

///Movie reviews data model, contains author, content, id, creation date, etc
struct MovieReview: Codable {
    var author: String?
    var content: String?
    var id: String?
    var created_at: String?
    
}



//MARK: - Detail

///Movie detail data mode, contains more detail of a movie, including revenue, runtime, genres, tagline, etc
struct MovieDetail: Codable{
    var title: String
    var overview: String
    var poster_path: String
    var backdrop_path: String
    var tagline: String
    var vote_average: Double
    var revenue: Int
    var homepage: String
    
    //newly added
    var runtime: Int
    var genres: [Genre]
    var release_date: String
}

///Movie genre data model, contains genre ID (defined by TMDB API) and genre name
struct Genre: Codable {
    var id: Int
    var name: String
  
}



//MARK: - Category
///Category for dashboard filters segmented control
enum Category {
    case popular
    case topRated
    case nowPlaying
}
