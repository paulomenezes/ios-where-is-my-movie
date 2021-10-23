//
//  EpisodeCollectionViewCell.swift
//  where-is-my-movie
//
//  Created by Paulo Menezes on 20/10/21.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewGradient: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 16
        
        let gradient = CAGradientLayer()
        gradient.frame = viewGradient.bounds
        gradient.colors = [
            UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0),
            
            UIColor(named: "ColorBackground")!.cgColor
        ]
     
        viewGradient.layer.cornerRadius = 16
        viewGradient.layer.insertSublayer(gradient, at: 0)
    }

}
