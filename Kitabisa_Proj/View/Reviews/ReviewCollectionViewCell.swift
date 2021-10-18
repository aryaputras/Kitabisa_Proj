//
//  CollectionViewCell.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 17/10/21.
//

import UIKit
///Class of review collection view cell. used only when displaying movie review. 
class ReviewCollectionViewCell: UICollectionViewCell {
///Label for author username
    @IBOutlet weak var authorNameLabel: UILabel!
///Label for the comment
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        contentLabel.textColor = .systemGray
        // Initialization code
    }

}
