//
//  FavoriteViewController.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 17/10/21.
//

import UIKit

///View controller for favorite view
class FavoriteViewController: UIViewController {
    
    ///Core data service. Call to use their functionality
    let coreDataService = CoreDataServices()
    ///List for movie datas for later feeded into collection view
    var favoriteMovies = [FavoriteMovie]()
    ///Outlet for favorite movie collection view
    @IBOutlet weak var favoriteMovieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Collection view setup
        favoriteMovieCollectionView.delegate = self
        favoriteMovieCollectionView.dataSource = self
        favoriteMovieCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        //
        getFavoriteMovieData()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func getFavoriteMovieData(){
        coreDataService.getFavorites { result in
            switch result{
            case .success(let res):
                DispatchQueue.main.async {
                    
                    
                    self.favoriteMovies = res
                    self.favoriteMovieCollectionView.reloadData()
                }
                
            case.failure(let err):
                print("error", err)
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
