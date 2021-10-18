//
//  DetailViewController + UICollectionView.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 18/10/21.
//

import Foundation
import UIKit



extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    
    //MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionViewCell
        
        let rev = reviews[indexPath.row]
        cell.contentLabel.text = rev.content
        cell.authorNameLabel.text = rev.author
    
        return cell
    }
    
    
    
    //MARK: - Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.maxX - 10, height: 190)
    }
    
    
}
