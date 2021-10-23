//
//  MovieCollectionViewCell.swift
//  where-is-my-movie
//
//  Created by Paulo Menezes on 19/10/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView.layer.cornerRadius = 26
    }

}
