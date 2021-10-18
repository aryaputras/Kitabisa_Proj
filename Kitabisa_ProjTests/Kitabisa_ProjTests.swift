//
//  Kitabisa_ProjTests.swift
//  Kitabisa_ProjTests
//
//  Created by Abigail Aryaputra Sudarman on 16/10/21.
//

import XCTest
@testable import Kitabisa_Proj

class Kitabisa_ProjTests: XCTestCase {
    let CD = CoreDataServices()
    let network = NetworkServices()
    

    func test_CD() {
        
        let isFav = CD.isMovieFavorite(movieID: 292929)
        XCTAssertFalse(isFav)
    }
    func test_get_movies() throws {
        var mov: [Movie]?
        network.getMoviesData(category: .nowPlaying) { result in
            switch result{
            case .success(let resp):
                
                mov = resp.results
                XCTAssertNotNil(mov)
            case .failure(let err):
                print(err)
            }
        }
        
        
    }
    
    func test_get_review(){
        let movieID = 725273
        var rev: [MovieReview]?
        network.getMovieReviews(movieID: "\(movieID)") { result in
            switch result{
            case .success(let resp):
                rev = resp.results
                XCTAssertNotNil(rev)
            case .failure(let err):
                print(err)
                XCTAssertNotNil(err)
            }
        }
        
        
        
        
    }
    
    func test_get_movie_detail(){
        
        let movieID = 744275
        var movDetail: MovieDetail?
        network.getMovieDetail(movieID: "\(movieID)") { result in
            switch result{
            case .success(let resp):
                movDetail = resp
                XCTAssertNotNil(movDetail)
            case .failure(let err):
                print(err)
                XCTAssertNotNil(err)
            }
        }
        
        
        
    }
    
    


}
