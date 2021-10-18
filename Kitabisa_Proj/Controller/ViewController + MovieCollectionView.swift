//
//  ViewController + MovieCollectionView.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 17/10/21.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    //MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieListCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        
        let data = finalMoviesData[indexPath.row]
        cell.titleLabel.text = data.title
        cell.releaseDateLabel.text = data.release_date
        cell.overviewLabel.text = data.overview
        cell.imageView.image = data.poster
        cell.movieID = data.id!
        
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapCell(sender:)))
        tapRecognizer.numberOfTapsRequired = 1
        cell.addGestureRecognizer(tapRecognizer)
        
        
        
        
        return cell
    }
    
    //MARK: - Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.maxX - 10, height: 190)
    }
    
    
    
    
    @objc func tapCell(sender: UITapGestureRecognizer?){
        if let tapCell = sender {
            
            if let cellOwner = tapCell.view as? MovieCollectionViewCell {
                
                self.movieID = cellOwner.movieID
                
                performSegue(withIdentifier: "homeToDetail", sender: Any?.self)
                
            }
        }
    }
    
}

