//
//  MovieCollectionViewCell.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 17/10/21.
//

import UIKit

///Class for movie collection view cell. Used in home and favorite view
class MovieCollectionViewCell: UICollectionViewCell {

    ///Label for movie title
    @IBOutlet weak var titleLabel: UILabel!
    ///Label for movie release date
    @IBOutlet weak var releaseDateLabel: UILabel!
    ///Label for movie overview / synposis
    @IBOutlet weak var overviewLabel: UILabel!
    ///Image view for movie poster
    @IBOutlet weak var imageView: UIImageView!
    

    var movieID = 0
    override func awakeFromNib() {
        
        
        
        super.awakeFromNib()
        
        //Set corner radius
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 10
        
        //Setup cell shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        // Initialization code
        
        overviewLabel.numberOfLines = 0
        overviewLabel.lineBreakMode = .byWordWrapping
        
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        releaseDateLabel.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .light)
        overviewLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
   

}
