//
//  Model.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 16/10/21.
//

import Foundation

//MARK: - Movies
struct Movies: Codable {
    var page: Int
    var results: [Movie]
}
struct Movie:Codable {
    var id: Int?
    var title: String?
    var overview: String?
    var poster_path: String?
    var vote_average: Float?
    var backdrop_path: String?
}



//MARK: - Review
struct MovieReviews: Codable {
    var id: Int?
    var results: [MovieReview]
}

struct MovieReview: Codable {
    var author: String?
    var content: String?
    var id: String?
    var created_at: String?
    
}



//MARK: - Detail
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


struct Genre: Codable {
    var id: Int
    var name: String
  
}



//MARK: - Category
///Category for dashboard filters
enum Category {
    case popular
    case topRated
    case nowPlaying
}
