//
//  ViewController.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 16/10/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {


    

    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    ///Stored movies data from API
    var moviesData: [Movie] = [Movie]()
    
    ///Network service. Call to use their functionality
    var networkService = NetworkServices()
    var coreDataService = CoreDataServices()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        
        getMoviesData(categoryIndex: categorySegmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func categorySegmentedControlValueChanged(_ sender: UISegmentedControl) {
        getMoviesData(categoryIndex: sender.selectedSegmentIndex)
    }
    ///Check contents inside movieData variable
    @IBAction func checkDidTap(_ sender: Any) {
        coreDataService.clearFavorite()
    }

    @IBAction func trashIsFavTapped(_ sender: Any) {
        print(coreDataService.isMovieFavorite(movieID: 69420))
    }
    @IBAction func trashAdd2Fav(_ sender: Any) {
        coreDataService.saveToFavorite(movieID: 69420)
    }
    
    ///Fetch movie data from API and store into variable
    func getMoviesData(categoryIndex: Int) {
        
        var selectedCategory: Category {
            if categoryIndex == 0 {
                return .nowPlaying
            } else if categoryIndex == 1 {
                return .popular
            } else {
                return .topRated
            }
        }
        
        
        networkService.getMoviesData(category: selectedCategory) { result in
            switch result{
            case .success(let response):
                DispatchQueue.main.async {
                    
                
                self.moviesData = response.results
                    self.movieListCollectionView.reloadData()
                    print(self.moviesData)
                }
                
            case .failure(let error):
                print("ERROR FETCHING")
                
            }
        }
    }


}







extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }

}

