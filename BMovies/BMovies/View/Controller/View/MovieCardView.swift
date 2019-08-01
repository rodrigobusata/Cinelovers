//
//  MovieCardView.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import UIKit

class MovieCardView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var genresLb: UILabel!
    @IBOutlet weak var shadowTopView: GradientView!
    @IBOutlet weak var posterIv: UIImageView!
    @IBOutlet weak var releaseDateLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    func setup() {
        Bundle.main.loadNibNamed("MovieCardView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.frame
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.releaseDateLb.addShadow()
        self.shadowTopView.gradientLayer = self.shadowTopView.addGradientTop()
        self.addShadow()
        
        self.posterIv.kf.indicatorType = .activity
        
        self.unfocus()
    }
    
    func unfocus() {
        self.posterIv.alpha = 0.3
        self.genresLb.alpha = 0
        self.releaseDateLb.alpha = 0
    }
    
    func focus() {
        self.posterIv.alpha = 1
        self.genresLb.alpha = 1
        self.releaseDateLb.alpha = 1
    }
    
    func bind(movie: Movie) {
        self.genresLb.text = movie.genresString
        self.releaseDateLb.text = "\("Release".localized) \(movie.releaseDate?.formatted ?? "")"
        self.posterIv.kf.setImage(with: movie.posterURL, placeholder: UIImage.posterDefault)
    }
}
