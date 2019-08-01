//
//  HighlightViewController.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import UIKit

class HighlightViewController: BaseViewController {
    
    private var presenter = MoviePresenter()
    
    private var movies: [Movie] = []
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var backgroundIv: UIImageView!
    @IBOutlet weak var carouselView: iCarousel!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLb.text = nil
        
        self.carouselView.type = .rotary
        self.carouselView.decelerationRate = 0.5
        
        self.fetchMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.tabBarController?.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.tabBarController?.delegate = nil
    }
    
    private func fetchMovies() {
        self.presenter.getUpcomingMovies() { result in
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .success(let response):
                self.blurView.isHidden = false
                self.movies = response.results ?? []
                self.movies = Array(self.movies.prefix(10))
                
                self.carouselView.reloadData()
                
            case .failure(let error):
                if self.movies.count == 0 {
                    self.tryAgainBtn.isHidden = false
                }
                
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateMovie() {
        let movie = self.movies[self.carouselView.currentItemIndex]
        self.backgroundIv.kf.setImage(with: movie.posterURL, placeholder: nil)
        
        if self.titleLb.text?.isEmpty ?? true {
            self.titleLb.text = movie.title
            
        } else {
            self.titleLb.alpha = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.titleLb.text = movie.title
                self.titleLb.alpha = 1
            }
        }
    }
    
    @IBAction func actionTryAgain(_ sender: UIButton) {
        if self.movies.count == 0 {
            self.activityIndicator.startAnimating()
            sender.isHidden = true
            
            self.fetchMovies()
        }
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        self.carouselView.reloadData()
    }
}

// MARK: iCarousel

extension HighlightViewController: iCarouselDelegate, iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.movies.count
    }
    
    func carousel(_ carousel: iCarousel,
                  viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var cardView: MovieCardView! = view as? MovieCardView
        
        if cardView == nil {
            cardView = MovieCardView(frame: self.carouselItemSize())
        }
        
        if index == carousel.currentItemIndex {
            cardView.focus()
        }

        cardView.bind(movie: self.movies[index])
        
        return cardView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        UIView.animate(withDuration: 0.3) {
            for i in 0..<self.movies.count {
                let cardView = carousel.itemView(at: i) as! MovieCardView
                
                if i == carousel.currentItemIndex {
                    cardView.focus()
                    self.updateMovie()
                    
                } else {
                    cardView.unfocus()
                }
            }
        }
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        DetailViewController.show(from: self, movie: self.movies[index])
    }
    
    func carouselItemSize() -> CGRect {
        let height = UIScreen.main.bounds.height * 0.6
        
        // 2:3 to aspect ratio
        return CGRect(x: 0, y: 0, width: height / (3/2), height: height)
    }
    
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        return carouselItemSize().width
    }
}

// MARK: UITabBarDelegate

extension HighlightViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == self && self.movies.count > 0 {
            self.carouselView.scrollToItem(at: 0, animated: true)
        }
    }
}
