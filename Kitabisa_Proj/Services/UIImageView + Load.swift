//
//  UIImageView + Load.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 18/10/21.
//

import Foundation
import UIKit

///List of resolution available for fetching images
enum Resolution{
    case high
    case med
    case low
}

extension UIImageView {
    
    ///Load image from remote URL. Insert path from API response of movie.
    func load(path: String, resolution: Resolution) {
        
        ///Image url
        var imgUrl: URL {
            switch resolution {
            case .high:
                return AppConstants().BASE_IMG_URL_HIGH!
            case .med:
                return AppConstants().BASE_IMG_URL_MED!
            case .low:
                return AppConstants().BASE_IMG_URL_LOW!
            }
        }
        ///Final url
        let finalUrl = imgUrl.appendingPathComponent(path)
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: finalUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
