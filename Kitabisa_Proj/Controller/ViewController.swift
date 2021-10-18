//
//  ViewController.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 16/10/21.
//

import UIKit
import CoreData

///View controller for root view.
class ViewController: UIViewController {
    
    
    
    ///Collection view outlet for list of movies displayed in view
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    ///Outlet for segmented control. Choose between popular, trending, etc
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    ///Stored movies data from API
    var moviesData: [Movie] = [Movie]()
    ///Final movies data, UIImage included
    var finalMoviesData: [MovieFinal] = [MovieFinal]()
    ///Network service. Call to use their functionality
    var networkService = NetworkServices()
    ///Core data service. Call to use their functionality
    var coreDataService = CoreDataServices()
    ///ID of movie. Defined by TMDB API
    var movieID = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Collection View Setup
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        movieListCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        //
        getMoviesData(categoryIndex: categorySegmentedControl.selectedSegmentIndex)
    }
    
    ///Favorite button in Bar Item. Used for segue
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "homeToFavorite", sender: self)
    }
    
    ///Run when segmented control value has changed
    @IBAction func categorySegmentedControlValueChanged(_ sender: UISegmentedControl) {
        getMoviesData(categoryIndex: sender.selectedSegmentIndex)
    }
    ///Check contents inside movieData variable
    @IBAction func checkDidTap(_ sender: Any) {
        coreDataService.clearFavorite()
    }
    
    @IBAction func trashIsFavTapped(_ sender: Any) {
        print("button not configured")
    }
    @IBAction func trashAdd2Fav(_ sender: Any) {
        print("button not configured")
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
        
        //Get data
        networkService.getMoviesData(category: selectedCategory) { result in
            switch result{
            case .success(let response):
                DispatchQueue.main.async {
                    
                    
                    self.moviesData = response.results
                    self.processMovies(movie: response.results)
                    
                    self.movieListCollectionView.reloadData()
                   
                }
                
            case .failure(let error):
                print("ERROR FETCHING")
                
            }
        }
    }
    ///Process movies, turn url path into UIImage
    func processMovies(movie: [Movie]){
        var mov = [MovieFinal]()
        
        for i in movie{
            let url = AppConstants().BASE_IMG_URL_LOW?.appendingPathComponent(i.poster_path!)
            
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data){
                    mov.append(MovieFinal(id: i.id, title: i.title, overview: i.overview, poster: image, vote_average: i.vote_average, release_date: i.release_date))
                }
            }
           
        }
        
        self.finalMoviesData = mov
        
        print(self.finalMoviesData)
        
        
        
    }
    
    ///Prepare for segue into detail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailViewController{
        
        destinationVC.movieID = movieID
        }
    
    }
    
    
}





