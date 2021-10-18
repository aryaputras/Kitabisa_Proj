//
//  DetailViewController.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 17/10/21.
//

import UIKit

///View controller for Detail view
class DetailViewController: UIViewController {
    

    ///Outlet for overview label. Shows movie overview or synposis
    @IBOutlet weak var overviewLabel: UILabel!
    ///Outlet for movie image. Shows backdrop of an image
    @IBOutlet weak var movieImageView: UIImageView!
    ///Outlet for movie title. Shows movie title
    @IBOutlet weak var movieTitle: UILabel!
    ///Outlet for favorite button with heart icon
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    ///Outlet for collection view to display movie reviews
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
   
    ///Network service. Call to use their functionality
    var networkService = NetworkServices()
    ///Core data service. Call to use their functionality
    var coreDataServices = CoreDataServices()
    //Movie Data
    var releaseDate = ""
    var movieID = 0
    ///Stored reviews from API, for later be feeded into collection view
    var reviews = [MovieReview]()
    ///State tracker if movie shown in this page is favorited
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Collection View setup
        reviewCollectionView.dataSource = self
        reviewCollectionView.delegate = self
        reviewCollectionView.register(UINib(nibName: "ReviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "reviewCell")
        print(movieID)
        
        setupViews()
        
        self.movieTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
    }
    
    // Do any additional setup after loading the view.
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        if isFavorite == false {
        coreDataServices.saveToFavorite(movieID: movieID, overview: overviewLabel.text!, releaseDate: releaseDate, title: movieTitle.text!, imageData: (movieImageView.image?.pngData())!)
            
            isFavorite = true
            favoriteButtonOutlet.imageView?.image = UIImage(systemName: "heart.fill")
            
        } else {
            
            coreDataServices.deleteFromFavorite(movieID: movieID)
            
            isFavorite = false
            favoriteButtonOutlet.imageView?.image = UIImage(systemName: "heart")
        }
    }
    
    func setupViews(){
        
        //Set favorite state
        if coreDataServices.isMovieFavorite(movieID: movieID){
            favoriteButtonOutlet.imageView?.image = UIImage(systemName: "heart.fill")
            isFavorite = true
        }
        
        //Get movie detail
        networkService.getMovieDetail(movieID: "\(movieID)") { result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    
                    
                    self.movieTitle.text = res.title
                    self.overviewLabel.text = res.overview
                    self.movieImageView.load(path: res.backdrop_path, resolution: .high)
                    self.releaseDate = res.release_date
                    
                }
                
            case .failure(let err):
                print("error fetching details")
            }
        }
        
        
        //Get movie reviews
        networkService.getMovieReviews(movieID: "\(movieID)") { result in
            switch result{
            case .success(let res):
                DispatchQueue.main.async {
                    
                
                    print("success", res.results)
                    self.reviews = res.results
                    self.reviewCollectionView.reloadData()
                }
            case .failure(let err):
                print("error", err)
            }
        }
    }
}

