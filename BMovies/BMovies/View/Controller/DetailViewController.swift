//
//  DetailViewController.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    var movie: Movie!
    
    @IBOutlet weak var shadowTopView: GradientView!
    @IBOutlet weak var backdropIv: UIImageView!
    @IBOutlet weak var posterIv: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var genresTitleLb: UILabel!
    @IBOutlet weak var releaseLb: UILabel!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var originalNameLb: UILabel!
    @IBOutlet weak var overviewLb: UILabel!
    @IBOutlet weak var genresLb: UILabel!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    static func show(from: UIViewController, movie: Movie) {
        let vc = from.storyboard!.instantiateViewController(
            withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.movie = movie
        from.showDetailViewController(vc, sender: from)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.superview?.backgroundColor = .red
        
        self.backdropIv.kf.indicatorType = .activity
        self.posterIv.kf.indicatorType = .activity
        
        self.shadowTopView.gradientLayer = self.shadowTopView.addGradientTop()
        self.backdropIv.superview?.addShadow(opacity: 0.75)
        self.releaseLb.addShadow()
        
        self.updatePaddingTop()
        
        self.bind()
    }
    
    func bind() {
        self.backdropIv.kf.setImage(with: self.movie.backdropURL, placeholder: nil)
        self.posterIv.kf.setImage(with: self.movie.posterURL, placeholder: UIImage.posterDefault)
        
        self.posterIv.superview?.addShadow(opacity: 0.75)
        
        self.titleLb.text = self.movie.title
        self.originalNameLb.text = self.movie.originalTitle
        self.genresTitleLb.text = self.movie.genresString
        
        self.releaseLb.text = "\("Release".localized) \(self.movie.releaseDate?.formatted ?? "")"
        self.nameLb.text = self.movie.title
        self.overviewLb.text = self.movie.overview?.isEmpty ?? true ? "N/A" : self.movie.overview
        
        self.genresLb.text = self.movie.genresString
    }
    
    @IBAction func actionClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionSwipeDown(_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.updatePaddingTop()
    }
    
    private func updatePaddingTop() {
        let paddingTop = min((self.view.frame.width / (5/3)), self.view.frame.height / 2)
        self.scrollview.contentInset = UIEdgeInsets(top: paddingTop + 16, left: 0, bottom: 0, right: 0)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxY: CGFloat = 50
        let y = scrollView.contentOffset.y + self.scrollview.contentInset.top
        
        if y < -maxY {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.posterIv.alpha = max((maxY - y) / maxY, 0)
        
        // Min alpha (0.3)
        self.backdropIv.alpha = self.posterIv.alpha + 0.2
        
        // Delay (4)
        let shadowTopColorAlpha = min(max(y / 4 / maxY, 0), 1)
        self.shadowTopView.backgroundColor = UIColor.backgroundLight.withAlphaComponent(shadowTopColorAlpha)
    }
}
