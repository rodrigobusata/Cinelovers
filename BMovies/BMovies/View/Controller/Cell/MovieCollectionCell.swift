//
//  MovieCollectionCell.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var genresLb: UILabel!
    @IBOutlet weak var shadowTopView: GradientView!
    @IBOutlet weak var posterIv: UIImageView!
    @IBOutlet weak var releaseDateLb: UILabel!
    @IBOutlet weak var titleLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.releaseDateLb.addShadow()
        self.shadowTopView.gradientLayer = self.shadowTopView.addGradientTop()
        self.posterIv.superview?.addShadow()
        
        self.posterIv.kf.indicatorType = .activity
    }
    
    func bind(_ movie: Movie) {
        self.titleLb.text = movie.title
        self.posterIv.kf.setImage(with: movie.posterURL, placeholder: UIImage.posterDefault)
        
        self.releaseDateLb.text = movie.releaseDate?.formatted
        self.genresLb.text = movie.genresString
    }
}
