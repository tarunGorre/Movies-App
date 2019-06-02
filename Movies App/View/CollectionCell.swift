//
//  CollectionCell.swift
//  Movies App
//
//  Created by Tarun Gorre on 01.06.19.
//  Copyright © 2019 Tarun Gorre. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    
    func configure(_ movie: Movie) {
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: movie.posterURL)        
    }
}
