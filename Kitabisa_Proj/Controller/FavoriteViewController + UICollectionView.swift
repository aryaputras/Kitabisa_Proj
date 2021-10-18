//
//  FavoriteViewController + UICollectionView.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 18/10/21.
//

import Foundation
import UIKit

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: - Count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteMovies.count
    }
    
    //MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        
        let mov = favoriteMovies[indexPath.row]
        cell.titleLabel.text = mov.title
        cell.releaseDateLabel.text = mov.releaseDate
        cell.overviewLabel.text = mov.overview
        cell.imageView.image = UIImage(data: mov.imageData!)
        cell.movieID = Int(mov.movieID)
        
        return cell
    }
    
    
    //MARK: - Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.maxX - 10, height: 190)
    }
    
    
}
